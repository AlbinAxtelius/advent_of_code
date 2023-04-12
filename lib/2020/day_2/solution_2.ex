alias AdventOfCode.Helpers

defmodule Solutions_2020.Day_2.Part_2 do
  @spec parse_row([String.t()]) :: {String.t(), String.t(), String.t()}
  def parse_row([range, letter, password]) do
    [start, stop] =
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&(&1 - 1))
      |> Enum.map(&String.at(password, &1))

    {String.at(letter, 0), start, stop}
  end

  @spec solve_row(String.t()) :: boolean()
  def solve_row(row) do
    {letter, first, second} = row |> String.split(" ") |> parse_row()

    if first == second do
      false
    else
      first == letter or second == letter
    end
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
