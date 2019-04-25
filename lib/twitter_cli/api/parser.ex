defmodule TwitterCli.API.Parser do
  def parse_geo(object) do
    struct(TwitterCli.Models.Geo, object)
  end
end
