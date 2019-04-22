defmodule TwitterCli.Models.AppOnlyConfig do
  defstruct [:consumer_key, :consumer_secret, :access_token]
end

defmodule TwitterCli.Models.AppUserConfig do
  @callback_url "http://localhost:3000"
  defstruct [
    oauth_callback: @callback_url,
    oauth_consumer_key: nil,
    oauth_token_secret: nil,
    oauth_token: nil,
    oauth_verifier: nil
  ]
end
