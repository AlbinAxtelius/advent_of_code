defmodule AdventOfCode do
  def read_input(filename) do
    {:ok, file} = File.read(filename)
    file
  end

  def parse_single_elf(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.trim()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  def solve_part_1(input) do
    String.split(input, "\n\n")
    |> Enum.map(fn x -> parse_single_elf(x) end)
    |> Enum.max()
  end

  def solve_part_2(input) do
    String.split(input, "\n\n")
    |> Enum.map(fn x -> parse_single_elf(x) end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  def main() do
    input = read_input("day_1.in")

    solution_1 = solve_part_1(input)
    solution_2 = solve_part_2(input)

    IO.puts(solution_1)
    IO.puts(solution_2)
  end
end

AdventOfCode.main()
