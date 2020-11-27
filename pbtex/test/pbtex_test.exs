defmodule PbtexTest do
  use ExUnit.Case
  use PropCheck

  # Properties
  property "description of what the property does" do
    forall type <- my_type() do
      boolean(type)
  end

  # Helpers
  defp boolean(_) do
    true
  end

  # Generators
  def my_type() do
    term()
  end
end
