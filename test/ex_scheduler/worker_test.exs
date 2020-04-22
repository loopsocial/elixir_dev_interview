defmodule ExScheduler.WorkerTest do
  use ExUnit.Case
  alias ExScheduler.Worker

  defmodule Hello do
    def perform() do
      :ets.insert(:table, {:foo, :bar})
    end

    def hello() do
      :ets.insert(:table, {:foo, :bar})
    end

    def hello(_name) do
      :ets.insert(:table, {:foo, :bar})
    end
  end

  def setup_server(config, waiting \\ 1010) do
    GenServer.start_link(Worker, config)
    Process.sleep(waiting)
  end

  setup _ do
    :ets.new(:table, [:named_table, :duplicate_bag, :public])
    :ok
  end

  test "use perform/0 function by default" do
    config = [%{cron: "* * * * * *", module: Hello}]
    setup_server(config)
    assert Enum.count(:ets.lookup(:table, :foo)) > 0
  end

  test "use function with 0 arity by default" do
    config = [%{cron: "* * * * * *", module: Hello, function: :hello}]

    setup_server(config)
    assert Enum.count(:ets.lookup(:table, :foo)) > 0
  end

  test "use custom function with args" do
    config = [%{cron: "* * * * * *", module: Hello, function: :hello, args: ["world"]}]

    setup_server(config)
    assert Enum.count(:ets.lookup(:table, :foo)) > 0
  end

  test "run every second for 5 times" do
    config = [%{cron: "* * * * * *", module: Hello}]

    setup_server(config, 5050)
    assert Enum.count(:ets.lookup(:table, :foo)) == 5
  end

  test "run every 2 seconds" do
    config = [%{cron: "*/2 * * * * *", module: Hello}]
    setup_server(config, 4050)
    assert Enum.count(:ets.lookup(:table, :foo)) == 2
  end
end
