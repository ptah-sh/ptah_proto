defmodule PtahProto.Cmd.CreateSwarm.Data do
  defmodule CreateSwarmPtah do
    @enforce_keys [:swarm_id]

    defstruct swarm_id: 0
  end
end

defmodule PtahProto.Cmd.CreateSwarm do
  alias PtahProto.Cmd.CreateSwarm.Data.CreateSwarmPtah

  defstruct ptah: %CreateSwarmPtah{swarm_id: 0}
end
