defmodule Solutions_2020.Day_1.Part_1 do
  use AdventOfCode.Solution, day: 1, year: 2020

  @spec find_pairs(number(), [number()]) :: {number(), number()}
  def find_pairs(base, rest) do
    index =
      rest
      |> Enum.map(&(&1 + base))
      |> Enum.find_index(&(&1 == 2020))

    if index == nil do
      [new_base | new_rest] = rest
      find_pairs(new_base, new_rest)
    else
      {base, Enum.at(rest, index)}
    end
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> (fn [x | y] -> find_pairs(x, y) end).()
    |> Tuple.to_list()
    |> Enum.product()
  end

  def run() do
    get_input()
    |> solve()
    |> IO.puts()
  end
end
