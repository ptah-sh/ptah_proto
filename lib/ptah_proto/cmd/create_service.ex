defmodule PtahProto.Cmd.CreateService do
  alias PtahProto.ServiceSpec

  @derive Jason.Encoder
  @enforce_keys [:service_id, :service_spec]
  defstruct service_id: 0, service_spec: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          service_spec: ServiceSpec.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      service_id: payload["service_id"],
      service_spec: ServiceSpec.parse(payload["service_spec"])
    }
  end
end
