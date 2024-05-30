defmodule PtahProto.Event.SwarmCreated.Data do
  defmodule PtahData do
    @enforce_keys [:swarm_id]

    defstruct swarm_id: 0
  end

  defmodule DockerData do
    @enforce_keys [:swarm_id]

    defstruct swarm_id: ""
  end
end

defmodule PtahProto.Event.SwarmCreated do
  alias PtahProto.Event.SwarmCreated.Data.PtahData
  alias PtahProto.Event.SwarmCreated.Data.DockerData

  defstruct ptah: %PtahData{swarm_id: 0}, docker: %DockerData{swarm_id: ""}
end
