alias AdventOfCode.Helpers

defmodule Solutions.Day_8.Part_1 do
  def is_visible_from(grid, current, :top) do
    column =
      Enum.filter(grid, fn x -> x.x == current.x end) |> Enum.filter(fn x -> x.y < current.y end)

    is_blocked = Enum.any?(column, fn x -> x.value >= current.value end)

    not is_blocked
  end

  def is_visible_from(grid, current, :bottom) do
    column =
      Enum.filter(grid, fn x -> x.x == current.x end) |> Enum.filter(fn x -> x.y > current.y end)

    is_blocked = Enum.any?(column, fn x -> x.value >= current.value end)

    not is_blocked
  end

  def is_visible_from(grid, current, :left) do
    column =
      Enum.filter(grid, fn x -> x.y == current.y end) |> Enum.filter(fn x -> x.x < current.x end)

    is_blocked = Enum.any?(column, fn x -> x.value >= current.value end)

    not is_blocked
  end

  def is_visible_from(grid, current, :right) do
    column =
      Enum.filter(grid, fn x -> x.y == current.y end) |> Enum.filter(fn x -> x.x > current.x end)

    is_blocked = Enum.any?(column, fn x -> x.value >= current.value end)

    not is_blocked
  end

  @spec solve(String.t()) :: number
  def solve(input) do
    grid =
      String.split(input, "\n", trim: true)
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))

    full_grid =
      grid
      |> Enum.map(&Enum.with_index(&1, fn x, i -> {x, i} end))
      |> Enum.with_index(fn x, i -> {x, i} end)
      |> Enum.map(fn {row, row_index} ->
        Enum.map(row, fn {value, col_index} ->
          %{x: col_index, y: row_index, value: value}
        end)
      end)
      |> List.flatten()

    full_grid
    |> Enum.map(fn current ->
      Enum.any?([
        is_visible_from(full_grid, current, :top),
        is_visible_from(full_grid, current, :bottom),
        is_visible_from(full_grid, current, :left),
        is_visible_from(full_grid, current, :right)
      ])
    end)
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end

  def run() do
    input = Helpers.read_input("day_8")

    solution = solve(input)

    IO.puts(solution)
  end
end
