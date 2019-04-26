defmodule TwitterCli.API.ApplicationUser.BaseTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias TwitterCli.API.ApplicationUser.Base

  setup_all do # Executed once before all tests
    System.put_env "TWITTER_CONSUMER_KEY",        "XXXXXXXXXXXX"
    System.put_env "TWITTER_CONSUMER_SECRET",     "XXXXXXXXXXXX"
    System.put_env "TWITTER_ACCESS_TOKEN",        "XXXXXXXXXXXX"
    System.put_env "TWITTER_ACCESS_TOKEN_SECRET", "XXXXXXXXXXXX"

    TwitterCli.Configs.ApplicationUser.configure()

    :ok
  end

  setup do # Executed before every test
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes", "test/fixture/custom_cassettes")
    ExVCR.Config.filter_url_params(true)
    ExVCR.Config.filter_request_headers("Authorization")
    ExVCR.Config.filter_sensitive_data("personalization_id=[^\"]+", "<REMOVED>")

    :ok
  end

  test "get with valid params" do
    query = "Fortaleza"

    use_cassette "app_user_base_success" do
      result = Base.get("/geo/search.json", [{:params, [{"query", query}]}])
      assert %{
        query: %{params: _, type: _, url: _},
        result: _
      } = result
    end
  end

  test "get with invalid params" do
    use_cassette "app_user_base_error" do
      result = Base.get("/geo/search.json", [{:params, [{"invalid", "whatever"}]}])
      assert %{
        query: %{params: _,type: _, url: _},
        errors: [
          %{code: 12, message: "You must provide valid coordinates, IP address, query, or attributes."}
        ]
      } = result
    end
  end
end
