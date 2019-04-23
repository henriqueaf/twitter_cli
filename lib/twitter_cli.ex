defmodule TwitterCli do
  alias TwitterCli.API.ApplicationUser.Geo

  @moduledoc """
  Documentation for TwitterCli.
  """

  defdelegate search_geo_by_query(query), to: Geo, as: :search_by_query

  defdelegate search_geo_by_lat_lng(latitude, longitude), to: Geo, as: :search_by_lat_lng
end
