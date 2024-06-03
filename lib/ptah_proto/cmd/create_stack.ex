defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec.Mount.BindOptions do
  @derive Jason.Encoder
  @enforce_keys [:create_mountpoint]
  defstruct create_mountpoint: true

  @type t :: %__MODULE__{
          create_mountpoint: boolean()
        }

  def parse(%{} = payload) do
    %__MODULE__{create_mountpoint: payload["create_mountpoint"]}
  end
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec.Mount do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec.Mount.BindOptions

  @derive Jason.Encoder
  @enforce_keys [:target, :source, :type, :bind_options]
  defstruct target: "", source: "", type: "", bind_options: %{}

  @type t :: %__MODULE__{
          target: String.t(),
          source: String.t(),
          type: String.t(),
          bind_options: BindOptions.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      target: payload["target"],
      source: payload["source"],
      type: payload["type"],
      bind_options: BindOptions.parse(payload["bind_options"])
    }
  end
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec.Mount

  @derive Jason.Encoder
  @enforce_keys [:name, :image, :hostname, :env, :mounts]
  defstruct name: "", image: "", hostname: "", env: [], mounts: []

  @type t :: %__MODULE__{
          name: String.t(),
          image: String.t(),
          hostname: String.t(),
          env: [String.t()],
          mounts: [Mount.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      image: payload["image"],
      hostname: payload["hostname"],
      env: Enum.map(payload["env"], & &1),
      mounts: Enum.map(payload["mounts"], &Mount.parse/1)
    }
  end
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.Placement do
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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.Network do
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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.{
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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.Mode.Replicated do
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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.Mode do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.Mode.Replicated

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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.EndpointSpec.Port do
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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.EndpointSpec do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.EndpointSpec.Port

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

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.{TaskTemplate, Mode, EndpointSpec}

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

defmodule PtahProto.Cmd.CreateStack.Service do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec

  @derive Jason.Encoder
  @enforce_keys [:service_id, :service_spec]
  defstruct service_id: 0, service_spec: %{}

  @type t :: %__MODULE__{
          service_id: integer(),
          service_spec: ServiceSpec.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{
      service_id: payload["service_id"],
      service_spec: ServiceSpec.parse(payload["service_spec"])
    }
  end
end

defmodule PtahProto.Cmd.CreateStack do
  alias PtahProto.Cmd.CreateStack.Service

  @derive Jason.Encoder
  @enforce_keys [:name, :services]
  defstruct name: "", services: []

  @type t :: %__MODULE__{
          name: String.t(),
          services: [Service.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      name: payload["name"],
      services: payload["services"] |> Enum.map(&Service.parse/1)
    }
  end
end
