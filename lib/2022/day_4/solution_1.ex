alias AdventOfCode.Helpers

defmodule Solutions.Day_4.Part_1 do
  @spec check_is_contained([{integer(), integer()}]) :: boolean
  def check_is_contained([{start_1, end_1}, {start_2, end_2}]) do
    (start_1 <= start_2 and end_1 >= end_2) or (start_2 <= start_1 and end_2 >= end_1)
  end

  @spec parse_section(String.t()) :: {integer(), integer()}
  def parse_section(section) do
    section
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def parse_line(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_section/1)
    |> check_is_contained()
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def solve_part_1(input) do
    parse_input(input)
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def run() do
    input = Helpers.read_input("day_4")

    solution_1 = solve_part_1(input)

    IO.puts(solution_1)
  end
end
