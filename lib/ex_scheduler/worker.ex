defmodule ExScheduler.Worker do
  use GenServer

  @default_function :perform
  @default_args []

  def init(jobs) do
    {:ok, jobs |> new_state() |> schedule_next_job()}
  end

  defp new_state(jobs) do
    milliseconds_to_jobs = Enum.map(jobs, &next_run_in_milliseconds!(&1.cron))
    %{jobs: jobs, next_job_index: index_of_minimum(milliseconds_to_jobs)}
  end

  defp schedule_next_job(state) do
    next_job = Enum.at(state.jobs, state.next_job_index)
    next_run_ms = next_run_in_milliseconds!(next_job.cron)
    Process.send_after(self(), :work, next_run_ms)

    state
  end

  defp next_run_in_milliseconds!(cron) do
    is_extended_cron_syntax = cron |> String.split() |> length == 6

    seconds =
      cron
      |> Crontab.CronExpression.Parser.parse!(is_extended_cron_syntax)
      |> Crontab.Scheduler.get_next_run_date!()
      |> Timex.diff(DateTime.utc_now(), :seconds)

    # Add a second to prevent running same job multiple times
    (seconds + 1) * 1000
  end

  defp index_of_minimum(list) do
    list |> Enum.with_index() |> Enum.min_by(fn {elem, _} -> elem end) |> elem(1)
  end

  def handle_info(:work, state) do
    job = Enum.at(state.jobs, state.next_job_index)
    module = Map.get(job, :module)
    function = Map.get(job, :function, @default_function)
    args = Map.get(job, :args, @default_args)

    Task.Supervisor.start_child(ExScheduler.TaskSupervisor, fn ->
      apply(module, function, args)
    end)

    {:noreply, state.jobs |> new_state() |> schedule_next_job()}
  end
end
