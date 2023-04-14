alias AdventOfCode.Helpers

defmodule Solutions_2020.Day_4.Part_1 do
  @required_fields [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]
  @optional_fields [:cid]

  @spec parse_passport_fields(String.t()) :: MapSet.t()
  def parse_passport_fields(raw_passport) do
    raw_passport
    |> String.replace("\n", " ")
    |> String.split(" ")
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&List.first/1)
    |> Enum.map(&String.to_atom/1)
    |> Enum.filter(&(&1 not in @optional_fields))
    |> MapSet.new()
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_passport_fields/1)
    |> Enum.filter(&MapSet.equal?(&1, MapSet.new(@required_fields)))
    |> Enum.count()
  end

  def run() do
    Helpers.read_input("day_4", "2020")
    |> solve()
    |> IO.puts()
  end
end
