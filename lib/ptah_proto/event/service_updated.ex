defmodule PtahProto.Event.ServiceUpdated do
  @derive Jason.Encoder
  @enforce_keys [:service_id]
  defstruct service_id: 0

  @type t :: %__MODULE__{
          service_id: integer()
        }

  def parse(%{} = payload) do
    %__MODULE__{service_id: payload["service_id"]}
  end
end
