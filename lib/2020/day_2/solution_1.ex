defmodule Solutions_2020.Day_2.Part_1 do
  use AdventOfCode.Solution, day: 2, year: 2020

  @spec parse_row([String.t()]) :: {Range.t(), String.t(), String.t()}
  def parse_row([range, letter, password]) do
    [start, stop] =
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    {start..stop, String.at(letter, 0), password}
  end

  @spec solve_row(String.t()) :: boolean()
  def solve_row(row) do
    {range, letter, password} = row |> String.split(" ") |> parse_row()

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
    get_input()
    |> solve()
    |> IO.puts()
  end
end
