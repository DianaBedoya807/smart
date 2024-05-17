defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Repo do
  # Alias for ConfigHolder module
  alias Smart.Config.ConfigHolder
  # Alias for SQL module
  alias Ecto.Adapters.SQL
  # Alias for ConnectionError module
  alias DBConnection.ConnectionError

  # Use Ecto.Repo with the specified otp_app and adapter
  use Ecto.Repo,
    otp_app: :smart,
    adapter: Ecto.Adapters.Postgres

  # Require Logger module
  require Logger

  # Initialize the Repo with the configuration from ConfigHolder
  #
  # @param _ The initial argument (ignored)
  # @param config The initial configuration
  # @return A tuple with :ok and the updated configuration
  def init(_, config) do
    %{
      username: username,
      password: password,
      database: database,
      hostname: hostname,
      port: port
    } = ConfigHolder.conf()

    config =
      config
      |> Keyword.put(:hostname, hostname)
      |> Keyword.put(:port, port)
      |> Keyword.put(:username, username)
      |> Keyword.put(:password, password)
      |> Keyword.put(:database, database)

    {:ok, config}
  end

  # Check the health of the Repo by executing a simple SQL query
  #
  # @return A tuple with :ok and :true if the query is successful, :error otherwise
  def health() do
    try do
      case SQL.query(__MODULE__, "select 1", [], source: "health") do
        {:ok, _res} -> {:ok, :true}
        _error -> :error
      end
    rescue
      ConnectionError -> :error
    end
  end
end