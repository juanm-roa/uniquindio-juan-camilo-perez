

alias :math, as: Math

defmodule Test do
  @moduledoc """
     Given an integer n, first we represent in binary.
     Then we count the number of ones. We say n has odd parity if the number of one's is odd.
     Otherwise we say n has even parity.
  """

  @doc """
  Get the parity of positive Integer.

  ## Parameters

    - number : positive Integer represent the number in binary
    - init_parity : Integer (0 or 1) represent the init parity

  ## Returns `:invalid_parity, :odd, :even`.

  ## Examples

      iex> Test.getParity(21, 0)
      :odd

      iex> Test.getParity(21, 1)
      :even

      iex> Test.getParity(6, 0)
      :even

      iex> Test.getParity(6, 1)
      :odd

  """
  @spec getParity(Integer, Integer) :: atom
  def getParity(number, init_parity) do
    n_bits =  Math.log(number+1) / Math.log(2)
              |> Math.ceil()
              |> trunc()

    getParity(number, n_bits, init_parity)
  end

  defp getParity(_number, _n_bit, init_parity) when init_parity != 0 and init_parity != 1, do: :invalid_parity

  defp getParity(number, n_bit, init_parity) when n_bit >= 1 do
    new_parity = :erlang.band(number, :erlang.bsl(1, n_bit-1))
                |> :erlang.bsr(n_bit-1)
                |> :erlang.bxor(init_parity)

    getParity(number, n_bit - 1, new_parity)
  end

  defp getParity(_number, n_bit, init_parity) when n_bit < 1,  do: getParity(init_parity)
  defp getParity(0), do: :even
  defp getParity(1), do: :odd

end

alias Test

# number of cases
{n_cases, _} = IO.gets("") |> Integer.parse

Enum.each(1..n_cases, fn(n_case) ->
  #input of cases
  {num, _} = IO.gets("") |> Integer.parse
  parity = Test.getParity(num, 0)
  IO.inspect("case #{n_case}: #{parity}")
end)
