alias AdventOfCode.Helpers

defmodule Solutions_2020.Day_1 do
  @spec parse_row([String.t()]) :: {Range.t(), String.t(), String.t()}
  def parse_row([range, letter, password]) do
    [start, stop] =
      String.split(range, "-")
      |> Enum.map(&String.to_integer/1)

    {Range.new(start, stop), String.at(letter, 0), password}
  end

  @spec solve_row(String.t()) :: boolean()
  def solve_row(row) do
    {range, letter, password} = String.split(row, " ") |> parse_row()

    letter_counts =
      password
      |> String.graphemes()
      |> Enum.count(&(&1 == letter))

    Enum.member?(range, letter_counts)
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&solve_row/1)
    |> Enum.count(& &1)
  end

  def run() do
    Helpers.read_input("day_2", "2020")
    |> solve()
    |> IO.puts()
  end
end
