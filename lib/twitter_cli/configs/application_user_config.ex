defmodule TwitterCli.ApplicationUserConfig do
  use GenServer

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    oauther_credentials = configure(
      Application.get_env(:twitter_cli, :twitter_consumer_key) || System.get_env("TWITTER_CONSUMER_KEY"),
      Application.get_env(:twitter_cli, :twitter_consumer_secret) || System.get_env("TWITTER_CONSUMER_SECRET"),
      Application.get_env(:twitter_cli, :twitter_access_token) || System.get_env("TWITTER_ACCESS_TOKEN"),
      Application.get_env(:twitter_cli, :twitter_access_token_secret) || System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
    )

    {:ok, oauther_credentials}
  end

  defp configure(consumer_key, consumer_secret, token, token_secret) do
    OAuther.credentials(
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      token: token,
      token_secret: token_secret
    )
  end

  def get_config() do
    GenServer.call(__MODULE__, {:get_config})
  end

  # Callbacks

  def handle_call({:get_config}, _from, state) do
    {:reply, state, state}
  end
end
