defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherSchema do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:numberid, :string, []}
  schema "teachers" do
    field :name, :string
    field :lastname, :string
    field :age, :integer
    field :gender, :string
    field :address, :string
    field :email, :string
    field :phone, :string
  end

  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:name, :lastname, :numberid, :age, :gender, :address, :email, :phone])
    |> validate_required([:name, :lastname, :numberid, :age, :gender, :address, :email, :phone])
  end
end
