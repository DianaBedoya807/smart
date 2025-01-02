defmodule Smart.Utils.CustomTelemetry do
  alias Smart.Utils.DataTypeUtils
  alias Smart.Utils.CustomTelemetry
  import Telemetry.Metrics

  @service_name Application.compile_env!(:smart, :custom_metrics_prefix_name)

  @moduledoc """
  Provides functions for custom telemetry events
  """

  def custom_telemetry_events() do
    :telemetry.attach("smart-plug-stop", [:smart, :plug, :stop], &CustomTelemetry.handle_custom_event/4, nil)
    :telemetry.attach("smart-vm-memory", [:vm, :memory], &CustomTelemetry.handle_custom_event/4, nil)
    :telemetry.attach("vm-total_run_queue_lengths", [:vm, :total_run_queue_lengths], &CustomTelemetry.handle_custom_event/4, nil)
    :telemetry.attach("ecto", [:smart, :adapters, :ecto, :repo, :query], &CustomTelemetry.handle_custom_event/4, nil)
  end

  def execute_custom_event(metric, value, metadata \\ %{})

  def execute_custom_event(metric, value, metadata) when is_list(metric) do
    metadata = Map.put(metadata, :service, @service_name)
    :telemetry.execute([:elixir | metric], %{duration: value}, metadata)
  end

  def execute_custom_event(metric, value, metadata) when is_atom(metric) do
    execute_custom_event([metric], value, metadata)
  end

  def handle_custom_event([:smart, :plug, :stop], measures, metadata, _) do
    :telemetry.execute(
      [:elixir, :http_request_duration_milliseconds],
      %{duration: DataTypeUtils.monotonic_time_to_milliseconds(measures.duration)},
      %{request_path: metadata.conn.request_path, service: @service_name}
    )
  end

  def handle_custom_event([:smart, :adapters, :ecto, :repo, :query], measures, metadata, _)  do
    :telemetry.execute(
      [:elixir, :db, :query],
      %{duration: DataTypeUtils.monotonic_time_to_milliseconds(measures.total_time)},
      %{source: metadata.source, service: @service_name}
    )
  end

  def handle_custom_event(metric, measures, metadata, _) do
    metadata = Map.put(metadata, :service, @service_name)
    :telemetry.execute([:elixir | metric], measures, metadata)
  end

  def metrics do
    [
      # Ecto db
      last_value("elixir.db.query.duration", tags: [:source, :service]),
      counter("elixir.db.query.count", tags: [:source, :service]),

      # Plug Metrics
      counter("elixir.http_request_duration_milliseconds.count", tags: [:request_path, :service]),
      sum("elixir.http_request_duration_milliseconds.duration", tags: [:request_path, :service]),

      # VM Metrics
      last_value("elixir.vm.memory.total", unit: {:byte, :kilobyte}, tags: [:service]),
      sum("elixir.vm.total_run_queue_lengths.total", tags: [:service]),
      sum("elixir.vm.total_run_queue_lengths.cpu", tags: [:service]),
      sum("elixir.vm.total_run_queue_lengths.io", tags: [:service])
    ]
  end
end
