defmodule Arctic.StubAdapterTest do
  use ExUnit.Case
  alias Arctic.StubAdapter, as: SUT

  describe "new/1" do
    test "returns struct" do
      assert %SUT{} = SUT.new(conn_pid: nil, module: TestAdapter)
    end
  end

  describe "validate_input/1" do
    test "returns ok when input is the struct" do
      assert SUT.validate_input(%SUT{}) == :ok
    end

    test "raises error when input is invalid" do
      assert_raise ArgumentError, fn -> SUT.validate_input(nil) end
    end
  end
end

defmodule TestAdapter do
  @behaviour Arctic.StubAdapter
  @impl true
  def connect(_) do
    :ok
  end

  @impl true
  def send_request(_, _, _, _) do
    :ok
  end
end
