defmodule Chat.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      use Phoenix.ChannelTest

      alias Chat.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query


      # The default endpoint for testing
      @endpoint Chat.Endpoint

      def subscribe_and_join_topic(user_id, topic) do
        {:ok, jwt, full_claims} = Guardian.encode_and_sign(%Chat.User{id: user_id})
        {:ok, socket} = connect(Chat.UserSocket, %{guardian_token: jwt})
        {:ok, _, socket} = subscribe_and_join(socket, topic, %{"id" => user_id})
        {:ok, socket: socket}
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Chat.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Chat.Repo, {:shared, self()})
    end

    :ok
  end
end
