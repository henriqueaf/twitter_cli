defmodule TwitterCli.ApplicationOnlyConfig do
  use GenServer

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    app_only_config = configure(
      Application.get_env(:twitter_cli, :twitter_consumer_key) || System.get_env("TWITTER_CONSUMER_KEY"),
      Application.get_env(:twitter_cli, :twitter_consumer_secret) || System.get_env("TWITTER_CONSUMER_SECRET")
    )

    {:ok, app_only_config}
  end

  def configure(consumer_key, consumer_secret) do
    %TwitterCli.Models.AppOnlyConfig{
      consumer_key: consumer_key,
      consumer_secret: consumer_secret
    }
  end

  @doc """
  Set a global access token
  """
  def set_access_token(token), do: GenServer.cast(__MODULE__, {:set_access_token, token})

  def handle_cast({:set_access_token, token}, state) do
    {:noreply, %{state | :access_token => token}}
  end

  @doc """
  Get the configuration object
  """
  def get_config(), do: GenServer.call(__MODULE__, :get_config)

  def handle_call(:get_config, _from, state) do
    {:reply, state, state}
  end
end
