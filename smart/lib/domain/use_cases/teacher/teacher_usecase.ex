defmodule Smart.Domain.UseCases.Teacher.TeacherUsecase do
  alias Smart.Domain.Model.Teacher

  @teacher_repository Application.compile_env(:smart, :teacher_repository)

  def get_teacher(numberId) do
    with {:ok, response} <- @teacher_repository.get_teacher(numberId) do
      {:ok, response}
    else
      {:error, error} -> {:error, error}
    end
  end

  def insert_teacher(teacher) do
    with {:ok, response} <- @teacher_repository.insert_teacher(teacher) do
      {:ok, response}
    else
      {:error, error} -> {:error, error}
    end
  end

end
