defmodule TwitterCli.API.Trends do
  import TwitterCli.API.ApplicationUser.Base
  alias TwitterCli.API.Parser

  @moduledoc """
  Provides access to the `/trends/place.json` area of the Twitter API.
  """

  @doc """
  Fetch a list of tags as `%TwitterCli.Models.Trend` from the API who match a query.
  """
  def search(woeid \\ 1) do
    get("/trends/place.json", [{:params, [{"id", woeid}]}])
    |> parse_result()
  end

  defp parse_result([%{as_of: _, created_at: _, locations: [%{name: _, woeid: _}], trends: trends}]) do
    Enum.map(trends, &Parser.parse_trend/1)
  end
end
