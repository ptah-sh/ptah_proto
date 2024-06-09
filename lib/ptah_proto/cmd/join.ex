defmodule PtahProto.Cmd.Join.Swarm do
  @derive Jason.Encoder
  @enforce_keys [:swarm_id, :node_id]
  defstruct swarm_id: "", node_id: ""

  @type t :: %__MODULE__{
          swarm_id: String.t(),
          node_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{swarm_id: payload["swarm_id"], node_id: payload["node_id"]}
  end
end

defmodule PtahProto.Cmd.Join.Docker do
  @derive Jason.Encoder
  @enforce_keys [:platform, :version]
  defstruct platform: "", version: ""

  @type t :: %__MODULE__{
          platform: String.t(),
          version: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{platform: payload["platform"], version: payload["version"]}
  end
end

defmodule PtahProto.Cmd.Join.Agent do
  @derive Jason.Encoder
  @enforce_keys [:version]
  defstruct version: ""

  @type t :: %__MODULE__{
          version: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{version: payload["version"]}
  end
end

defmodule PtahProto.Cmd.Join.Networks.IP do
  @derive Jason.Encoder
  @enforce_keys [:version, :address]
  defstruct version: "", address: ""

  @type t :: %__MODULE__{
          version: String.t(),
          address: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{version: payload["version"], address: payload["address"]}
  end
end

defmodule PtahProto.Cmd.Join.Network do
  @derive Jason.Encoder
  @enforce_keys [:name, :ips]
  defstruct name: "", ips: []

  @type t :: %__MODULE__{
          name: String.t(),
          ips: [PtahProto.Cmd.Join.Networks.IP.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      ips: Enum.map(payload["ips"], &PtahProto.Cmd.Join.Networks.IP.parse/1)
    }
  end
end

defmodule PtahProto.Cmd.Join do
  alias PtahProto.Cmd.Join.{Swarm, Docker, Agent}

  @derive Jason.Encoder
  @enforce_keys [:token, :agent, :mounts_root, :swarm, :docker, :networks]
  defstruct token: "", agent: %{}, mounts_root: "", swarm: %{}, docker: %{}, networks: []

  @type t :: %__MODULE__{
          token: String.t(),
          agent: Agent.t(),
          mounts_root: String.t(),
          swarm: Swarm.t(),
          docker: Docker.t(),
          networks: [PtahProto.Cmd.Join.Network.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      token: payload["token"],
      agent: Agent.parse(payload["agent"]),
      mounts_root: payload["mounts_root"],
      swarm:
        if payload["swarm"] do
          Swarm.parse(payload["swarm"])
        else
          nil
        end,
      docker: Docker.parse(payload["docker"]),
      networks: Enum.map(payload["networks"], &PtahProto.Cmd.Join.Network.parse/1)
    }
  end
end
