defmodule TwitterCli.Configs.ApplicationOnlyTest do
  use ExUnit.Case
  alias TwitterCli.Configs.ApplicationOnly

  test "configure with params" do
    assert ApplicationOnly.configure("XXXX", "XXXX") === :ok
    assert :sys.get_state(ApplicationOnly) === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: "XXXX",
      consumer_secret: "XXXX",
      access_token: nil
    }
  end

  test "configure without params" do
    assert ApplicationOnly.configure() === :ok
    assert :sys.get_state(ApplicationOnly) === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: nil,
      consumer_secret: nil,
      access_token: nil
    }
  end

  test "set_access_token" do
    ApplicationOnly.configure() # configure first to start the Agent on start_link
    assert ApplicationOnly.set_access_token("XXX") === :ok
    assert :sys.get_state(ApplicationOnly) === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: nil,
      consumer_secret: nil,
      access_token: "XXX"
    }
  end
end
