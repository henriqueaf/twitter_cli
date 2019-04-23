defmodule TwitterCli.API.ApplicationOnly.Authentication do
  import TwitterCli.API.ApplicationOnly.Base
  alias TwitterCli.ApplicationOnly.Config

  @moduledoc """
  Authenticates application.
  """

  def application_only do
    %{token_type: "bearer", access_token: access_token} = post(
      "/oauth2/token", # url_part
      "grant_type=client_credentials", # body
      generate_headers() # headers
    )

    Config.set_access_token(access_token)
  end

  defp generate_headers do
    [
      {"Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"},
      {"Authorization", "Basic #{generate_bearer_token()}"}
    ]
  end

  defp generate_bearer_token do
    %TwitterCli.Models.AppOnlyConfig{
      consumer_key: consumer_key,
      consumer_secret: consumer_secret
    } = Config.get

    Base.encode64("#{consumer_key}:#{consumer_secret}")
  end
end