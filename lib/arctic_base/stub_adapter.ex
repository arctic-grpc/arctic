defmodule ArcticBase.StubAdapter do
  defstruct [:conn_pid, :module]

  @type t :: %__MODULE__{
          conn_pid: pid,
          module: module
        }
  @type service_name :: String.t()
  @type message :: struct

  @callback connect(ArcticBase.Channel.t()) :: :ok
  @callback send_request(ArcticBase.Channel.t(), service_name, ArcticBase.Rpc.t(), message) :: :ok

  @doc false
  def new(args) do
    struct(%__MODULE__{}, args)
  end

  @doc false
  def validate_input(%__MODULE__{}) do
    :ok
  end

  @doc false
  def validate_input(other) do
    raise ArgumentError, "expecting %ArcticBase.StubAdapter{} but got #{inspect(other)}"
  end
end
