defmodule Arctic.ChannelTest do
  use ExUnit.Case
  alias Arctic.Channel, as: SUT

  describe "new/1" do
    test "returns struct" do
      assert {:ok, %SUT{}} = SUT.new(host: "host")
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
