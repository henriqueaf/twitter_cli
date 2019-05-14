defmodule TwitterCli.API.ApplicationOnly.Tweets do
  import TwitterCli.API.ApplicationOnly.Base
  alias TwitterCli.ApplicationOnlyConfig

  @moduledoc """
  Provides access to the `/search/tweets.json` area of the Instagram API (for internal use).
  """

  @doc """
  Fetch a list of tags as `%TwitterCli.Model.Tweets` from the API who match a query.
  Optionally take an access token.
  """
  def search(query) do
    get("/search/tweets.json", [{:params, %{q: query, lang: "pt", result_type: "popular"}}], generate_headers()).statuses
  end

  defp generate_headers do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{ApplicationOnlyConfig.get_config().access_token}"}
    ]
  end
end
