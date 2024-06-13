defmodule PtahProto.Cmd.UpdateService.Docker do
  @derive Jason.Encoder
  @enforce_keys [:service_id, :auth_config_id]
  defstruct service_id: "", auth_config_id: ""

  @type t :: %__MODULE__{
          service_id: String.t(),
          auth_config_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{service_id: payload["service_id"], auth_config_id: payload["auth_config_id"]}
  end
end

defmodule PtahProto.Cmd.UpdateService do
  alias PtahProto.ServiceSpec
  alias PtahProto.Cmd.UpdateService.Docker

  @derive Jason.Encoder
  @enforce_keys [:service_id, :docker, :service_spec]
  defstruct service_id: 0, docker: %{}, service_spec: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          docker: Docker.t(),
          service_spec: ServiceSpec.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      service_id: payload["service_id"],
      docker: Docker.parse(payload["docker"]),
      service_spec: ServiceSpec.parse(payload["service_spec"])
    }
  end
end
