defmodule PtahProto.Event.ServiceCreated do
  @derive Jason.Encoder
  @enforce_keys [:service_id]
  defstruct service_id: 0

  @type t :: %__MODULE__{
          service_id: integer()
        }
end
