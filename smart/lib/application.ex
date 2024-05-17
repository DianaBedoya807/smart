defmodule Smart.Application do
  # Documentation for the Smart application
  @moduledoc """
  Smart application
  """

  # Alias for ApiRest module
  alias Smart.Infrastructure.EntryPoint.ApiRest
  # Alias for AppConfig and ConfigHolder modules
  alias Smart.Config.{AppConfig, ConfigHolder}
  # Alias for CustomTelemetry module
  alias Smart.Utils.CustomTelemetry
  # Alias for Mnesia module
  alias Smart.Infrastructure.DrivenAdapters.Mnesia.Mnesia
  # Alias for Repo module
  alias Smart.Infrastructure.DrivenAdapters.Ecto.Repo

  # Use Application for OTP behaviours
  use Application
  # Require Logger for logging
  require Logger

  # Start the Smart application
  #
  # @param _type The type of the application (ignored)
  # @param env The environment of the application
  # @return The result of the Supervisor start_link function
  def start(_type, [env]) do
    config = AppConfig.load_config()

    children = with_plug_server(config) ++ all_env_children() ++ env_children(env)

    CustomTelemetry.custom_telemetry_events()
    OpentelemetryPlug.setup()
    opts = [strategy: :one_for_one, name: Smart.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Configure the Plug server if enabled
  #
  # @param config The configuration of the application
  # @return A list with the Plug.Cowboy configuration if the server is enabled, an empty list otherwise
  defp with_plug_server(%AppConfig{enable_server: true, http_port: port}) do
    Logger.debug("Configure Http server in port #{inspect(port)}. ")
    [{Plug.Cowboy, scheme: :http, plug: ApiRest, options: [port: port]}]
  end

  # Return an empty list if the Plug server is not enabled
  #
  # @param _ The configuration of the application (ignored)
  # @return An empty list
  defp with_plug_server(%AppConfig{enable_server: false}), do: []

  # Return the children for all environments
  #
  # @return A list with the ConfigHolder and TelemetryMetricsPrometheus configurations
  def all_env_children() do
    [
      {ConfigHolder, AppConfig.load_config()},
      {TelemetryMetricsPrometheus, [metrics: CustomTelemetry.metrics()]}
    ]
  end

  # Return an empty list for the test environment
  #
  # @param :test The environment of the application (ignored)
  # @return An empty list
  def env_children(:test) do
    []
  end

  # Return the children for non-test environments
  #
  # @param _other_env The environment of the application (ignored)
  # @return A list with the Mnesia and Repo configurations
  def env_children(_other_env) do
    [
      {Mnesia, []},
      {Repo, []}
    ]
  end
end