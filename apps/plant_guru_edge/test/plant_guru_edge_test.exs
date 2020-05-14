defmodule PlantGuruUnitTest do
  use ExUnit.Case
  doctest PlantGuruUnit

  test "greets the world" do
    assert PlantGuruUnit.hello() == :world
  end
end
