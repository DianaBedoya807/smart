defmodule Smart.Application do
  @moduledoc """
  Smart application
  """

  alias Smart.Infrastructure.EntryPoint.ApiRest
  alias Smart.Config.{AppConfig, ConfigHolder}
  alias Smart.Utils.CustomTelemetry
  alias Smart.Infrastructure.DrivenAdapters.Mnesia.Mnesia
  alias Smart.Infrastructure.Adapters.Repository.Repo

  use Application
  require Logger

  def start(_type, [env]) do
    config = AppConfig.load_config()

    children = with_plug_server(config) ++ all_env_children() ++ env_children(env)

    CustomTelemetry.custom_telemetry_events()
    OpentelemetryPlug.setup()
    OpentelemetryEcto.setup([:elixir, :repo])
    opts = [strategy: :one_for_one, name: Smart.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp with_plug_server(%AppConfig{enable_server: true, http_port: port}) do
    Logger.debug("Configure Http server in port #{inspect(port)}. ")
    [{Plug.Cowboy, scheme: :http, plug: ApiRest, options: [port: port]}]
  end

  defp with_plug_server(%AppConfig{enable_server: false}), do: []

  def all_env_children() do
    [
      {ConfigHolder, AppConfig.load_config()},
      {TelemetryMetricsPrometheus, [metrics: CustomTelemetry.metrics()]}
    ]
  end

  def env_children(:test) do
    []
  end

  def env_children(_other_env) do
    [
			{Repo, []},
      {Mnesia, []}
    ]
  end
end
