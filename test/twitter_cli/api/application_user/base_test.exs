defmodule TwitterCli.API.ApplicationUser.BaseTest do
  use ExUnit.Case
  alias TwitterCli.API.ApplicationUser.Base

  setup_all do
    TwitterCli.Configs.ApplicationUser.configure()
    :ok
  end

  test "get with valid params" do
    query = "Fortaleza"
    assert is_map(Base.get("/geo/search.json", [{:params, [{"query", query}]}]))
  end
end
