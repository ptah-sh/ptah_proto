defmodule PtahProto.Event.SecretCreated.Docker do
  @derive Jason.Encoder
  @enforce_keys [:secret_id]
  defstruct secret_id: ""

  @type t :: %__MODULE__{
          secret_id: String.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{secret_id: payload["secret_id"]}
  end
end

defmodule PtahProto.Event.SecretCreated do
  alias PtahProto.Event.SecretCreated.Docker

  @derive Jason.Encoder
  @enforce_keys [:secret_id, :docker]
  defstruct secret_id: 0, docker: %{}

  @type t :: %__MODULE__{
          secret_id: integer(),
          docker: Docker.t()
        }

  def parse(%{} = payload) do
    %__MODULE__{secret_id: payload["secret_id"], docker: Docker.parse(payload["docker"])}
  end
end
