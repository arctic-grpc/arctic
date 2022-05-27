defmodule Arctic.Service do
  @moduledoc """
  Define gRPC service
  """
  defstruct [:name, :rpc_calls]

  @type t :: %__MODULE__{
          name: String.t(),
          rpc_calls: list(Arctic.Rpc.t())
        }

  defmacro __using__(opts) do
    quote do
      import Arctic.Service, only: [rpc: 4, stream: 1]

      Module.register_attribute(__MODULE__, :rpc_calls, accumulate: true)
      @before_compile Arctic.Service

      @name unquote(opts[:name])
    end
  end

  defmacro __before_compile__(env) do
    name = Module.get_attribute(env.module, :name)
    rpc_calls = Module.get_attribute(env.module, :rpc_calls)

    quote do
      @doc """
      Return definition of #{unquote(env.module)} service
      """
      @spec definition :: Arctic.Service.t()
      def definition do
        %Arctic.Service{
          name: unquote(name),
          rpc_calls: unquote(Macro.escape(rpc_calls))
        }
      end
    end
  end

  @doc """
  Wrap Grpc messages in stream tuple
  """
  def stream(msg) do
    {:stream, msg}
  end

  defmacro rpc(name, request, response, options) do
    quote do
      @rpc_calls %Arctic.Rpc{
        name: unquote(name),
        request: unquote(request),
        response: unquote(response),
        alias: unquote(options[:alias]),
        description: unquote(options[:description])
      }
    end
  end
end
