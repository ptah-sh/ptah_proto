defmodule PtahProto.Cmd.CreateConfig do
  @derive Jason.Encoder
  @enforce_keys [:config_id, :name, :data]
  defstruct config_id: 0, name: "", data: %{}

  @type t :: %__MODULE__{
          config_id: integer(),
          name: String.t(),
          data: map()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      config_id: payload["config_id"],
      name: payload["name"],
      data: payload["data"]
    }
  end
end
