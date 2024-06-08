defmodule PtahProto.Cmd.CreateConfig do
  @derive Jason.Encoder
  @enforce_keys [:name, :data]
  defstruct name: "", data: %{}

  @type t :: %__MODULE__{
          name: String.t(),
          data: map()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      data: payload["data"]
    }
  end
end
