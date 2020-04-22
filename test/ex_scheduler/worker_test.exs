defmodule ExScheduler.WorkerTest do
  use ExUnit.Case
  alias ExScheduler.Worker

  defmodule Hello do
    def perform(), do: IO.puts("Perform!")
    def hello(), do: IO.puts("Hello!")
    def hello(name), do: IO.puts("Hello #{name}!")
  end

  test "use perform/0 function by default" do
    config = [%{cron: "* * * * * *", module: Hello}]
    GenServer.start_link(Worker, config)
    Process.sleep(1050)
  end

  @tag :skip
  test "use function with 0 arity by default" do
    config = [%{cron: "* * * * * *", module: Hello, function: :hello}]
  end

  @tag :skip
  test "use custom function with args" do
    config = [%{cron: "* * * * * *", module: Hello, function: :hello, args: ["world"]}]
  end

  @tag :skip
  test "run every second for 5 times" do
  end

  @tag :skip
  test "run every 2 seconds" do
  end
end
