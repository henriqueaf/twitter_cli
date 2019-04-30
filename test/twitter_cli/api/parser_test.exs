defmodule TwitterCli.API.ParserTest do
  use ExUnit.Case
  alias TwitterCli.API.Parser
  alias TwitterCli.Models.{Geo, Trend}

  test "parse_geo without attributes" do
    assert Parser.parse_geo(%{}) === %Geo{}
  end

  test "parse_geo with invalid attributes" do
    assert Parser.parse_geo(%{invalid: "attribute"}) === %Geo{}
  end

  test "parse_geo with valid attributes" do
    assert Parser.parse_geo(%{full_name: "Full Name"}) === %Geo{full_name: "Full Name"}
  end

  test "parse_trend without attributes" do
    assert Parser.parse_trend(%{}) === %Trend{}
  end

  test "parse_trend with invalid attributes" do
    assert Parser.parse_trend(%{invalid: "attribute"}) === %Trend{}
  end

  test "parse_trend with valid attributes" do
    assert Parser.parse_trend(%{tweet_volume: 40211}) === %Trend{tweet_volume: 40211}
  end
end
