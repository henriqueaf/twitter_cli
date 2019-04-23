defmodule TwitterCli.API.ApplicationUser.Base do
  @moduledoc """
  Provides general request making and handling functionality (for internal use).
  """
  alias TwitterCli.ApplicationUser.Config

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

  defp handle_response(data) do
    body = Poison.decode!(data.body, keys: :atoms)

    case data do
      %{status_code: 200} ->
        body
      _ ->
        %{errors: [error | _]} = body
        raise(TwitterCli.Error, [code: error.code, message: "#{error.message}"])
    end
  end

  defp build_url(url_part) do
    "#{@base_url}#{url_part}"
  end

  defp generate_authorization_params(method, url, params) do
    credentials = Config.get()
    OAuther.sign(method, url, params, credentials)
  end

  defp generate_authorization_header(authorization_params) do
    OAuther.header(authorization_params)
  end
end
