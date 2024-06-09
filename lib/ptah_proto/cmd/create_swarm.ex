defmodule PtahProto.Cmd.CreateSwarm do
  @enforce_keys [:swarm_id, :advertise_addr]
  @derive Jason.Encoder
  defstruct swarm_id: 0, advertise_addr: ""

  @type t :: %__MODULE__{
          swarm_id: integer(),
          advertise_addr: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{swarm_id: payload["swarm_id"], advertise_addr: payload["advertise_addr"]}
  end
end
