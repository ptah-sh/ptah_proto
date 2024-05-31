defmodule PtahProto do
  @callback handle_packet(any(), any()) :: {:noreply, any()}

  alias PtahProto.{Cmd, Event}

  def parse("cmd:create_swarm", payload), do: Cmd.CreateSwarm.parse(payload)
  def parse("event:swarm_created", payload), do: Event.SwarmCreated.parse(payload)

  defp pushes() do
    quote do
      def push(socket, %Cmd.CreateSwarm{} = packet),
        do: ptah_push(socket, "cmd:create_swarm", packet)
    end
  end

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
      @behaviour PtahProto

      @impl true
      def handle_in("ptah:" <> name, payload, socket) do
        handle_message(name, payload, socket)
      end

      defp ptah_push(socket, name, packet) do
        Phoenix.Channel.push(socket, "ptah:#{name}", packet)
      end

      unquote(handle_message())
      unquote(pushes())
    end
  end

  defmacro __using__(slipstream_topic: topic) do
    quote do
      @behaviour PtahProto

      @impl Slipstream
      def handle_message(_topic, "ptah:" <> name, payload, socket) do
        handle_message(name, payload, socket)
      end

      defp ptah_push(socket, name, packet) do
        Slipstream.push(socket, unquote(topic), "ptah:#{name}", packet)
      end

      unquote(handle_message())
      unquote(pushes())
    end
  end
end
