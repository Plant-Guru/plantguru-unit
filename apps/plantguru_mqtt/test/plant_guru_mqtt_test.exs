defmodule PlantGuruMqttTest do
  use ExUnit.Case
  doctest PlantGuruMqtt

  test "greets the world" do
    assert PlantGuruMqtt.hello() == :world
  end
end
