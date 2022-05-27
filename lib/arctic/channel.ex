defmodule Arctic.Channel do
  defstruct [:schema, :host, :port, :adapter, :codec, :stub_module, :tls_options]

  @type t :: %__MODULE__{
          schema: :http | :https,
          host: String.t(),
          port: non_neg_integer,
          adapter: Arctic.StubAdapter.t(),
          stub_module: module,
          codec: module,
          tls_options: :ssl.tls_option()
        }

  @doc false
  def validate_input(%__MODULE__{}) do
    :ok
  end

  @doc false
  def validate_input(other) do
    raise ArgumentError, "expecting %Arctic.Channel{} but got #{inspect(other)}"
  end

  @doc false
  def put_adapter_conn_pid(channel, conn_pid) do
    put_in(channel, [Access.key(:adapter), Access.key(:conn_pid)], conn_pid)
  end
end
