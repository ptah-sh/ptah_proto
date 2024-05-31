defmodule PtahProto do
  @callback handle_packet(any(), any()) :: {:noreply, any()}

  alias PtahProto.{Cmd, Event}

  def parse("cmd:create_swarm", payload), do: Cmd.CreateSwarm.parse(payload)
  def parse("event:swarm_created", payload), do: Event.SwarmCreated.parse(payload)

  defp handle_message() do
    quote do
      def handle_message(name, payload, socket) do
        packet = PtahProto.parse(name, payload)

        handle_packet(packet, socket)
      end
    end
  end

  defmacro __using__(:phx_channel) do
    quote do
      use Phoenix.Channel

      @behaviour PtahProto

      @impl true
      def handle_in(name, payload, socket) do
        handle_message(name, payload, socket)
      end

      unquote(handle_message())
    end
  end

  defmacro __using__(:slipstream) do
    quote do
      use Slipstream

      @behaviour PtahProto

      @impl Slipstream
      def handle_message(_topic, name, payload, socket) do
        PtahProto.handle_message(name, payload, socket)
      end

      unquote(handle_message())
    end
  end
end
