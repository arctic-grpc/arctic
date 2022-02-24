defmodule Arctic.Base.RpcError do
  defstruct [:message, :status]

  @type t :: %__MODULE__{
          message: String.t(),
          status: non_neg_integer
        }
  def exception(args) do
    struct(__MODULE__, args)
  end
end
