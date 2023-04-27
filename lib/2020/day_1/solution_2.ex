defmodule Solutions_2020.Day_1.Part_2 do
  use AdventOfCode.Solution, day: 1, year: 2020

  @spec find_pairs([number()]) :: number()
  def find_pairs(rest) do
    try do
      for x <- rest,
          y <- rest,
          z <- rest,
          x + y + z == 2020 do
        throw(x * y * z)
      end
    catch
      num -> num
    end
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> find_pairs()
  end

  def run() do
    get_input()
    |> solve()
    |> IO.puts()
  end
end
