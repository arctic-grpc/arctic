defmodule Arctic.Base.ChannelError do
  defstruct [:reason, :message, :adapter_error]

  @type t :: %__MODULE__{
          reason: any,
          message: String.t(),
          adapter_error: any
        }
end
