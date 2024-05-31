defmodule PtahProto.Cmd.UpdateNodeLabels do
  @enforce_keys [:labels]
  @derive Jason.Encoder
  defstruct labels: %{}

  @type t :: %__MODULE__{
          labels: map()
        }

  def parse(%{} = payload) do
    %__MODULE__{labels: payload["labels"]}
  end
end
