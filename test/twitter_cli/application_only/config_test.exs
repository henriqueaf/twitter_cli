defmodule TwitterCli.ApplicationOnly.ConfigTest do
  use ExUnit.Case
  alias TwitterCli.ApplicationOnly.Config

  test "configure with params" do
    assert Config.configure("XXXX", "XXXX") === :ok
    assert :sys.get_state(Config) === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: "XXXX",
      consumer_secret: "XXXX",
      access_token: nil
    }
  end

  test "configure without params" do
    assert Config.configure() === :ok
    assert :sys.get_state(Config) === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: nil,
      consumer_secret: nil,
      access_token: nil
    }
  end

  test "set_access_token" do
    Config.configure() # configure first to start the Agent on start_link
    assert Config.set_access_token("XXX") === :ok
    assert :sys.get_state(Config) === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: nil,
      consumer_secret: nil,
      access_token: "XXX"
    }
  end
end
