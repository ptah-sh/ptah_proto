defmodule PtahProto.Cmd.CreateService.Docker do
  @derive Jason.Encoder
  @enforce_keys [:auth_config_id]
  defstruct auth_config_id: ""

  @type t :: %__MODULE__{
          auth_config_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{auth_config_id: payload["auth_config_id"]}
  end
end

defmodule PtahProto.Cmd.CreateService do
  alias PtahProto.Cmd.CreateService.Docker
  alias PtahProto.ServiceSpec

  @derive Jason.Encoder
  @enforce_keys [:service_id, :service_spec, :docker]
  defstruct service_id: 0, service_spec: %{}, docker: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          service_spec: ServiceSpec.t(),
          docker: Docker.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      service_id: payload["service_id"],
      service_spec: ServiceSpec.parse(payload["service_spec"]),
      docker: Docker.parse(payload["docker"])
    }
  end
end
