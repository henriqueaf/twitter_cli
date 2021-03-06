defmodule TwitterCli.API.ApplicationOnly.Authentication do
  import TwitterCli.API.ApplicationOnly.Base
  alias TwitterCli.Configs.ApplicationOnly

  @moduledoc """
  Authenticates application.
  """

  def authenticate do
    %{token_type: "bearer", access_token: access_token} = post(
      "/oauth2/token", # url_part
      "grant_type=client_credentials", # body
      generate_headers() # headers
    )

    ApplicationOnly.set_access_token(access_token)
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
    } = ApplicationOnly.get

    Base.encode64("#{consumer_key}:#{consumer_secret}")
  end
end
