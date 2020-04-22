
#### Firework Interview Assignment
Write tests to assert `ExScheduler.Worker` periodic behaviour in `test/ex_scheduler/worker_test.exs`.

# ExScheduler

Cron-like job scheduler in few lines of elixir code.  
Inspired in [this answer by José Valim](https://stackoverflow.com/a/32097971).  
Added cron syntax, with extended support for seconds.

## Installation

```elixir
def deps do
  [
    {:ex_scheduler, "~> 0.1.0"}
  ]
end
```

Add ExScheduler.Worker to your supervision tree:
```elixir
  children = [
    {ExScheduler.Worker, jobs}
  ]
```

And the jobs configuration:
```elixir
  defp jobs() do
    [
      %{cron: "* * * * * *", module: Example, function: :hello, args: ["world"]},
      %{cron: "* * * * * *", module: PerformExample},
    ]
  end
```

If using Phoenix Framework, you should pull this configuration from config.exs.

#### Important:
- When the function is omitted, `perform/0` function is called.
- When `args` are ommited, the function is called with no attributes.
- Cron expressions are evaluated over UTC time.

