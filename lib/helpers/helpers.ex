defmodule AdventOfCode.Helpers do
  @spec read_input(String.t(), String.t()) :: binary
  def read_input(filename, year) do
    filepath = Path.join([__DIR__, "..", year, filename, "input.txt"])

    {:ok, file} = File.read(filepath)
    file
  end

  @spec read_input(String.t()) :: binary
  def read_input(filename) do
    filepath = Path.join([__DIR__, "..", "2022", filename, "input.txt"])

    {:ok, file} = File.read(filepath)
    file
  end
end
