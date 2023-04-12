alias AdventOfCode.Helpers

defmodule Solutions.Day_18.Part_1 do
  alias Day18.Solution1.Droplet

  @spec tuple_to_string(Tuple.t()) :: String.t()
  def tuple_to_string(tuple) do
    Tuple.to_list(tuple) |> Enum.join(",")
  end

  @spec check_sides(Droplet.t(), [Droplet.t()]) :: Droplet.t()
  def check_sides(droplet, all_droplets) do
    coordinates =
      droplet.id
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> (fn [x, y, z] -> {x, y, z} end).()

    top_coords =
      {elem(coordinates, 0), elem(coordinates, 1) + 1, elem(coordinates, 2)}
      |> tuple_to_string()

    bottom_coords =
      {elem(coordinates, 0), elem(coordinates, 1) - 1, elem(coordinates, 2)}
      |> tuple_to_string()

    left_coords =
      {elem(coordinates, 0) - 1, elem(coordinates, 1), elem(coordinates, 2)}
      |> tuple_to_string()

    right_coords =
      {elem(coordinates, 0) + 1, elem(coordinates, 1), elem(coordinates, 2)}
      |> tuple_to_string()

    front_coords =
      {elem(coordinates, 0), elem(coordinates, 1), elem(coordinates, 2) + 1}
      |> tuple_to_string()

    back_coords =
      {elem(coordinates, 0), elem(coordinates, 1), elem(coordinates, 2) - 1}
      |> tuple_to_string()

    Droplet.new(
      droplet.id,
      Enum.any?(all_droplets, &(&1.id == top_coords)),
      Enum.any?(all_droplets, &(&1.id == bottom_coords)),
      Enum.any?(all_droplets, &(&1.id == left_coords)),
      Enum.any?(all_droplets, &(&1.id == right_coords)),
      Enum.any?(all_droplets, &(&1.id == front_coords)),
      Enum.any?(all_droplets, &(&1.id == back_coords))
    )
  end

  @spec get_number_of_free_sides(Droplet.t()) :: non_neg_integer
  def get_number_of_free_sides(droplet) do
    droplet
    |> Map.drop([:id])
    |> Map.values()
    |> Enum.filter(&(&1 == false))
    |> Enum.count()
  end

  @spec parse_row(String.t()) :: Droplet.t()
  def parse_row(row), do: Droplet.new(row)

  @spec parse_input(String.t()) :: [Droplet.t()]
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
  end

  def solve(input) do
    all_droplets =
      input
      |> parse_input()

    parsed_droplets =
      all_droplets
      |> Enum.map(&check_sides(&1, all_droplets))

    parsed_droplets
    |> Enum.map(&get_number_of_free_sides(&1))
    |> Enum.sum()
  end

  def run() do
    input = Helpers.read_input("day_18")

    solution = solve(input)

    IO.puts(solution)
  end
end

defmodule Day18.Solution1.Droplet do
  defstruct id: "",
            top: false,
            bottom: false,
            left: false,
            right: false,
            front: false,
            back: false

  def new(id) do
    %__MODULE__{id: id}
  end

  def new(id, top, bottom, left, right, front, back) do
    %__MODULE__{
      id: id,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      front: front,
      back: back
    }
  end
end
