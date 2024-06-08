defmodule PtahProto.Event.ConfigCreated.Docker do
  @derive Jason.Encoder
  @enforce_keys [:config_id]
  defstruct config_id: ""

  @type t :: %__MODULE__{
          config_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{config_id: payload["config_id"]}
  end
end

defmodule PtahProto.Event.ConfigCreated do
  alias PtahProto.Event.ConfigCreated.Docker

  @derive Jason.Encoder
  @enforce_keys [:config_id, :docker]
  defstruct config_id: 0, docker: %{}

  @type t :: %__MODULE__{
          config_id: integer(),
          docker: Docker.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{config_id: payload["config_id"], docker: Docker.parse(payload["docker"])}
  end
end
