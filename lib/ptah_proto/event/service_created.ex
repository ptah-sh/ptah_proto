defmodule PtahProto.Event.ServiceCreated.Docker do
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

defmodule PtahProto.Event.ServiceCreated do
  alias PtahProto.Event.ServiceCreated.Docker

  @derive Jason.Encoder
  @enforce_keys [:service_id]
  defstruct service_id: 0, docker: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          docker: Docker.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{service_id: payload["service_id"], docker: Docker.parse(payload["docker"])}
  end
end
