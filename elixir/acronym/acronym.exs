defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.codepoints
    |> process("")
  end

  def process([], result), do: result

  def process([head|tail], result, add_next \\ false) do
    cond do
      String.match?(head, ~r/[A-Z]/) ->
        result = result <> String.upcase(head)
        process(tail, result)
      head == " " || head == "-" ->
        process(tail, result, true)
      add_next ->
        result = result <> String.upcase(head)
        process(tail, result)
      true ->
        process(tail, result)
    end
  end
end
