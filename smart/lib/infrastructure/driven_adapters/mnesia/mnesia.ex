defmodule Smart.Infrastructure.DrivenAdapters.Mnesia.Mnesia do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :mnesia.start()
    {:ok, %{}}  # Estado inicial vacío
  end

  def healthy() do
    current_node = node()
    case :mnesia.system_info(:running_db_nodes) do
      [^current_node] -> {:ok, "Mnesia is running"}
      _ -> {:error, "Mnesia is not running"}
    end
  end

end
