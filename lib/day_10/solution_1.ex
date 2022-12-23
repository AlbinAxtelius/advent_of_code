alias AdventOfCode.Helpers

defmodule Solutions.Day_10.Part_1 do
  def should_check_strength?(0), do: false
  def should_check_strength?(20), do: true

  def should_check_strength?(current_cycle) do
    Integer.mod(current_cycle - 20, 40) == 0
  end

  def handle_instruction(["noop"], current), do: current
  def handle_instruction(["addx", value], current), do: String.to_integer(value) + current

  def get_sleep_time(["noop"]), do: 0
  def get_sleep_time(["addx", _]), do: 1

  def run_cycle([], _, _, _, combined_strength), do: combined_strength

  def run_cycle([instruction | rest], 0, current, current_cycle, combined_strength) do
    sleep_time = get_sleep_time(instruction)

    new_strength =
      if should_check_strength?(current_cycle + 1) do
        combined_strength + current * (current_cycle + 1)
      else
        combined_strength
      end

    run_cycle(
      rest,
      sleep_time,
      handle_instruction(instruction, current),
      current_cycle + 1,
      new_strength
    )
  end

  def run_cycle(instructions, sleep, current, current_cycle, combined_strength) do
    new_strength =
      if should_check_strength?(current_cycle + 1) do
        combined_strength + current * (current_cycle + 1)
      else
        combined_strength
      end

    run_cycle(instructions, sleep - 1, current, current_cycle + 1, new_strength)
  end

  def solve(input) do
    initial_value = 1

    instructions = input |> String.split("\n", trim: true)

    instructions
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> run_cycle(1, initial_value, 0, 0)
  end

  def run() do
    input = Helpers.read_input("day_10")

    solution = solve(input)

    IO.puts(solution)
  end
end
