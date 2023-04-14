alias AdventOfCode.Helpers
alias Solutions_2020.Day_4.PassportValidator

defmodule Solutions_2020.Day_4.Part_2 do
  @required_fields [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]

  @spec parse_passport_fields(String.t()) :: boolean()
  def parse_passport_fields(raw_passport) do
    passport =
      raw_passport
      |> String.replace("\n", " ")
      |> String.split(" ")
      |> Enum.map(&String.split(&1, ":"))
      |> Enum.map(fn [k, v] -> {String.to_atom(k), v} end)
      |> Map.new()

    has_required_fields =
      passport
      |> Map.keys()
      |> Enum.filter(&(&1 in @required_fields))
      |> MapSet.new()
      |> MapSet.equal?(MapSet.new(@required_fields))

    if not has_required_fields do
      false
    else
      passport
      |> Map.to_list()
      |> Enum.map(&PassportValidator.field_valid?/1)
      |> Enum.all?()
    end
  end

  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_passport_fields/1)
    |> Enum.count(& &1)
  end

  def run() do
    Helpers.read_input("day_4", "2020")
    |> solve()
    |> IO.puts()
  end
end
