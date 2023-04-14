defmodule Solutions_2020.Day_4.PassportValidator do
  @allowed_eye_colors ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  @spec field_valid?({:byr, String.t()}) :: boolean
  def field_valid?({:byr, value}) do
    Enum.member?(1920..2002, String.to_integer(value))
  end

  @spec field_valid?({:iyr, String.t()}) :: boolean
  def field_valid?({:iyr, value}) do
    Enum.member?(2010..2020, String.to_integer(value))
  end

  @spec field_valid?({:eyr, String.t()}) :: boolean
  def field_valid?({:eyr, value}) do
    Enum.member?(2020..2030, String.to_integer(value))
  end

  @spec field_valid?({:hgt, String.t()}) :: boolean
  def field_valid?({:hgt, value}) do
    case Regex.run(~r/(\d+)(\w+)/, value) do
      [_, height, "cm"] -> Enum.member?(150..193, String.to_integer(height))
      [_, height, "in"] -> Enum.member?(59..76, String.to_integer(height))
      _ -> false
    end
  end

  @spec field_valid?({:hcl, String.t()}) :: boolean()
  def field_valid?({:hcl, value}) do
    String.match?(value, ~r/^#[0-9a-f]{6}$/)
  end

  @spec field_valid?({:ecl, String.t()}) :: boolean()
  def field_valid?({:ecl, value}) do
    Enum.member?(@allowed_eye_colors, value)
  end

  @spec field_valid?({:pid, String.t()}) :: boolean()
  def field_valid?({:pid, value}) do
    String.match?(value, ~r/^\d{9}$/)
  end

  @spec field_valid?({:cid, String.t()}) :: boolean()
  def field_valid?({:cid, _}) do
    true
  end
end
