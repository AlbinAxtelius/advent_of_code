alias AdventOfCode.Helpers

defmodule AdventOfCode.Solution do
  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [opts: opts] do
      day = Keyword.get(opts, :day)
      year = Keyword.get(opts, :year)

      @spec get_input :: String.t()
      defp get_input() do
        args =
          [unquote(day), unquote(year)]
          |> Enum.map(&Integer.to_string/1)
          |> List.to_tuple()
          |> (fn {day, year} -> ["day_" <> day, year] end).()

        apply(&Helpers.read_input/2, args)
      end
    end
  end
end
