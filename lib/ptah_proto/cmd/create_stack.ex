defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec do
  @derive Jason.Encoder
  @enforce_keys [:name, :image]
  defstruct name: "", image: "", hostname: ""

  @type t :: %__MODULE__{
          name: String.t(),
          image: String.t(),
          hostname: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{name: payload["name"], image: payload["image"]}
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
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.{ContainerSpec, Network}

  @derive Jason.Encoder
  @enforce_keys [:container_spec, :networks]
  defstruct container_spec: %{}, networks: []

  @type t :: %__MODULE__{
          container_spec: ContainerSpec.t(),
          networks: [Network.t()]
        }

  def parse(%{} = payload) do
    %__MODULE__{
      container_spec: ContainerSpec.parse(payload["container_spec"]),
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
