alias AdventOfCode.Helpers

defmodule Solutions.Day_8.Part_2 do
  def get_scenic_score(grid, current, :top) do
    column =
      Enum.filter(grid, fn x -> x.x == current.x end)
      |> Enum.filter(fn x -> x.y < current.y end)
      |> Enum.sort_by(fn x -> x.y end, :desc)

    blocking_tree = Enum.find(column, fn x -> x.value >= current.value end)

    if blocking_tree == nil do
      length(column)
    else
      (blocking_tree.y - current.y) |> abs()
    end
  end

  def get_scenic_score(grid, current, :bottom) do
    column =
      Enum.filter(grid, fn x -> x.x == current.x end)
      |> Enum.filter(fn x -> x.y > current.y end)
      |> Enum.sort_by(fn x -> x.y end, :asc)

    blocking_tree = Enum.find(column, fn x -> x.value >= current.value end)

    if blocking_tree == nil do
      length(column)
    else
      (blocking_tree.y - current.y) |> abs()
    end
  end

  def get_scenic_score(grid, current, :left) do
    column =
      Enum.filter(grid, fn x -> x.y == current.y end)
      |> Enum.filter(fn x -> x.x < current.x end)
      |> Enum.sort_by(fn x -> x.x end, :desc)

    blocking_tree = Enum.find(column, fn x -> x.value >= current.value end)

    if blocking_tree == nil do
      length(column)
    else
      (blocking_tree.x - current.x) |> abs()
    end
  end

  def get_scenic_score(grid, current, :right) do
    column =
      Enum.filter(grid, fn x -> x.y == current.y end)
      |> Enum.filter(fn x -> x.x > current.x end)
      |> Enum.sort_by(fn x -> x.x end)

    blocking_tree = Enum.find(column, fn x -> x.value >= current.value end)

    if blocking_tree == nil do
      length(column)
    else
      (blocking_tree.x - current.x) |> abs()
    end
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
      Enum.product([
        get_scenic_score(full_grid, current, :top),
        get_scenic_score(full_grid, current, :bottom),
        get_scenic_score(full_grid, current, :left),
        get_scenic_score(full_grid, current, :right)
      ])
    end)
    |> Enum.max()
  end

  def run() do
    input = Helpers.read_input("day_8")

    solution = solve(input)

    IO.puts(solution)
  end
end
