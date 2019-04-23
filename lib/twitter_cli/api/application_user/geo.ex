defmodule TwitterCli.API.ApplicationUser.Geo do
  import TwitterCli.API.ApplicationUser.Base

  @moduledoc """
  Provides access to the `/geo/search.json` area of the Instagram API (for internal use).
  """

  @doc """
  Fetch a list of tags as `%TwitterCli.Models.Geo` from the API who match a query.
  Optionally take an access token.
  """
  def search(query) do
    get("/geo/search.json", [{:params, [{"query", query}]}])
  end
end
