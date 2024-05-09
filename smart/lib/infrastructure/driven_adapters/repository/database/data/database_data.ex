defmodule Smart.Infrastructure.Adapters.Repository.Database.Data.DatabaseData do
  use Ecto.Schema

  ## TODO: Add schema definition
  # Types https://hexdocs.pm/ecto/Ecto.Schema.html#module-primitive-types

  schema "database" do
    field :name, :string
    #field :creation_date, :utc_datetime
    #field :update_date, :utc_datetime
  end
end
