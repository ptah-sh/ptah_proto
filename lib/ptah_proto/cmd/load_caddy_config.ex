defmodule PtahProto.Cmd.LoadCaddyConfig do
  @derive Jason.Encoder
  @enforce_keys [:config]
  defstruct config: %{}

  @type t :: %__MODULE__{
          config: map()
        }

  def parse(%{} = payload) do
    %__MODULE__{config: payload["config"]}
  end
end
