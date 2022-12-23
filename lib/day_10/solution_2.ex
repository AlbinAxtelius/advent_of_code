alias AdventOfCode.Helpers

defmodule Solutions.Day_10.Part_2 do
  @screen_width 40
  @screen_height 6

  def handle_instruction(["noop"], current), do: current
  def handle_instruction(["addx", value], current), do: String.to_integer(value) + current

  def get_sleep_time(["noop"]), do: 0
  def get_sleep_time(["addx", _]), do: 1

  def draw(monitor, current_cycle, current) do
    current_row = Integer.floor_div(current_cycle, @screen_width)

    if should_draw?(current_cycle - @screen_width * current_row, current) do
      List.replace_at(monitor, current_cycle, "█")
    else
      monitor
    end
  end

  def should_draw?(current_cycle, current) do
    left = if current - 1 >= 0, do: current - 1, else: nil
    right = if current + 1 < @screen_width, do: current + 1, else: nil

    [left, current, right]
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.any?(fn x -> x == current_cycle end)
  end

  def run_cycle([], _, _, _, monitor), do: monitor

  def run_cycle([instruction | rest], 0, current, current_cycle, monitor) do
    sleep_time = get_sleep_time(instruction)

    run_cycle(
      rest,
      sleep_time,
      handle_instruction(instruction, current),
      current_cycle + 1,
      draw(monitor, current_cycle, current)
    )
  end

  def run_cycle(instructions, sleep, current, current_cycle, monitor) do
    run_cycle(
      instructions,
      sleep - 1,
      current,
      current_cycle + 1,
      draw(monitor, current_cycle, current)
    )
  end

  def solve(input) do
    initial_value = 1

    empty_monitor =
      1..(@screen_height * @screen_width)
      |> Enum.map(fn _ -> " " end)

    instructions = input |> String.split("\n", trim: true)

    instructions
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> run_cycle(1, initial_value, 0, empty_monitor)
    |> Enum.chunk_every(@screen_width)
    |> Enum.join("\n")
  end

  def run() do
    input = Helpers.read_input("day_10")

    solution = solve(input)

    IO.puts(solution)
  end
end
