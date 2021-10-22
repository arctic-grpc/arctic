defmodule ArcticBase.ServiceTest do
  use ExUnit.Case
  alias ArcticBase.Service, as: SUT

  describe "new/1" do
    test "returns struct" do
      assert %SUT{name: "foo.Bar"} = SUT.new(name: "foo.Bar")
    end
  end

  describe "rpc macro" do
    test "add rpc struct by calling rpc macro" do
      defmodule FirstTry do
        use ArcticBase.Service, name: "foo.Bar"

        rpc(
          "Get",
          MyNoneExistingReq,
          MyNoneExistingRes,
          alias: :get,
          description: "not sure"
        )
      end

      assert FirstTry.definition() == %ArcticBase.Service{
               name: "foo.Bar",
               rpc_calls: [
                 %ArcticBase.Rpc{
                   alias: :get,
                   description: "not sure",
                   name: "Get",
                   request: MyNoneExistingReq,
                   response: MyNoneExistingRes
                 }
               ]
             }
    end
  end
end
