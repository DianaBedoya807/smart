defmodule Smart.Infrastructure.EntryPoint.HealthCheck do
  @moduledoc """
  Smart health check
  """

  def checks do
    [
      %PlugCheckup.Check{name: "http", module: __MODULE__, function: :check_http}
    ]
  end

  def check_http do
    :ok
  end
end
