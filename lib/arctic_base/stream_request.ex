defmodule ArcticBase.StreamRequest do
  defstruct [:path, :headers, :body, :ref, :stream_reader_pid]

  @type t :: %__MODULE__{
          path: String.t(),
          headers: keyword,
          body: :binary,
          ref: reference,
          stream_reader_pid: pid
        }

  def create(service_name, rpc, message, ref, stream_reader_pid) do
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
      body: body,
      ref: ref,
      stream_reader_pid: stream_reader_pid
    }
  end
end
