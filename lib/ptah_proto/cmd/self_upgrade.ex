defmodule PtahProto.Cmd.SelfUpgrade do
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
