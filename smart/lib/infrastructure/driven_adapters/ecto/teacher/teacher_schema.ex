defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherSchema do
  use Ecto.Schema

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
end
