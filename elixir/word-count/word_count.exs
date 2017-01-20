defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> clean
    |> String.downcase
    |> String.split
    |> count_words
  end

  defp clean(sentence) do
    String.replace(sentence, ~r/[:\.,!@\$%\^&_]/, " ")
  end

  defp count_words(word_list) do
    Enum.reduce(word_list, %{}, &update_count/2)
  end

  defp update_count(word, acc) do
    Map.update(acc, word, 1, &(&1 + 1))
  end
end
