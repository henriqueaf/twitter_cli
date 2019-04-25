defmodule TwitterCli.API.ParserTest do
  use ExUnit.Case
  alias TwitterCli.API.Parser
  alias TwitterCli.Models.Geo

  test "parse_geo without attributes" do
    assert Parser.parse_geo(%{}) === %Geo{}
  end

  test "parse_geo with invalid attributes" do
    assert Parser.parse_geo(%{invalid: "attribute"}) === %Geo{}
  end

  test "parse_geo with valid attributes" do
    assert Parser.parse_geo(%{full_name: "Full Name"}) === %Geo{full_name: "Full Name"}
  end
end
