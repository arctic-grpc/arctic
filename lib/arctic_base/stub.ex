defmodule ArcticBase.Stub do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      service_mod = opts[:service]

      Enum.each(service_mod.definition().rpc_calls, fn rpc ->
        func_name = rpc.alias
        request_struct = rpc.request
        response_struct = rpc.response
        service_name = service_mod.definition().name

        @spec unquote(func_name)(ArcticBase.Channel.t(), unquote(request_struct).t(), list) ::
                {:ok, unquote(response_struct).t()} | {:error, ArcticBase.RpcError.t()}
        def unquote(func_name)(channel, %unquote(request_struct){} = request, opts \\ []) do
          channel.stub_module.unary_request(
            channel,
            unquote(Macro.escape(service_name)),
            unquote(Macro.escape(rpc)),
            request
          )
        end
      end)
    end
  end
end
