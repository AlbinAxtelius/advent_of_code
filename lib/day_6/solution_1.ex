alias AdventOfCode.Helpers

defmodule Solutions.Day_6.Part_1 do
  @spec check_start_signal([String.t()], [non_neg_integer()], non_neg_integer()) :: [
          non_neg_integer()
        ]
  def check_start_signal(chunk, matches, end_index) do
    block = Enum.take(chunk, 4)

    if length(block) != 4 do
      end_index
    else
      unique_letters_length = MapSet.new(block) |> MapSet.size()
      all_letters_length = length(block)

      if unique_letters_length == all_letters_length do
        end_index
      else
        check_start_signal(Enum.drop(chunk, 1), matches, end_index + 1)
      end
    end
  end

  def solve(input) do
    input
    |> String.codepoints()
    |> check_start_signal([], 4)
  end

  def run() do
    input = Helpers.read_input("day_6")

    solution = solve(input)

    IO.puts(solution)
  end
end
