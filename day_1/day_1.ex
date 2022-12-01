defmodule AdventOfCode do
  def read_input(filename) do
    {:ok, file} = File.read(filename)
    file
  end

  def parse_input(input) do
    String.split(input, "\n\n")
    |> Enum.map(&parse_single_elf(&1))
  end

  def parse_single_elf(rows) do
    String.split(rows, "\n")
    |> Enum.map(fn row ->
      String.trim(row)
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  def solve_part_1(input) do
    parse_input(input)
    |> Enum.max()
  end

  def solve_part_2(input) do
    parse_input(input)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  def solve_better do
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
