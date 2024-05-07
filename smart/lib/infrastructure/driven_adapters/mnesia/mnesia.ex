defmodule Smart.Infrastructure.DrivenAdapters.Mnesia.Mnesia do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :mnesia.start()
    create_student_table()
    {:ok, %{}}  # Estado inicial vacío
  end


  def create_student_table() do
    :mnesia.create_table(:students, [
      attributes: [:name, :lastname, :numberId, :age, :gender, :address, :email, :phone],
      type: :set,
      index: [:numberId]
    ]) |> IO.inspect()
  end

  def table_exists?(table_name) do
    :mnesia.table_info(table_name, :name) != :undefined
  end

  def describe_table_if_exists() do
    if table_exists?(:students) do
      describe_table(:students)
    else
      IO.puts("La tabla :student no existe.")
    end
  end

  def describe_table(table_name) do
    attributes = :mnesia.table_info(table_name, :attributes)
    IO.puts("Attributes for table #{table_name}: #{inspect(attributes)}")
  end

  def healthy() do
    current_node = node()
    case :mnesia.system_info(:running_db_nodes) do
      [^current_node] -> {:ok, "Mnesia is running"}
      _ -> {:error, "Mnesia is not running"}
    end
  end

end
