defmodule ScAgentTest do
  use ExUnit.Case
  doctest ScAgent

  test "greets the world" do
    assert ScAgent.hello() == :world
  end
end
