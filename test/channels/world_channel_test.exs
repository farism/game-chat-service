defmodule Chat.WorldChannelTest do
  use Chat.ChannelCase

  setup do
    user_id = Ecto.UUID.generate()
    subscribe_and_join_topic(user_id, "world:lobby")
  end

  describe "world channel" do

    test "broadcasts message to world:lobby", %{socket: socket} do
      push socket, "message", %{"foo" => "bar"}

      assert_broadcast "message", %{"foo" => "bar"}
    end

    test "broadcasts message to the client", %{socket: socket} do
      broadcast_from! socket, "message", %{"foo" => "bar"}

      assert_push "message", %{"foo" => "bar"}
    end

    test "replys with :ok after leaving ", %{socket: socket} do
      Process.unlink(socket.channel_pid)

      assert_reply leave(socket), :ok
    end

    test "replys with :ok after closing", %{socket: socket} do
      Process.unlink(socket.channel_pid)

      assert close(socket) == :ok
    end

  end
end
