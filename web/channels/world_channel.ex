defmodule Chat.WorldChannel do
  use Chat.Web, :channel
  # use Guardian.Channel

  alias Chat.Presence

  def join("world:lobby", message, socket) do
    IO.puts "==============="
    IO.inspect message
    IO.puts "==============="
    send(self(), {:after_join, message})

    {:ok, socket}
  end

  def handle_info({:after_join, msg}, socket) do
    track(socket)
    # send_presence_state(socket)

    {:noreply, socket}
  end

  def terminate({:shutdown, :left}, socket) do
    # untrack(socket)

    {:noreply, socket}
  end

  def terminate({:shutdown, :closed}, socket) do
    # untrack(socket)

    {:noreply, socket}
  end

  def handle_in("new:msg", params, socket) do
    broadcast! socket, "new:msg", params

    {:noreply, socket}
  end

  defp track(socket) do
    Presence.track(socket, socket.assigns.user_id, %{
      online_at: :os.system_time(:milli_seconds)
    })
  end

  defp untrack(socket) do
    Presence.untrack(socket, socket.assigns.guardian_default_claims["sub"])
  end

  defp send_presence_state(socket) do
    push socket, "presence_state", Presence.list(socket)
  end

end
