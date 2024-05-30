defmodule PtahProto.Cmd.CreateSwarm do
  defstruct swarm_id: 0

  @type t :: %__MODULE__{
          swarm_id: integer()
        }
end
