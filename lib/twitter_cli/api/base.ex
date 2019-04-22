defmodule TwitterCli.API.Base do
  @moduledoc """
  Provides general request making and handling functionality (for internal use).
  """

  @base_url "https://api.twitter.com"
  @api_version "1.1"

  @doc """
  General HTTP `GET` request function. Takes a url part,
  and optionally a token, data Map and list of params.
  """
  def get(url_part, options \\ [], headers \\ [], body \\ "") do
    url = build_url_with_version(url_part)

    HTTPoison.request!(:get, url, body, headers, options)
      |> handle_response
  end

  @doc """
  General HTTP `POST` request function. Takes a url part,
  and optionally a token, data Map and list of params.
  """
  def post(url_part, body \\ {}, headers \\ []) do
    url_part
      |> build_url
      |> HTTPoison.post!(body, headers)
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

  defp build_url_with_version(url_part) do
    "#{@base_url}/#{@api_version}#{url_part}"
  end
end
