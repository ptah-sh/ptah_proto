defmodule PtahProto.Cmd.CreateSwarm do
  @enforce_keys [:swarm_id, :listen_addr, :advertise_addr]
  @derive Jason.Encoder
  defstruct swarm_id: 0, listen_addr: "", advertise_addr: ""

  @type t :: %__MODULE__{
          swarm_id: integer(),
          listen_addr: String.t(),
          advertise_addr: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      swarm_id: payload["swarm_id"],
      listen_addr: payload["listen_addr"],
      advertise_addr: payload["advertise_addr"]
    }
  end
end
