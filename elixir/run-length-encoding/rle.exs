defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.codepoints
    |> encode_list
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> String.codepoints
    |> decode_list
  end

  defp encode_list(list, result \\ "", current_count \\ 1)
  defp encode_list([], result, _), do: result
  defp encode_list([head|tail], result, current_count) do
    cond do
      head == List.first(tail) ->
        encode_list(tail, result, current_count + 1)
      true ->
        new_result = result <> to_string(current_count) <> head
        encode_list(tail, new_result)
    end
  end

  defp decode_list(list, result \\ "", in_progress_num \\ "")
  defp decode_list([], result, _), do: result
  defp decode_list([head|tail], result, in_progress_num) do
    cond do
      List.first(tail) |> String.match?(~r/[0-9]/) ->
        decode_list(tail, result, in_progress_num <> head)
      true ->
        [letter|remaining_list] = tail
        complete_num = String.to_integer(in_progress_num <> head)
        new_result = result <> (String.duplicate(letter, complete_num))
        decode_list(remaining_list, new_result)
    end
  end
end
