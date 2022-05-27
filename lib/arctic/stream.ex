defmodule Arctic.Stream do
  defstruct [:ref, :stream_reader_pid, :request_stream_pid]

  @type t :: %__MODULE__{ref: reference, stream_reader_pid: pid, request_stream_pid: nil | pid}
  @type response_msg(reply) ::
          {:response, reference, {:ok, reply} | {:error, Arctic.RpcError.t()}}
  @type final_msg :: {:done, reference}
  def new(ref, stream_reader_pid, request_stream_pid \\ nil) do
    %__MODULE__{
      ref: ref,
      stream_reader_pid: stream_reader_pid,
      request_stream_pid: request_stream_pid
    }
  end
end
