defmodule TwitterCli.Configs.ApplicationOnlyTest do
  use ExUnit.Case
  alias TwitterCli.Configs.ApplicationOnly

  setup_all do
    System.delete_env "TWITTER_CONSUMER_KEY"
    System.delete_env "TWITTER_CONSUMER_SECRET"
    System.delete_env "TWITTER_ACCESS_TOKEN"
    System.delete_env "TWITTER_ACCESS_TOKEN_SECRET"

    :ok
  end

  test "configure with params" do
    assert ApplicationOnly.configure("XXXX", "XXXX") === :ok
    assert ApplicationOnly.get() === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: "XXXX",
      consumer_secret: "XXXX",
      access_token: nil
    }
  end

  test "configure without params" do
    assert ApplicationOnly.configure() === :ok
    assert ApplicationOnly.get() === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: nil,
      consumer_secret: nil,
      access_token: nil
    }
  end

  test "set_access_token" do
    ApplicationOnly.configure() # configure first to start the Agent on start_link
    assert ApplicationOnly.set_access_token("XXX") === :ok
    assert ApplicationOnly.get() === %TwitterCli.Models.AppOnlyConfig{
      consumer_key: nil,
      consumer_secret: nil,
      access_token: "XXX"
    }
  end
end
