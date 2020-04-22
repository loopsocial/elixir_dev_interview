defmodule ExScheduler.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_scheduler,
      version: "0.1.0",
      description: "Cron-like job scheduler in few lines of readable elixir code.",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      source_url: "https://github.com/loopsocial/ex_scheduler"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExScheduler.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:crontab, "~> 1.1"},
      {:timex, "~> 3.4"}
    ]
  end

  defp package do
    %{
      licenses: ["Apache License 2.0"],
      maintainers: ["Alexandre Marangoni Costa"],
      links: %{"GitHub" => "https://github.com/loopsocial/ex_scheduler"}
    }
  end
end
