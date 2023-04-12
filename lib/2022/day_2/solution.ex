alias AdventOfCode.Helpers

defmodule Solutions_2022.Day_2 do
  @string_to_choices %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors
  }

  @inverted_choices %{
    rock: :paper,
    paper: :scissors,
    scissors: :rock
  }

  @scores %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @part2_outcomes %{
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win
  }

  def parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn row ->
      row
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&@string_to_choices[&1])
      |> List.to_tuple()
    end)
  end

  def parse_input_part2(input) do
    String.split(input, "\n")
    |> Enum.map(fn row ->
      row
      |> String.trim()
      |> String.split(" ")
      |> create_choice_tuple()
    end)
  end

  def create_choice_tuple([player1, player2]) do
    case {@string_to_choices[player1], @part2_outcomes[player2]} do
      {value, :lose} -> {value, @inverted_choices[@inverted_choices[value]]}
      {value, :draw} -> {value, value}
      {value, :win} -> {value, @inverted_choices[value]}
    end
  end

  def calculate_score_for_one_round(round) do
    {_, player_choice} = round

    selected_choice_point = @scores[player_choice]

    round_outcome =
      case round do
        {:rock, :rock} -> 3
        {:paper, :paper} -> 3
        {:scissors, :scissors} -> 3
        {:rock, :paper} -> 6
        {:paper, :scissors} -> 6
        {:scissors, :rock} -> 6
        {_, _} -> 0
      end

    round_outcome + selected_choice_point
  end

  def solve_part_1(input) do
    parse_input(input)
    |> Enum.map(&calculate_score_for_one_round(&1))
    |> Enum.sum()
  end

  def solve_part_2(input) do
    parse_input_part2(input)
    |> Enum.map(&calculate_score_for_one_round(&1))
    |> Enum.sum()
  end

  def run() do
    input = Helpers.read_input("day_2")

    solution_1 = solve_part_1(input)
    solution_2 = solve_part_2(input)

    IO.puts(solution_1)
    IO.puts(solution_2)
  end
end
