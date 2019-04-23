defmodule TwitterCli.ApplicationUser.Config do
  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure do
    start_link(
      OAuther.credentials(
        consumer_key: Application.get_env(:twitter_cli, :twitter_consumer_key) || System.get_env("TWITTER_CONSUMER_KEY"),
        consumer_secret: Application.get_env(:twitter_cli, :twitter_consumer_secret) || System.get_env("TWITTER_CONSUMER_SECRET"),
        token: Application.get_env(:twitter_cli, :twitter_access_token) || System.get_env("TWITTER_ACCESS_TOKEN"),
        token_secret: Application.get_env(:twitter_cli, :twitter_access_token_secret) || System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
      )
    )
    :ok
  end

  def configure(consumer_key, consumer_secret, token, token_secret) do
    start_link(
      OAuther.credentials(
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
        token: token,
        token_secret: token_secret
      )
    )
    :ok
  end

  @doc """
  Get the configuration object
  """
  def get do
    Agent.get(__MODULE__, fn config -> config end)
  end

  defp start_link(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end
end
