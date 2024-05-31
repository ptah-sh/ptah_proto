defmodule PtahProto do
  alias PtahProto.{Cmd, Event}

  def parse("cmd:create_swarm", payload), do: Cmd.CreateSwarm.parse(payload)
  def parse("event:swarm_created", payload), do: Event.SwarmCreated.parse(payload)

  def handle_message(name, payload, socket) do
    packet = __MODULE__.parse(name, payload)

    send(self(), {packet, socket})
  end

  def __using__(:phx_channel) do
    quote do
      use Phoenix.Channel
      @impl true
      def handle_in(name, payload, socket) do
        PtahProto.handle_message(name, payload, socket)
      end
    end
  end

  def __using__(:slipstream) do
    quote do
      use Slipstream

      @impl Slipstream
      def handle_message(_topic, name, payload, socket) do
        PtahProto.handle_message(name, payload, socket)
      end
    end
  end
end
