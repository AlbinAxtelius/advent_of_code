alias AdventOfCode.Helpers

defmodule Solutions.Day_7.Part_1 do
  @path_separator "."

  @spec handle_move(String.t(), {[String.t()], String.t()}) :: {[String.t()], String.t()}
  def handle_move(to_file, {structure, current_pwd}) do
    new_pwd =
      case String.trim(to_file) do
        ".." ->
          current_pwd
          |> String.split(@path_separator)
          |> Enum.drop(-1)
          |> Enum.join(@path_separator)

        dir_name ->
          if current_pwd == "" do
            dir_name
          else
            current_pwd <> @path_separator <> dir_name
          end
      end

    {structure, new_pwd}
  end

  def handle_add_file(file_name, {structure, current_pwd}) do
    new_pwd =
      if current_pwd == "" do
        file_name
      else
        current_pwd <> @path_separator <> file_name
      end

    {[new_pwd | structure], current_pwd}
  end

  @spec handle_row(String.t(), {[String.t()], String.t()}) :: [String.t()]
  def handle_row(row, structure) do
    String.split(row, " ")
    |> case do
      ["$", "cd", to_file] ->
        handle_move(to_file, structure)

      ["$", "ls"] ->
        structure

      ["dir", _] ->
        structure

      [filename, _] ->
        handle_add_file(filename, structure)
    end
  end

  @spec calculate_dirs_size(String.t(), %{String.t() => non_neg_integer()}) :: %{
          String.t() => non_neg_integer()
        }
  def calculate_dirs_size(file, sum_of_dirs) do
    file_size =
      file
      |> String.split(@path_separator)
      |> List.last()
      |> String.to_integer()

    dirs_permutations =
      file
      |> String.split(@path_separator)
      |> Enum.drop(-1)
      |> Enum.reduce(
        {%{}, ""},
        fn dir, acc ->
          {acc, dir_name} = acc

          new_dir_name =
            if dir_name == "" do
              dir
            else
              dir_name <> @path_separator <> dir
            end

          {Map.put(acc, new_dir_name, file_size), new_dir_name}
        end
      )
      |> elem(0)
      |> Map.to_list()
      |> Enum.reduce(sum_of_dirs, fn {dir, size}, acc ->
        Map.update(acc, dir, size, &(&1 + size))
      end)

    dirs_permutations
  end

  @spec parse_commands(binary) :: any
  def parse_commands(input) do
    input
    |> String.split("\n")
    |> Enum.reduce({[], ""}, fn row, structure -> handle_row(row, structure) end)
    |> case do
      {structure, _} -> structure
    end
    |> Enum.reduce(%{}, &calculate_dirs_size(&1, &2))
    |> Map.filter(fn {_, size} -> size < 100_000 end)
    |> Map.values()
    |> Enum.sum()
  end

  def solve(input) do
    parse_commands(input)
  end

  def run() do
    input = Helpers.read_input("day_7")

    solution = solve(input)

    IO.puts(solution)
  end
end
