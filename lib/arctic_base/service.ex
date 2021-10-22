defmodule ArcticBase.Service do
  @moduledoc """
  Define gRPC service
  """
  defstruct [:name, :rpc_calls]

  @type t :: %__MODULE__{
          name: String.t(),
          rpc_calls: list(ArcticBase.Rpc.t())
        }

  @doc false
  def new(args) do
    struct(__MODULE__, args)
  end

  defmacro __using__(opts) do
    quote do
      import ArcticBase.Service, only: [rpc: 4]

      Module.register_attribute(__MODULE__, :rpc_calls, accumulate: true)
      @before_compile ArcticBase.Service

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
      @spec definition :: ArcticBase.Service.t()
      def definition do
        %ArcticBase.Service{
          name: unquote(name),
          rpc_calls: unquote(Macro.escape(rpc_calls))
        }
      end
    end
  end

  defmacro rpc(name, request, response, options) do
    quote do
      @rpc_calls %ArcticBase.Rpc{
        name: unquote(name),
        request: unquote(request),
        response: unquote(response),
        alias: unquote(options[:alias]),
        description: unquote(options[:description])
      }
    end
  end
end
