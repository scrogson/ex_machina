defmodule ExMachina.SequenceTest do
  use ExUnit.Case

  alias ExMachina.Sequence

  setup do
    Agent.update(ExMachina.Sequence, fn(_) -> HashDict.new end)
  end

  test "increments the sequence each time it is called" do
    assert "joe0" == Sequence.next(:name, &"joe#{&1}")
    assert "joe1" == Sequence.next(:name, &"joe#{&1}")
  end

  test "updates different sequences independently" do
    assert "joe0" == Sequence.next(:name, &"joe#{&1}")
    assert "joe1" == Sequence.next(:name, &"joe#{&1}")
    assert 0 == Sequence.next(:month, &(&1))
    assert 1 == Sequence.next(:month, &(&1))
  end
end
