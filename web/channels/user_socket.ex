defmodule Chat.UserSocket do
  use Phoenix.Socket

  channel "world:*", Chat.WorldChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(params, socket) do
    IO.inspect params
    {:ok, assign(socket, :user_id, params["username"])}
  end

  def id(_socket), do: nil
end
