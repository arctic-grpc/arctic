defmodule Arctic.RpcTest do
  use ExUnit.Case
  alias Arctic.Rpc, as: SUT

  describe "new/1" do
    test "returns struct" do
      assert %SUT{name: "FOO"} = SUT.new(name: "FOO")
    end
  end
end
