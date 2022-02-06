defmodule ArcticBase.ServiceTest do
  use ExUnit.Case
  alias ArcticBase.Service, as: SUT

  describe "new/1" do
    test "returns struct" do
      assert %SUT{name: "foo.Bar"} = SUT.new(name: "foo.Bar")
    end
  end

  describe "rpc macro" do
    test "adds rpc struct by calling rpc macro" do
      defmodule FirstTry do
        use ArcticBase.Service, name: "foo.Bar"

        rpc(
          :Get,
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
                   name: :Get,
                   request: MyNoneExistingReq,
                   response: MyNoneExistingRes
                 }
               ]
             }
    end

    test "compute alias automatically if name is in snake_case" do
      defmodule SecondTry do
        use ArcticBase.Service, name: "foo.Bar"

        rpc(
          :get,
          MyNoneExistingReq,
          MyNoneExistingRes,
          description: "not sure"
        )
      end
    end

    test "returns error when name is not snake_case and alias is missing" do
      defmodule SecondTry do
        use ArcticBase.Service, name: "foo.Bar"

        rpc(
          :get,
          MyNoneExistingReq,
          MyNoneExistingRes,
          description: "not sure"
        )
      end
    end
  end
end
