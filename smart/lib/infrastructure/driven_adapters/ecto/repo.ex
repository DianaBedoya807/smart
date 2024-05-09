defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Repo do

  alias Smart.Config.ConfigHolder
  alias Ecto.Adapters.SQL
  alias DBConnection.ConnectionError

  use Ecto.Repo,
    otp_app: :smart,
    adapter: Ecto.Adapters.Postgres

  require Logger

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
