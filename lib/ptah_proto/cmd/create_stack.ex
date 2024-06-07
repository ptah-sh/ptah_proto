defmodule PtahProto.Cmd.CreateStack.Service do
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

defmodule PtahProto.Cmd.CreateStack do
  alias PtahProto.Cmd.CreateStack.Service

  @derive Jason.Encoder
  @enforce_keys [:name, :services]
  defstruct name: "", services: []

  @type t :: %__MODULE__{
          name: String.t(),
          services: [Service.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      services: payload["services"] |> Enum.map(&Service.parse/1)
    }
  end
end
