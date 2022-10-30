# Given an integer n, first we represent in binary.
#Then we count the number of ones. We say n has odd parity if the number of one's is odd.
#Otherwise we say n has even parity.

alias :math, as: Math

defmodule Test do
  def getParity(number, n_bit, parity) when n_bit >= 0 do
    value_shift_left = :erlang.band(number, :erlang.bsl(1, n_bit))
    value_bit = :erlang.bsr(value_shift_left, n_bit)
    new_parity = :erlang.bxor(value_bit, parity)

    if n_bit == 0 do
      getParity(new_parity)
    else
      getParity(number, n_bit - 1, new_parity)
    end
  end

  def getParity(parity) do
    if parity == 0 do
      :even
    else
      :odd
    end
  end
end

alias Test

# number of cases
{n_cases, _} = IO.gets("") |> Integer.parse

Enum.each(1..n_cases, fn(n_case) ->
  #input of cases for parity
  {num, _} = IO.gets("") |> Integer.parse
  n_bits = trunc(Math.ceil(Math.log(num+1) / Math.log(2)))
  # number of the bits for represent number
  parity = Test.getParity(num, n_bits-1, 0) #number, number of bits, init parity
  IO.inspect("case #{n_case}: #{parity}");
end)
