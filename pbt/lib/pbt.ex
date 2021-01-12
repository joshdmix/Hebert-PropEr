defmodule Pbt do
  @moduledoc """
  Documentation for `Pbt`.
  """
  def biggest([head | tail]) do
    biggest(tail, head)
  end

  defp biggest([], max) do
    max
  end

  defp biggest([head | tail], max) when head >= max do
    biggest(tail, head)
  end

  defp biggest([head | tail], max) when head < max do
    biggest(tail, max)
  end

  def encode(t), do: :erlang.term_to_binary(t)
  def decode(t), do: :erlang.binary_to_term(t)

  def count_words(text) do
    word_list = String.split(text, " ")
    length(word_list)
  end
end
