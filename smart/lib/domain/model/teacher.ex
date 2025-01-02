defmodule Smart.Domain.Model.Teacher do
  alias __MODULE__
  defstruct [:name, :lastname, :numberid, :age, :gender, :address, :email, :phone]

  def new_teacher(params) do
    {:ok,
     %__MODULE__{
       name: get_in(params, [:data, :name]),
       lastname: get_in(params, [:data, :lastname]),
       numberid: get_in(params, [:data, :numberid]),
       age: get_in(params, [:data, :age]),
       gender: get_in(params, [:data, :gender]),
       address: get_in(params, [:data, :address]),
       email: get_in(params, [:data, :email]),
       phone: get_in(params, [:data, :phone])
     }}
  end

  def validate_teacher(%Teacher{} = teacher) do
    cond do
      teacher.name == "" -> {:error, :name_is_required}
      teacher.lastname == "" -> {:error, :lastname_is_required}
      teacher.numberId == "" -> {:error, :numberId_is_required}
      teacher.age == "" -> {:error, :age_is_required}
      true -> {:ok, teacher}
    end
  end
end
