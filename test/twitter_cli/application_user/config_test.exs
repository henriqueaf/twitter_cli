defmodule TwitterCli.ApplicationUser.ConfigTest do
  use ExUnit.Case
  alias TwitterCli.ApplicationUser.Config

  test "configure with params" do
    assert Config.configure("X", "XX", "XXX", "XXXX") === :ok
    assert Config.get() === %OAuther.Credentials{
      consumer_key: "X",
      consumer_secret: "XX",
      method: :hmac_sha1,
      token: "XXX",
      token_secret: "XXXX"
    }
  end

  test "configure without params" do
    assert Config.configure() === :ok
    assert Config.get() === %OAuther.Credentials{
      consumer_key: nil,
      consumer_secret: nil,
      method: :hmac_sha1,
      token: nil,
      token_secret: nil
    }
  end
end
