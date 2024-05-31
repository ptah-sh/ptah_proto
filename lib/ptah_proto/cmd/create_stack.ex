defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.ContainerSpec do
  @derive Jason.Encoder
  @enforce_keys [:name, :image]
  defstruct name: "", image: ""

  @type t :: %__MODULE__{
          name: String.t(),
          image: String.t()
        }
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate.Network do
  @derive Jason.Encoder
  @enforce_keys [:target]
  defstruct target: ""

  @type t :: %__MODULE__{
          target: String.t()
        }
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
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.Mode.Replicated do
  @derive Jason.Encoder
  @enforce_keys [:replicas]
  defstruct replicas: 0

  @type t :: %__MODULE__{
          replicas: integer()
        }
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.Mode do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.Mode.Replicated

  @derive Jason.Encoder
  @enforce_keys [:replicated]
  defstruct replicated: %{}

  @type t :: %__MODULE__{
          replicated: Replicated.t()
        }
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.EndpointSpec.Port do
  defstruct protocol: "", target_port: 0, published_port: 0, published_mode: ""

  @type t :: %__MODULE__{
          protocol: String.t(),
          target_port: integer(),
          published_port: integer(),
          published_mode: String.t()
        }
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec.EndpointSpec do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.EndpointSpec.Port

  @derive Jason.Encoder
  @enforce_keys [:ports]
  defstruct ports: %{}

  @type t :: %__MODULE__{
          ports: [Port.t()]
        }
end

defmodule PtahProto.Cmd.CreateStack.Service.ServiceSpec do
  alias PtahProto.Cmd.CreateStack.Service.ServiceSpec.TaskTemplate

  @derive Jason.Encoder
  @enforce_keys [:name, :task_template]
  defstruct name: "", task_template: %{}

  @type t :: %__MODULE__{
          name: String.t(),
          task_template: TaskTemplate.t()
        }
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
end
