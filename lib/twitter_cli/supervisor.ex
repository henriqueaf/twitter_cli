defmodule TwitterCli.Supervisor do
  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    children = case args do
      [env: :prod] -> []
      [env: :test] -> [{Plug.Cowboy, scheme: :http, plug: TwitterCli.MockServer, options: [port: 8081]}]
      [env: :dev] -> []
      [_] -> []
    end

    opts = [strategy: :one_for_one]
    Supervisor.init(children, opts)
  end
end
