defmodule ArcticBase.UnaryRequest do
  defstruct [:path, :headers, :body]

  @type t :: %__MODULE__{
          path: String.t(),
          headers: keyword,
          body: :binary
        }

  def create(service_name, rpc, message) do
    # TODO: handle any error?
    {:ok, body, _} = ArcticBase.Message.to_data(message, [])

    headers = [
      {"grpc-timeout", "10S"},
      {"content-type", "application/grpc"},
      {"te", "trailers"}
    ]

    %__MODULE__{
      path: "/#{service_name}/#{rpc.name}",
      headers: headers,
      body: body
    }
  end
end
