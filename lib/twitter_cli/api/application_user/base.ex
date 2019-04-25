defmodule TwitterCli.API.ApplicationUser.Base do
  @moduledoc """
  Provides general request making and handling functionality (for internal use).
  """
  import TwitterCli.API.Helpers, only: [handle_response: 1]
  alias TwitterCli.Configs.ApplicationUser

  @base_url "https://api.twitter.com/1.1"

  @doc """
  General HTTP `GET` request function. Takes a url part,
  and optionally a token, data Map and list of params.
  """
  def get(url_part, options \\ []) do
    url = build_url(url_part)
    [{:params, params}] = options

    authorization_params = generate_authorization_params("get", url, params)
    {header, _req_params} = generate_authorization_header(authorization_params)

    HTTPoison.get!(url, [header], options)
    |> handle_response
  end

  defp build_url(url_part) do
    "#{@base_url}#{url_part}"
  end

  defp generate_authorization_params(method, url, params) do
    credentials = ApplicationUser.get()
    OAuther.sign(method, url, params, credentials)
  end

  defp generate_authorization_header(authorization_params) do
    OAuther.header(authorization_params)
  end
end
