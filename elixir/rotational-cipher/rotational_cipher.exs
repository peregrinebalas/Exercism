defmodule RotationalCipher do
  @caps ?A..?Z
  @lows ?a..?z
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    for char <- to_charlist(text), into: "" do
      cond do
        char in @caps -> <<rem(char - ?A + shift, 26) + ?A>>
        char in @lows -> <<rem(char - ?a + shift, 26) + ?a>>
        true -> <<char>>
      end
    end
  end
end
