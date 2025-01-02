defmodule Smart.Domain.Behaviours.Student.StudentRepositoryBehaviour do
  @callback save_student(student::term) :: {:ok, response ::term} | {:error, reason :: term}
  @callback get_student(numberId::term) :: {:ok, response ::term} | {:error, reason :: term}
end
