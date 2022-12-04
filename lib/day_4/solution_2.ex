alias AdventOfCode.Helpers

defmodule Solutions.Day_4.Part_2 do
  @spec get_overlaps([MapSet.t()]) :: non_neg_integer()
  def get_overlaps([set_1, set_2]) do
    set_1
    |> MapSet.intersection(set_2)
    |> MapSet.size()
  end

  @spec parse_section?(String.t()) :: MapSet.t()
  def parse_section?(section) do
    section
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> case do
      [start, stop] -> Range.new(start, stop)
      _ -> raise "Invalid section"
    end
    |> Enum.to_list()
    |> MapSet.new()
  end

  def parse_line(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_section?/1)
    |> get_overlaps()
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  def solve_part_1(input) do
    parse_input(input)
    |> Enum.filter(&(&1 > 0))
    |> Enum.count()
  end

  def run() do
    input = Helpers.read_input("day_4")

    solution_1 = solve_part_1(input)

    IO.puts(solution_1)
  end
end
