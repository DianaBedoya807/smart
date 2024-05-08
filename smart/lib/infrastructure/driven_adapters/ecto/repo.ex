defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Repo do

  alias Smart.Config.ConfigHolder

  use Ecto.Repo,
    otp_app: :smart,
    adapter: Ecto.Adapters.MyXQL

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

  def check_db_health do
    try do
      query_health("SELECT 1")
      :ok
    rescue
      _e in DBConnection.ConnectionError ->
        :error
    end
  end

  defp query_health(sql) do
    Ecto.Adapters.SQL.query!(Repo, sql)
  end
end
