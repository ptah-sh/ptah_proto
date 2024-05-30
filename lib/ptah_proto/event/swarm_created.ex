defmodule PtahProto.Event.SwarmCreated.Docker do
  @enforce_keys [:swarm_id]

  defstruct swarm_id: ""

  @type t :: %__MODULE__{
          swarm_id: String.t()
        }
end

defmodule PtahProto.Event.SwarmCreated do
  alias PtahProto.Event.SwarmCreated.Docker

  @enforce_keys [:swarm_id, :docker]

  defstruct swarm_id: 0, docker: nil

  @type t :: %__MODULE__{
          swarm_id: integer(),
          docker: Docker.t()
        }
end
