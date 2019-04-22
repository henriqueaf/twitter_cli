defmodule TwitterCli do
  @moduledoc """
  Documentation for TwitterCli.
  """

  @doc """
  Initialises and configures TwitterCli with a `consumer_key` and
  `consumer_secret`. If you're not doing anything particularly interesting here,
  it's better to set them as environment variables and use `TwitterCli.configure_app_only/0`

  ## Example
      iex(1)> TwitterCli.configure_app_only("XXXX", "XXXX")
      :ok
  """
  defdelegate configure_app_only(consumer_key, consumer_secret), to: TwitterCli.ApplicationOnly.Config, as: :configure

  @doc """
  Initialises TwitterCli with system environment variables.
  For this to work, set `TWITTER_CONSUMER_KEY` and `TWITTER_CONSUMER_SECRET`.

  ## Example
      TWITTER_CONSUMER_KEY=XXXX TWITTER_CONSUMER_SECRET=XXXX
      iex(1)> TwitterCli.configure_app_only
      :ok
  """
  defdelegate configure_app_only, to: TwitterCli.ApplicationOnly.Config, as: :configure

  @doc """
  Initialises and configures TwitterCli Application user with a `oauth_consumer_key`.
  If you're not doing anything particularly interesting here,
  it's better to set them as environment variables and use `TwitterCli.configure_app_user/0`

  ## Example
      iex(1)> TwitterCli.configure_app_user("XXXX")
      :ok
  """
  defdelegate configure_app_user(oauth_consumer_key), to: TwitterCli.ApplicationUser.Config, as: :configure

  @doc """
  Initialises TwitterCli with system environment variables.
  For this to work, set `TWITTER_CONSUMER_KEY`.

  ## Example
      TWITTER_CONSUMER_KEY=XXXX
      iex(1)> TwitterCli.configure_app_user
      :ok
  """
  defdelegate configure_app_user, to: TwitterCli.ApplicationUser.Config, as: :configure
end
