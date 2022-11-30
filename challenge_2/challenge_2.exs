defmodule Solution do
   @moduledoc """
     compress Strings with consecutive repeated
     characters
   """

   @doc """
     receive a String to compress when exist
     consecutive repeated characters

     ## Parameters

        - msg : String

     ## Returns

        - String

     ## Examples
        iex> Solution.input_msg("aabbcc")
             a2b2c2

        iex> Solution.input_msg("aaabbbbbc")
             a3b5c

   """
  @spec input_msg(msg::String.t()) :: String.t()
  def input_msg(msg) do
     msg
        |> String.trim()
        |> String.split("", trim: true)
        |> comprehension_msg("", 1)
  end

  @spec comprehension_msg(msg::List, last_letter::String.t(), count::Integer) :: String.t()
  defp comprehension_msg([hd | tail], hd, count), do: comprehension_msg(tail, hd, count + 1)
  defp comprehension_msg([hd | tail], last_letter, 1), do: last_letter <> comprehension_msg(tail, hd, 1)

  defp comprehension_msg([hd | tail], last_letter, count) do
    last_letter <> Integer.to_string(count) <> comprehension_msg(tail, hd, 1)
  end

  defp comprehension_msg([], last_letter, 1), do: last_letter
  defp comprehension_msg([], last_letter, count), do: last_letter <> Integer.to_string(count)
end


IO.gets(nil)
    |> Solution.input_msg()
    |> IO.puts()
