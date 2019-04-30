defmodule TwitterCli.API.ApplicationUser.Geo do
  import TwitterCli.API.ApplicationUser.Base
  alias TwitterCli.API.Parser

  @moduledoc """
  Provides access to the `/geo/search.json` area of the Twitter API.
  """

  @doc """
  Fetch a list of places as `%TwitterCli.Models.Geo` from the API who match a query.
  """
  def search_by_query(query) do
    get("/geo/search.json", [{:params, [{"query", query}]}])
    |> parse_result()
  end

  def search_by_lat_lng(latitude, longitude) do
    get("/geo/search.json", [{:params, [{"lat", latitude}, {"long", longitude}]}])
    |> parse_result()
  end

  defp parse_result(%{query: _, result: %{places: places}}) do
    Enum.map(places, &Parser.parse_geo/1)
  end

  defp parse_result(%{errors: [error | _]}) do
    raise(TwitterCli.Error, [code: error.code, message: "#{error.message}"])
  end
end
