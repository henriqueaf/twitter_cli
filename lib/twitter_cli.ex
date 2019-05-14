defmodule TwitterCli do
  use Application
  alias TwitterCli.API.ApplicationUser.Geo

  def start(_type, _args) do
    TwitterCli.Supervisor.start_link
  end

  @moduledoc """
  Documentation for TwitterCli.
  """

  defdelegate search_geo_by_query(query), to: Geo, as: :search_by_query

  defdelegate search_geo_by_lat_lng(latitude, longitude), to: Geo, as: :search_by_lat_lng
end
