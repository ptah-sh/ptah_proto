defmodule PtahProto do
  @callback handle_packet(any(), any()) :: {:noreply, any()}

  alias PtahProto.{Cmd, Event}

  def parse("cmd:create_swarm", payload), do: Cmd.CreateSwarm.parse(payload)
  def parse("cmd:create_stack", payload), do: Cmd.CreateStack.parse(payload)
  def parse("cmd:create_config", payload), do: Cmd.CreateConfig.parse(payload)
  def parse("cmd:update_service", payload), do: Cmd.UpdateService.parse(payload)
  def parse("cmd:update_node_labels", payload), do: Cmd.UpdateNodeLabels.parse(payload)
  def parse("cmd:load_caddy_config", payload), do: Cmd.LoadCaddyConfig.parse(payload)
  def parse("cmd:self_upgrade", payload), do: Cmd.SelfUpgrade.parse(payload)
  def parse("event:swarm_created", payload), do: Event.SwarmCreated.parse(payload)
  def parse("event:service_created", payload), do: Event.ServiceCreated.parse(payload)
  def parse("event:config_created", payload), do: Event.ConfigCreated.parse(payload)

  defp pushes() do
    quote do
      def push(socket, %Cmd.CreateSwarm{} = packet),
        do: ptah_proto_push(socket, "cmd:create_swarm", packet)

      def push(socket, %Cmd.CreateStack{} = packet),
        do: ptah_proto_push(socket, "cmd:create_stack", packet)

      def push(socket, %Cmd.CreateConfig{} = packet),
        do: ptah_proto_push(socket, "cmd:create_config", packet)

      def push(socket, %Cmd.UpdateService{} = packet),
        do: ptah_proto_push(socket, "cmd:update_service", packet)

      def push(socket, %Cmd.UpdateNodeLabels{} = packet),
        do: ptah_proto_push(socket, "cmd:update_node_labels", packet)

      def push(socket, %Cmd.LoadCaddyConfig{} = packet),
        do: ptah_proto_push(socket, "cmd:load_caddy_config", packet)

      def push(socket, %Cmd.SelfUpgrade{} = packet),
        do: ptah_proto_push(socket, "cmd:self_upgrade", packet)

      def push(socket, %Event.ConfigCreated{} = packet),
        do: ptah_proto_push(socket, "event:config_created", packet)

      def push(socket, %Event.SwarmCreated{} = packet),
        do: ptah_proto_push(socket, "event:swarm_created", packet)

      def push(socket, %Event.ServiceCreated{} = packet),
        do: ptah_proto_push(socket, "event:service_created", packet)
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

  defmacro __using__(phx_topic: topic) do
    quote do
      @behaviour PtahProto

      @impl true
      def join(unquote(topic), payload, socket) do
        join(Cmd.Join.parse(payload), socket)
      end

      @impl true
      def handle_in("ptah:" <> name, payload, socket) do
        handle_message(name, payload, socket)
      end

      defp ptah_proto_push(socket, name, packet) do
        Phoenix.Channel.push(socket, "ptah:#{name}", packet)
      end

      unquote(handle_message())
      unquote(pushes())
    end
  end

  defmacro __using__(slipstream_topic: topic) do
    quote do
      @behaviour PtahProto

      def push(socket, %Cmd.Join{} = packet) do
        Slipstream.join(socket, unquote(topic), packet)
      end

      @impl Slipstream
      def handle_message(_topic, "ptah:" <> name, payload, socket) do
        {:noreply, socket} = handle_message(name, payload, socket)

        {:ok, socket}
      end

      defp ptah_proto_push(socket, name, packet) do
        Slipstream.push(socket, unquote(topic), "ptah:#{name}", packet)
      end

      unquote(handle_message())
      unquote(pushes())
    end
  end
end
