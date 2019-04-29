defmodule TwitterCli.ApplicationUserConfig do
  @doc """
  Set OAuth configuration values and initialise the process
  """
  def configure do
    configure(
      Application.get_env(:twitter_cli, :twitter_consumer_key) || System.get_env("TWITTER_CONSUMER_KEY"),
      Application.get_env(:twitter_cli, :twitter_consumer_secret) || System.get_env("TWITTER_CONSUMER_SECRET"),
      Application.get_env(:twitter_cli, :twitter_access_token) || System.get_env("TWITTER_ACCESS_TOKEN"),
      Application.get_env(:twitter_cli, :twitter_access_token_secret) || System.get_env("TWITTER_ACCESS_TOKEN_SECRET")
    )
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

  @spec start_link(OAuther.Credentials.t()) :: atom
  defp start_link(config) do
    Agent.start_link(fn -> config end, name: __MODULE__)
  end
end
