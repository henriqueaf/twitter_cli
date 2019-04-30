defmodule TwitterCli.API.Parser do
  def parse_geo(object) do
    struct(TwitterCli.Models.Geo, object)
  end

  def parse_trend(object) do
    struct(TwitterCli.Models.Trend, object)
  end
end
