defmodule PtahProto.Cmd.CreateSecret do
  @derive Jason.Encoder
  @enforce_keys [:secret_id, :name, :data]
  defstruct secret_id: 0, name: "", data: ""

  @type t :: %__MODULE__{
          secret_id: integer(),
          name: String.t(),
          data: any()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      secret_id: payload["secret_id"],
      name: payload["name"],
      data: payload["data"]
    }
  end
end
