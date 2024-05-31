defmodule PtahProto.Cmd.CreateSwarm do
  defstruct swarm_id: 0

  @type t :: %__MODULE__{
          swarm_id: integer()
        }

  def parse(%{} = payload) do
    %__MODULE__{swarm_id: String.to_integer(payload["swarm_id"])}
  end
end
