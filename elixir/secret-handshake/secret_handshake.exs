defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> parse_jump(code)
    |> parse_close_eyes(code)
    |> parse_double_blink(code)
    |> parse_wink(code)
    |> parse_reverse(code)
  end

  defp parse_wink(result, int) when (int &&& 0b1) == 1, do: ["wink" | result]
  defp parse_wink(result, _), do: result

  defp parse_double_blink(result, int) when (int &&& 0b10) == 2, do: ["double blink" | result]
  defp parse_double_blink(result, _), do: result

  defp parse_close_eyes(result, int) when (int &&& 0b100) == 4, do: ["close your eyes" | result]
  defp parse_close_eyes(result, _), do: result

  defp parse_jump(result, int) when (int &&& 0b1000) == 8, do: ["jump" | result]
  defp parse_jump(result, _), do: result

  defp parse_reverse(result, int) when (int &&& 0b10000) == 16, do: Enum.reverse(result)
  defp parse_reverse(result, _), do: result
end

