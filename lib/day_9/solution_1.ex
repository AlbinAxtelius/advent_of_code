alias AdventOfCode.Helpers

defmodule Solutions.Day_9.Part_1 do
  @type position :: %{x: integer, y: integer}

  @spec need_to_move?(position, position) :: boolean()
  def need_to_move?(point_1, point_2) do
    x_diff = (point_1.x - point_2.x) |> abs()
    y_diff = (point_1.y - point_2.y) |> abs()

    x_diff > 1 or y_diff > 1
  end

  @spec move({String.t(), non_neg_integer()}, {position, position, [position]}) ::
          {position, position, [position]}
  def move({_, 0}, values) do
    values
  end

  def move({"U", moves}, {head, tail, uniq_moves}) do
    new_head = Map.update!(head, :y, fn y -> y + 1 end)
    new_tail = if need_to_move?(new_head, tail), do: head, else: tail

    move({"U", moves - 1}, {
      new_head,
      new_tail,
      [new_tail | uniq_moves]
    })
  end

  def move({"D", moves}, {head, tail, uniq_moves}) do
    new_head = Map.update!(head, :y, fn y -> y - 1 end)
    new_tail = if need_to_move?(new_head, tail), do: head, else: tail

    move({"D", moves - 1}, {
      new_head,
      new_tail,
      [new_tail | uniq_moves]
    })
  end

  def move({"L", moves}, {head, tail, uniq_moves}) do
    new_head = Map.update!(head, :x, fn x -> x - 1 end)
    new_tail = if need_to_move?(new_head, tail), do: head, else: tail

    move({"L", moves - 1}, {
      new_head,
      new_tail,
      [new_tail | uniq_moves]
    })
  end

  def move({"R", moves}, {head, tail, uniq_moves}) do
    new_head = Map.update!(head, :x, fn x -> x + 1 end)
    new_tail = if need_to_move?(new_head, tail), do: head, else: tail

    move({"R", moves - 1}, {
      new_head,
      new_tail,
      [new_tail | uniq_moves]
    })
  end

  def solve(input) do
    initial_head = %{
      x: 1,
      y: 1
    }

    initial_tail = %{
      x: 1,
      y: 1
    }

    initial_state = {
      initial_head,
      initial_tail,
      [initial_tail]
    }

    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [command, moves] = String.split(line, " ", trim: true)
      {command, String.to_integer(moves)}
    end)
    |> Enum.reduce(initial_state, fn move, state ->
      move(move, state)
    end)
    |> elem(2)
    |> Enum.reverse()
    |> Enum.uniq()
    |> length()
  end

  def run() do
    input = Helpers.read_input("day_9")

    solution = solve(input)

    IO.puts(solution)
  end
end
