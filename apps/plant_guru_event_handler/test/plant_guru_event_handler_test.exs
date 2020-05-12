defmodule PlantGuruEventHandlerTest do
  use ExUnit.Case
  doctest PlantGuruEventHandler

  test "greets the world" do
    assert PlantGuruEventHandler.hello() == :world
  end
end
