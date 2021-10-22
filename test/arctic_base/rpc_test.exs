defmodule ArcticBase.RpcTest do
  use ExUnit.Case
  alias ArcticBase.Rpc, as: SUT

  describe "new/1" do
    test "returns struct" do
      assert %SUT{name: "FOO"} = SUT.new(name: "FOO")
    end
  end
end
