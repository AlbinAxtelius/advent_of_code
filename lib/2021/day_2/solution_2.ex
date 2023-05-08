defmodule Solutions_2021.Day_2.Part_2 do
  use AdventOfCode.Solution, day: 2, year: 2021

  @spec update_position({String.t(), number()}, {number(), number(), number()}) ::
          {number(), number(), number()}
  def update_position({"forward", steps}, {x, y, aim}) do
    {x + steps, y + steps * aim, aim}
  end

  def update_position({"up", steps}, {x, y, aim}) do
    {x, y, aim - steps}
  end

  def update_position({"down", steps}, {x, y, aim}) do
    {x, y, aim + steps}
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [s, n] -> {s, String.to_integer(n)} end)
    |> Enum.reduce({0, 0, 0}, &update_position/2)
    |> Tuple.to_list()
    |> Enum.take(2)
    |> Enum.product()
  end

  def run() do
    get_input()
    |> solve()
    |> IO.puts()
  end
end
