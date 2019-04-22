defmodule TwitterCli.ApplicationUser.Config do
  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure do
    start_link(
      %TwitterCli.Models.AppUserConfig{
        oauth_consumer_key: Application.get_env(:twitter_cli, :twitter_consumer_key)
          || System.get_env("TWITTER_CONSUMER_KEY")
      }
    )
    :ok
  end

  def configure(oauth_consumer_key) do
    start_link(
      %TwitterCli.Models.AppUserConfig{
        oauth_consumer_key: oauth_consumer_key
      }
    )
    :ok
  end

  @doc """
  Get the configuration object
  """
  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  @doc """
  Set the key value
  """
  def set(key, value) when key in [:oauth_callback, :oauth_consumer_key, :oauth_token_secret, :oauth_token, :oauth_verifier] do
    Agent.update(__MODULE__, fn config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end

  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
