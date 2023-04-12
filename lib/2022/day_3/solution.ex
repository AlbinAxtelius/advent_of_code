alias AdventOfCode.Helpers

defmodule Solutions_2022.Day_3 do
  @spec get_letter_priority(String.t()) :: number
  def get_letter_priority(letter) do
    first_letter = String.at(letter, 0)

    # capital letters are 65-90
    # lower case letters are 97-122
    # need to switch offset so that a is 1 and A is 27
    base_offset = if String.upcase(first_letter) == letter, do: 38, else: 96

    String.to_charlist(first_letter)
    |> List.first()
    |> (fn char -> char - base_offset end).()
  end

  def check_duplicates_part_1({head, tail}) do
    MapSet.intersection(head, tail) |> MapSet.to_list() |> List.first()
  end

  def check_duplicates_part_2({rucksack_1, rucksack_2, rucksack_3}) do
    rucksack_1
    |> MapSet.intersection(rucksack_2)
    |> MapSet.intersection(rucksack_3)
    |> MapSet.to_list()
    |> List.first()
  end

  def parse_rucksack_part_1(rucksack) do
    rucksack
    |> String.trim()
    |> String.graphemes()
    |> Enum.chunk_every(String.length(rucksack) |> div(2))
    |> Enum.map(&MapSet.new/1)
    |> List.to_tuple()
    |> check_duplicates_part_1()
    |> get_letter_priority()
  end

  def parse_rucksack_part_2(rucksack) do
    rucksack
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> List.to_tuple()
    |> check_duplicates_part_2()
    |> get_letter_priority()
  end

  def parse_input(input) do
    input
    |> String.split("\n")
  end

  def solve_part_1(input) do
    parse_input(input)
    |> Enum.map(&parse_rucksack_part_1/1)
    |> Enum.sum()
  end

  def solve_part_2(input) do
    parse_input(input)
    |> Enum.chunk_every(3)
    |> Enum.map(&parse_rucksack_part_2/1)
    |> Enum.sum()
  end

  def run() do
    input = Helpers.read_input("day_3")

    solution_1 = solve_part_1(input)
    solution_2 = solve_part_2(input)

    IO.puts(solution_1)
    IO.puts(solution_2)
  end
end
