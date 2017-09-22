defmodule Chat.UserSocketTest do
  use Chat.ChannelCase

  describe "Chat.UserSocket" do

    test "connect returns :error when no auth is passed" do
      result = connect(Chat.UserSocket, %{})

      assert result == :error
    end

    test "connect returns :error when invalid auth is passed" do
      # result = connect(Chat.UserSocket, %{guardian_token: "somebadjwt"})
      #
      # assert result == :error
    end

    test "connect returns {:ok, socket} when valid auth is passed" do
      # user_id = Ecto.UUID.generate()
      # {:ok, jwt, full_claims} = Guardian.encode_and_sign(%Chat.User{id: user_id})
      # result = connect(Chat.UserSocket, %{guardian_token: jwt})
      #
      # assert elem(result, 0) == :ok
    end

  end
end
