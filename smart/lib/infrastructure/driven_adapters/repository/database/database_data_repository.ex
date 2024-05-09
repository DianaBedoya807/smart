defmodule Smart.Infrastructure.Adapters.Repository.Database.DatabaseDataRepository do
  alias Smart.Infrastructure.Adapters.Repository.Repo
  alias Smart.Infrastructure.Adapters.Repository.Database.Data.DatabaseData
  # alias Smart.Domain.Model.Database

  ## TODO: Update behaviour
  # @behaviour Smart.Domain.Behaviours.DatabaseBehaviour

  def find_by_id(id), do: DatabaseData |> Repo.get(id) |> to_entity

  def insert(entity) do
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    ## TODO: Update Entity
    # struct(Database, data |> Map.from_struct)
    %{}
  end

  defp to_data(entity) do
    struct(DatabaseData, entity |> Map.from_struct)
  end
end
