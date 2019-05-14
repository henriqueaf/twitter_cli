defmodule TwitterCli.Supervisor do
  use Supervisor
  alias TwitterCli.{ApplicationUserConfig, ApplicationOnlyConfig}

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(ApplicationUserConfig, []),
      worker(ApplicationOnlyConfig, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
