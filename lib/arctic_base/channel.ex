defmodule ArcticBase.Channel do
  defstruct [:host, :port, :adapter, :codec, :stub_module]

  @type t :: %__MODULE__{
          host: String.t(),
          port: non_neg_integer,
          adapter: ArcticBase.StubAdapter.t(),
          stub_module: module,
          codec: module
        }

  @doc false
  def new(args) do
    {:ok, struct(__MODULE__, args)}
  end

  @doc false
  def validate_input(%__MODULE__{}) do
    :ok
  end

  @doc false
  def validate_input(other) do
    raise ArgumentError, "expecting %ArcticBase.Channel{} but got #{inspect(other)}"
  end

  @doc false
  def put_adapter_conn_pid(channel, conn_pid) do
    put_in(channel, [Access.key(:adapter), Access.key(:conn_pid)], conn_pid)
  end
end
