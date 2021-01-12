defmodule PbtTest do
  use ExUnit.Case
  use PropCheck

  # Properties
  property "description of whta the property does" do
    forall instance_of_type <- type_generator() do
      # property expression
      boolean(instance_of_type)
    end
  end

  property "finds biggest element" do
    forall x <- non_empty(list(integer())) do
      Pbt.biggest(x) == model_biggest(x)
    end
  end

  property "picks the last number" do
    forall {list, known_last} <- {list(number()), number()} do
      known_list = list ++ [known_last]
      known_last == List.last(known_list)
    end
  end

  property "a sorted list has ordered pairs" do
    forall list <- list(term()) do
      is_ordered(Enum.sort(list))
    end
  end

  property "a sorted list keeps its size" do
    forall l <- list(number()) do
      length(l) == length(Enum.sort(l))
    end
  end

  property "no element added" do
    forall l <- list(number()) do
      sorted = Enum.sort(l)
      Enum.all?(sorted, fn element -> element in l end)
    end
  end

  property "no element deleted" do
    forall l <- list(number()) do
      sorted = Enum.sort(l)
      Enum.all?(l, fn element -> element in sorted end)
    end
  end

  property "symmetric encoding/decoding" do
    forall data <- list({atom(), any()}) do
      encoded = encode(data)
      is_binary(encoded) and data == decode(encoded)
    end
  end

  property "a sorted key value list has ordered pairs" do
    forall list <- list({term(), term()}) do
      is_key_ordered(List.keysort(list, 0))
    end
  end

  # Helpers
  def boolean(_) do
    true
  end

  # Generators
  def type_generator() do
    term()
  end

  # Models
  def model_biggest(list) do
    List.last(Enum.sort(list))
  end

  def is_ordered([a, b | t]) do
    a <= b and is_ordered([b | t])
  end

  # lists with fewer than 2 elements
  def is_ordered(_) do
    true
  end

  def is_key_ordered([{a, _}, {b, _} = btuple | t]) do
    a <= b and is_key_ordered([btuple | t])
  end

  def is_key_ordered(_) do
    true
  end
end
