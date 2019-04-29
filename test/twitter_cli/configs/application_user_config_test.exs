defmodule TwitterCli.ApplicationUserConfigTest do
  use ExUnit.Case
  alias TwitterCli.ApplicationUserConfig

  test "configure with params" do
    assert ApplicationUserConfig.configure("X", "XX", "XXX", "XXXX") === :ok
    assert ApplicationUserConfig.get() === %OAuther.Credentials{
      consumer_key: "X",
      consumer_secret: "XX",
      method: :hmac_sha1,
      token: "XXX",
      token_secret: "XXXX"
    }
  end

  test "configure without params" do
    assert ApplicationUserConfig.configure() === :ok
    assert ApplicationUserConfig.get() === %OAuther.Credentials{
      consumer_key: nil,
      consumer_secret: nil,
      method: :hmac_sha1,
      token: nil,
      token_secret: nil
    }
  end
end
