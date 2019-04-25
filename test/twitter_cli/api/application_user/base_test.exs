defmodule TwitterCli.API.ApplicationUser.BaseTest do
  use ExUnit.Case
  alias TwitterCli.API.ApplicationUser.Base

  setup_all do
    {:ok, app_user_config: TwitterCli.Configs.ApplicationUser.configure()}
  end

  test "get with valid params" do
    query = "Fortaleza"
    assert Base.get("/geo/search.json", [{:params, [{"query", query}]}]) === true
  end
end
