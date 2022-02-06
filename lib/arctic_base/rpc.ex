defmodule ArcticBase.Rpc do
  defstruct [:name, :request, :response, :description, :alias]

  @type t :: %__MODULE__{
          name: String.t(),
          request: module,
          response: module,
          description: String.t() | nil,
          alias: atom | nil
        }

  @doc false
  def new(args) do
    struct(__MODULE__, args)
  end

  defmacro __using__() do
  end
end
