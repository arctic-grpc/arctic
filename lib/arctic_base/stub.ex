defmodule ArcticBase.Stub do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      service_mod = opts[:service]

      Enum.each(service_mod.definition().rpc_calls, fn rpc ->
        func_name = rpc.alias
        request_struct = rpc.request
        response_struct = rpc.response
        service_name = service_mod.definition().name

        case response_struct do
          {:stream, response_struct_c} ->
            @spec unquote(func_name)(ArcticBase.Channel.t(), unquote(request_struct).t(), list) ::
                    {:ok, ArcticBase.Stream.t()} | {:error, ArcticBase.RpcError.t()}
            # {:ok, unquote(response_struct_c).t()} | {:error, ArcticBase.RpcError.t()}

            @doc """
            The stream are sent as passive mode to the caller process

            Look for typespec for
             * `ArcticBase.Stream.response_msg(#{response_struct_c}.t())`
             * `ArcticBase.Stream.final_msg`
            """
            def unquote(func_name)(channel, %unquote(request_struct){} = request, opts \\ []) do
              channel.stub_module.stream_request(
                channel,
                unquote(Macro.escape(service_name)),
                unquote(Macro.escape(rpc)),
                request,
                opts
              )
            end

          response_struct_c ->
            @spec unquote(func_name)(ArcticBase.Channel.t(), unquote(request_struct).t(), list) ::
                    {:ok, unquote(response_struct_c).t()} | {:error, ArcticBase.RpcError.t()}
            def unquote(func_name)(channel, %unquote(request_struct){} = request, opts \\ []) do
              channel.stub_module.unary_request(
                channel,
                unquote(Macro.escape(service_name)),
                unquote(Macro.escape(rpc)),
                request
              )
            end
        end
      end)
    end
  end
end
