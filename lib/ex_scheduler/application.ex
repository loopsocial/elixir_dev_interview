defmodule ExScheduler.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: ExScheduler.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: ExScheduler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
