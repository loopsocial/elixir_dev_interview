
# Firework Elixir Test: ExScheduler

Cron-like job scheduler in few lines of elixir code.

Inspired in [this answer by José Valim](https://stackoverflow.com/a/32097971).

Added cron syntax, with extended support for seconds.

## Interview Assignment
Write tests to assert `ExScheduler.Worker` periodic behaviour in `test/ex_scheduler/worker_test.exs`.

## Installation

```elixir
def deps do
  [
    {:ex_scheduler, "~> 0.1.0"}
  ]
end
```

## Configuration

Cron expressions are evaluated over UTC time.

Add ExScheduler.Worker to `MyApp.Application.start/2`:
```elixir
  children = [
    {ExScheduler.Worker, jobs}
  ]
```

And add the configuration:
```elixir
  defp jobs() do
    [
      %{cron: "* * * * * *", module: Example, function: :hello, args: ["world"]},
      %{cron: "* * * * * *", module: PerformExample},
    ]
  end
```


- When the function is omitted, `perform/0` function is called.
- When `args` are ommited, the function is called with no attributes.

## TODO
- Worker documentation
- https://hex.pm/docs/publish
- Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
  and published on [HexDocs](https://hexdocs.pm)
