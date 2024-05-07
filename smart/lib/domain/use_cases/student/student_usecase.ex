defmodule Smart.Domain.UseCases.Student.StudentUsecase do
  alias Smart.Domain.Model.Student
  require Logger

  @student_repository Application.compile_env(:smart, :student_repository)

  def register_student(%Student{} = student) do
    with {:ok, data} <- Student.validate_student(student),
         {:ok, response} <- @student_repository.save_student(data) do
      {:ok, response}
    else
      {:error, error} -> {:error, error}
    end
  end

  def get_student(numberId) do
    with {:ok, response} <- @student_repository.get_student(numberId) do
      {:ok, response}
    else
      {:error, error} -> {:error, error}
    end
  end
end
