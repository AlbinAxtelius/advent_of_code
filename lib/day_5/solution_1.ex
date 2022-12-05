alias AdventOfCode.Helpers

defmodule Solutions.Day_5.Part_1 do
  @spec parse_stacks(String.t()) :: binary()
  def parse_stacks(input) do
    [_keys | crates] =
      input
      |> String.split("\n")
      |> Enum.reverse()

    parsed_crates =
      crates
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.chunk_every(&1, 3, 4))
      |> Enum.map(&Enum.map(&1, fn [_, crate, _] -> crate end))

    parsed_crates
    |> Enum.map(fn crate_row ->
      Enum.with_index(crate_row)
      |> Enum.reduce(%{}, fn {crate, index}, acc ->
        Map.put(acc, index + 1, crate)
      end)
    end)
    |> Enum.reduce(%{}, fn crate_map, acc ->
      Map.merge(acc, crate_map, fn _key, old_value, new_value ->
        [old_value | [new_value]]
        |> List.flatten()
        |> Enum.filter(&(&1 != " "))
      end)
    end)
  end

  def move_containers(yard, count, from, to) do
    crates_to_move = Map.get(yard, from) |> Enum.take(-count) |> Enum.reverse()

    yard
    |> Map.update!(from, &Enum.drop(&1, -count))
    |> Map.update!(
      to,
      &Enum.concat(&1, crates_to_move)
    )
  end

  def parse_input(input) do
    [yard_instructions, move_instructions] =
      input
      |> String.split("\n\n")

    initial_yard =
      yard_instructions
      |> parse_stacks()

    move_instructions
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.reduce(initial_yard, fn instruction, yard ->
      case instruction do
        ["move", move, "from", from, "to", to] ->
          move_containers(
            yard,
            String.to_integer(move),
            String.to_integer(from),
            String.to_integer(to)
          )
      end
    end)
    |> Map.values()
    |> Enum.map(&List.last/1)
    |> Enum.join("")
  end

  def solve(input) do
    parse_input(input)
  end

  def run() do
    input = Helpers.read_input("day_5")

    solution_1 = solve(input)

    IO.puts(solution_1)
  end
end
