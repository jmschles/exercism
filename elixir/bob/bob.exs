defmodule Bob do
  def hey(input) do
    cond do
      (input |> String.trim |> String.length) == 0 ->
        "Fine. Be that way!"
      String.ends_with?(input, "?") ->
        "Sure."
      (input |> String.replace(~r/[0-9\W]/, "") |> String.length) == 0 ->
        "Whatever."
      String.upcase(input) == input ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end
