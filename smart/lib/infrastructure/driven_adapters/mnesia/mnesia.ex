defmodule Smart.Infrastructure.DrivenAdapters.Mnesia.Mnesia do
  # Use GenServer for OTP behaviours
  use GenServer
  # Require Logger for logging
  require Logger

  # Start the GenServer with the specified arguments
  #
  # @param _ The initial argument (ignored)
  # @return A tuple with the GenServer process id if successful, :error otherwise
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # Initialize the GenServer with the specified arguments
  #
  # @param :ok The initial argument
  # @return A tuple with :ok and an empty map
  def init(:ok) do
    :mnesia.start()
    create_student_table()
    {:ok, %{}}  # Initial empty state
  end

  # Create the student table in Mnesia
  #
  # @return The result of the table creation
  def create_student_table() do
    :mnesia.create_table(:students, [
      attributes: [:name, :lastname, :numberId, :age, :gender, :address, :email, :phone],
      type: :set,
      index: [:numberId]
    ]) |> IO.inspect()
  end

  # Check if a table exists in Mnesia
  #
  # @param table_name The name of the table to check
  # @return true if the table exists, false otherwise
  def table_exists?(table_name) do
    :mnesia.table_info(table_name, :name) != :undefined
  end

  # Describe the student table if it exists
  #
  # @return The attributes of the student table if it exists, a message otherwise
  def describe_table_if_exists() do
    if table_exists?(:students) do
      describe_table(:students)
    else
      IO.puts("La tabla :student no existe.")
    end
  end

  # Describe a table in Mnesia
  #
  # @param table_name The name of the table to describe
  # @return The attributes of the table
  def describe_table(table_name) do
    attributes = :mnesia.table_info(table_name, :attributes)
    IO.puts("Attributes for table #{table_name}: #{inspect(attributes)}")
  end

  # Check the health of Mnesia
  #
  # @return A tuple with :ok and a success message if Mnesia is running, :error otherwise
  def healthy() do
    current_node = node()
    case :mnesia.system_info(:running_db_nodes) do
      [^current_node] -> {:ok, "Mnesia is running"}
      _ -> {:error, "Mnesia is not running"}
    end
  end
end