defmodule Smart.MixProject do
  use Mix.Project

  def project do
    [
      app: :smart,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "ca.release": :test,
        "ca.sobelow.sonar": :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.xml": :test,
        credo: :test,
        release: :prod,
        sobelow: :test,
      ],
      releases: [
        smart: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ],
      metrics: true
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :opentelemetry_exporter, :opentelemetry, :mnesia],
      mod: {Smart.Application, [Mix.env()]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:opentelemetry_ecto, "~> 1.0"},
      {:ecto_sql, "~> 3.10.2"},
      {:postgrex, "~> 0.17.2"},
      {:lager, "~> 3.9"},
      {:opentelemetry_plug, git: "https://github.com/bancolombia/opentelemetry_plug.git", branch: "master"},
      {:opentelemetry_api, "~> 1.0"},
      {:opentelemetry_exporter, "~> 1.0"},
      {:telemetry, "~> 1.0"},
      {:telemetry_metrics, "~> 1.0.0"},
      {:telemetry_poller, "~> 0.3"},
      {:telemetry_metrics_prometheus, "~> 1.0"},
      {:telemetry_metrics_prometheus_core, "~> 1.2"},
      {:prometheus, "~> 3.5.1", override: true},  # Para manejar las métricas de Prometheus
      {:prometheus_ex, "~> 3.1.0"},
      {:prometheus_plugs, "~> 1.0"},  # Para exportar métricas a través de Plug
      {:plug_cowboy, "~> 2.7"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:castore, "~> 1.0", override: true},
      {:jason, "~> 1.4"},
      {:plug_checkup, "~> 0.6"},
      {:poison, "~> 5.0"},
      {:cors_plug, "~> 3.0"},
      {:timex, "~> 3.0"},
      {:excoveralls, "~> 0.14", only: :test},
      {:elixir_structure_manager, ">= 0.0.0", only: [:dev, :test]},
      {:phoenix, "~> 1.7"},
      {:phoenix_pubsub, "~> 2.0"}
    ]
  end
end
