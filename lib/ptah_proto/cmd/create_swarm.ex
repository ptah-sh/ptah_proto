defmodule PtahProto.Cmd.CreateSwarm do
  @enforce_keys [:swarm_id]
  @derive Jason.Encoder
  defstruct swarm_id: 0

  @type t :: %__MODULE__{
          swarm_id: integer()
        }

  def parse(%{} = payload) do
    %__MODULE__{swarm_id: payload["swarm_id"]}
  end
end
