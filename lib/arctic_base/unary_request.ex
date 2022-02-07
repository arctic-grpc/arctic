defmodule ArcticBase.UnaryRequest do
  defstruct [:path, :headers, :body]

  def create(service_name, rpc, message) do
    {:ok, body, _} = ArcticBase.Message.to_data(message, [])

    headers = [
      {"grpc-timeout", "10S"},
      {"content-type", "application/grpc"},
      {"te", "trailers"}
    ]

    %__MODULE__{
      path: path = "/#{service_name}/#{rpc.name}",
      headers: headers,
      # TODO: handle any error?
      body: body
    }
  end
end
