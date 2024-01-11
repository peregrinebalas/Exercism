defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.replace(~r/[:!&@$%^]/, sentence, "")
    |> String.trim
    |> String.downcase
    |> String.splitter([" ", ", ", "_"], trim: true)
    |> Enum.group_by(fn x -> x end)
    |> Enum.map(fn {k,v} -> {k, Enum.count(v)} end)
    |> Map.new
  end
end
