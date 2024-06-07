defmodule PtahProto.Cmd.UpdateService.Docker do
  @derive Jason.Encoder
  @enforce_keys [:service_id]
  defstruct service_id: ""

  @type t :: %__MODULE__{
          service_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{service_id: payload["service_id"]}
  end
end

defmodule PtahProto.Cmd.UpdateService do
  alias PtahProto.Cmd.UpdateService.Docker

  @derive Jason.Encoder
  @enforce_keys [:service_id, :docker, :service_spec]
  defstruct service_id: 0, docker: %{}, service_spec: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          docker: Docker.t(),
          service_spec: map()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      service_id: payload["service_id"],
      docker: Docker.parse(payload["docker"]),
      service_spec: payload["service_spec"]
    }
  end
end
