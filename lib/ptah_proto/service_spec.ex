defmodule PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.Env do
  @derive Jason.Encoder
  @enforce_keys [:name, :value]
  defstruct name: "", value: ""

  @type t :: %__MODULE__{
          name: String.t(),
          value: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{name: payload["name"], value: payload["value"]}
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.Mount do
  @derive Jason.Encoder
  @enforce_keys [:target, :source, :type]
  defstruct target: "", source: "", type: ""

  @type t :: %__MODULE__{
          target: String.t(),
          source: String.t(),
          type: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      target: payload["target"],
      source: payload["source"],
      type: payload["type"]
    }
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.File do
  @derive Jason.Encoder
  @enforce_keys [:name]
  defstruct name: ""

  @type t :: %__MODULE__{
          name: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{name: payload["name"]}
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.Secret do
  alias PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.File

  @derive Jason.Encoder
  @enforce_keys [:file]
  defstruct file: %{}

  @type t :: %__MODULE__{
          file: File.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{file: File.parse(payload["file"])}
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.Config do
  alias PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.File

  @derive Jason.Encoder
  @enforce_keys [:file]
  defstruct file: %{}

  @type t :: %__MODULE__{
          file: File.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{file: File.parse(payload["file"])}
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.ContainerSpec do
  alias PtahProto.ServiceSpec.TaskTemplate.ContainerSpec.{Env, Mount, Secret, Config}

  @derive Jason.Encoder
  @enforce_keys [:name, :image, :hostname, :env, :mounts, :secrets, :configs]
  defstruct name: "", image: "", hostname: "", env: [], mounts: [], secrets: [], configs: []

  @type t :: %__MODULE__{
          name: String.t(),
          image: String.t(),
          hostname: String.t(),
          env: [Env.t()],
          mounts: [Mount.t()],
          secrets: [Secret.t()],
          configs: [Config.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      image: payload["image"],
      hostname: payload["hostname"],
      env: Enum.map(payload["env"], &Env.parse/1),
      mounts: Enum.map(payload["mounts"], &Mount.parse/1),
      secrets: Enum.map(payload["secrets"], &Secret.parse/1),
      configs: Enum.map(payload["configs"], &Config.parse/1)
    }
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.Placement do
  @derive Jason.Encoder
  @enforce_keys [:constraints]
  defstruct constraints: []

  @type t :: %__MODULE__{
          constraints: [String.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{constraints: payload["constraints"]}
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate.Network do
  @derive Jason.Encoder
  @enforce_keys [:target]
  defstruct target: "", aliases: []

  @type t :: %__MODULE__{
          target: String.t(),
          aliases: [String.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{target: payload["target"], aliases: Enum.map(payload["aliases"], & &1)}
  end
end

defmodule PtahProto.ServiceSpec.TaskTemplate do
  alias PtahProto.ServiceSpec.TaskTemplate.{
    ContainerSpec,
    Placement,
    Network
  }

  @derive Jason.Encoder
  @enforce_keys [:container_spec, :placement, :networks]
  defstruct container_spec: %{}, placement: %{}, networks: []

  @type t :: %__MODULE__{
          container_spec: ContainerSpec.t(),
          placement: Placement.t(),
          networks: [Network.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      container_spec: ContainerSpec.parse(payload["container_spec"]),
      placement: Placement.parse(payload["placement"]),
      networks: Enum.map(payload["networks"], &Network.parse/1)
    }
  end
end

defmodule PtahProto.ServiceSpec.Mode.Replicated do
  @derive Jason.Encoder
  @enforce_keys [:replicas]
  defstruct replicas: 0

  @type t :: %__MODULE__{
          replicas: integer()
        }

  def parse(%{} = payload) do
    %__MODULE__{replicas: payload["replicas"]}
  end
end

defmodule PtahProto.ServiceSpec.Mode do
  alias PtahProto.ServiceSpec.Mode.Replicated

  @derive Jason.Encoder
  @enforce_keys [:replicated]
  defstruct replicated: %{}

  @type t :: %__MODULE__{
          replicated: Replicated.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{replicated: Replicated.parse(payload["replicated"])}
  end
end

defmodule PtahProto.ServiceSpec.EndpointSpec.Port do
  @derive Jason.Encoder
  @enforce_keys [:protocol, :target_port, :published_port, :published_mode]
  defstruct protocol: "", target_port: 0, published_port: 0, published_mode: ""

  @type t :: %__MODULE__{
          protocol: String.t(),
          target_port: integer(),
          published_port: integer(),
          published_mode: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      protocol: payload["protocol"],
      target_port: payload["target_port"],
      published_port: payload["published_port"],
      published_mode: payload["published_mode"]
    }
  end
end

defmodule PtahProto.ServiceSpec.EndpointSpec do
  alias PtahProto.ServiceSpec.EndpointSpec.Port

  @derive Jason.Encoder
  @enforce_keys [:ports]
  defstruct ports: %{}

  @type t :: %__MODULE__{
          ports: [Port.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      ports: Enum.map(payload["ports"], &Port.parse/1)
    }
  end
end

defmodule PtahProto.ServiceSpec do
  alias PtahProto.ServiceSpec.{TaskTemplate, Mode, EndpointSpec}

  @derive Jason.Encoder
  @enforce_keys [:name, :task_template, :mode, :endpoint_spec]
  defstruct name: "", task_template: %{}, mode: %{}, endpoint_spec: %{}

  @type t :: %__MODULE__{
          name: String.t(),
          task_template: TaskTemplate.t(),
          mode: Mode.t(),
          endpoint_spec: EndpointSpec.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      task_template: TaskTemplate.parse(payload["task_template"]),
      mode: Mode.parse(payload["mode"]),
      endpoint_spec: EndpointSpec.parse(payload["endpoint_spec"])
    }
  end
end
