alias AdventOfCode.Helpers

defmodule Solutions_2020.Day_6.Part_2 do
  @spec solve_group([String.t()]) :: non_neg_integer()
  def solve_group(group) do
    group
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection(&1, &2))
    |> MapSet.size()
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
    |> Enum.map(&solve_group/1)
    |> Enum.sum()
  end

  def run() do
    Helpers.read_input("day_6", "2020")
    |> solve()
    |> IO.puts()
  end
end
