defmodule PtahProto.Cmd.UpdateService do
  @derive Jason.Encoder
  @enforce_keys [:service_id, :service_spec]
  defstruct service_id: 0, service_spec: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          service_spec: map()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      service_id: payload["service_id"],
      service_spec: payload["service_spec"]
    }
  end
end
