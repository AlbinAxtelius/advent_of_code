defmodule Solutions_2021.Day_2.Part_2 do
  use AdventOfCode.Solution, day: 2, year: 2021

  @type position_with_aim :: {number(), number(), number()}

  @spec update_position({String.t(), number()}, position_with_aim) :: position_with_aim
  def update_position({"forward", steps}, {x, y, aim}), do: {x + steps, y + steps * aim, aim}
  def update_position({"up", steps}, {x, y, aim}), do: {x, y, aim - steps}
  def update_position({"down", steps}, {x, y, aim}), do: {x, y, aim + steps}

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [s, n] -> {s, String.to_integer(n)} end)
    |> Enum.reduce({0, 0, 0}, &update_position/2)
    |> Tuple.delete_at(2)
    |> Tuple.product()
  end

  def run() do
    get_input()
    |> solve()
    |> IO.puts()
  end
end
