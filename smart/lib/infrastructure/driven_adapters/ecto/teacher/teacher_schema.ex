defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherSchema do
  # Use Ecto.Schema for defining the schema of the Teacher
  use Ecto.Schema
  # Import Ecto.Changeset for handling changesets
  import Ecto.Changeset

  # Define the primary key for the Teacher schema
  @primary_key {:numberid, :string, []}

  # Define the schema for the Teacher
  schema "teachers" do
    field :name, :string
    field :lastname, :string
    field :age, :integer
    field :gender, :string
    field :address, :string
    field :email, :string
    field :phone, :string
  end

  # Define a changeset function for the Teacher schema
  #
  # @param teacher The initial teacher struct
  # @param attrs The attributes to update in the teacher struct
  # @return A changeset for the teacher struct
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:name, :lastname, :numberid, :age, :gender, :address, :email, :phone])
    |> validate_required([:name, :lastname, :numberid, :age, :gender, :address, :email, :phone])
  end
end