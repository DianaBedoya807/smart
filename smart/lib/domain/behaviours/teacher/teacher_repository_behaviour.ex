defmodule Smart.Domain.Behaviours.Teacher.TeacherRepositoryBehaviour do
  @callback get_teacher(numberId::term) :: {:ok, response ::term} | {:error, reason :: term}
end
