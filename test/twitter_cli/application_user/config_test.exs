defmodule TwitterCli.ApplicationUser.ConfigTest do
  use ExUnit.Case
  alias TwitterCli.ApplicationUser.Config

  test "configure with params" do
    assert Config.configure("XXXX") === :ok
    assert :sys.get_state(Config) == %TwitterCli.Models.AppUserConfig{
      oauth_callback: "http://localhost:3000",
      oauth_consumer_key: "XXXX",
      oauth_token_secret: nil,
      oauth_token: nil,
      oauth_verifier: nil
    }
  end

  test "configure without params" do
    assert Config.configure() === :ok
    assert :sys.get_state(Config) === %TwitterCli.Models.AppUserConfig{
      oauth_callback: "http://localhost:3000",
      oauth_consumer_key: nil,
      oauth_token_secret: nil,
      oauth_token: nil,
      oauth_verifier: nil
    }
  end

  test "set key" do
    Config.configure()
    sample_key = %TwitterCli.Models.AppUserConfig{}
      |> Map.from_struct()
      |> Map.keys()
      |> Enum.random()

    assert Config.set(sample_key, "TEST") === :ok

    opts = %{sample_key => "TEST"}
    assert :sys.get_state(Config) === struct(TwitterCli.Models.AppUserConfig, opts)
  end
end
