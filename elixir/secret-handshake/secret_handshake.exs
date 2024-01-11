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
    list = if band(code, 16) == 16, do: [8,4,2,1], else: [1,2,4,8]
    Enum.filter(list, fn x -> band(x, code) == x end)
    |> Enum.map(fn x -> command(x) end)
  end

  defp command(1), do: "wink"
  defp command(2), do: "double blink"
  defp command(4), do: "close your eyes"
  defp command(8), do: "jump"
end
