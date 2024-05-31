defmodule PtahProto.Event.SwarmCreated.Docker do
  @derive Jason.Encoder
  @enforce_keys [:swarm_id]
  defstruct swarm_id: ""

  @type t :: %__MODULE__{
          swarm_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{swarm_id: payload["swarm_id"]}
  end
end

# TODO: rename into "SwarmJoined"? We can then send this exact structure when agent joins the server.
#   In this case, the "swarm_id" should be removed and handled purely on the server side.
defmodule PtahProto.Event.SwarmCreated do
  alias PtahProto.Event.SwarmCreated.Docker

  @derive Jason.Encoder
  @enforce_keys [:swarm_id, :docker]
  defstruct swarm_id: 0, docker: %{}

  @type t :: %__MODULE__{
          swarm_id: integer(),
          docker: Docker.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      swarm_id: payload["swarm_id"],
      docker: Docker.parse(payload["docker"])
    }
  end
end
