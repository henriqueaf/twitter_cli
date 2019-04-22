defmodule TwitterCli.ApplicationOnly.Config do
  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure do
    start_link(
      %TwitterCli.Models.AppOnlyConfig{
        consumer_key: Application.get_env(:twitter_cli, :twitter_consumer_key) || System.get_env("TWITTER_CONSUMER_KEY"),
        consumer_secret: Application.get_env(:twitter_cli, :twitter_consumer_secret) || System.get_env("TWITTER_CONSUMER_SECRET")
      }
    )
    :ok
  end

  def configure(consumer_key, consumer_secret) do
    start_link(
      %TwitterCli.Models.AppOnlyConfig{
        consumer_key: consumer_key,
        consumer_secret: consumer_secret
      }
    )
    :ok
  end

  @doc """
  Set a global access token
  """
  def set_access_token(token) do
    set(:access_token, token)
  end

  @doc """
  Get the configuration object
  """
  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  defp set(key, value) do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
