defmodule AdventOfCode.Helpers do
  def read_input(filename) do
    filepath = Path.join([__DIR__, "..", filename, "input.txt"])
    {:ok, file} = File.read(filepath)
    file
  end
end
