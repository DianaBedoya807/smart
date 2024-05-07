defmodule Smart.Domain.Model.Student do
  alias __MODULE__
  defstruct [:name, :lastname,:numberId, :age, :gender, :address, :email, :phone]

  def new_student(params) do
    student = %__MODULE__{
      name: get_in(params, [:data, :name]),
      lastname: get_in(params, [:data, :lastname]),
      numberId: get_in(params, [:data, :numberId]),
      age: get_in(params, [:data, :age]),
      gender: get_in(params, [:data, :gender]),
      address: get_in(params, [:data, :address]),
      email: get_in(params, [:data, :email]),
      phone: get_in(params, [:data, :phone])
    }
    validate_student(student)
  end

  defp validate_student(student) do
    cond do
      student.name == "" -> {:error, :name_is_required}
      student.lastname == "" -> {:error, :lastname_is_required}
      student.numberId == "" -> {:error, :numberId_is_required}
      student.age == "" -> {:error, :age_is_required}
      true -> {:ok, student}

    end
  end
end
