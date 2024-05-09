defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherAdapter do
  alias Smart.Domain.Behaviours.Teacher.TeacherRepositoryBehaviour
  alias Smart.Infrastructure.DrivenAdapters.Ecto.Repo
  alias Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherSchema

  import Ecto.Query

  @behaviour TeacherRepositoryBehaviour

  def get_teacher(numberId) do
    {time, result} =
      :timer.tc(fn ->
        query = from(t in TeacherSchema, where: t.numberid == ^numberId)

        case Repo.all(query) do
          [] ->
            {:error, :not_found}

          [teachers] ->
            teachers
            |> Map.from_struct()
            |> Map.delete(:__meta__)
            |> (&{:ok, &1}).()

          _ ->
            {:error, :multiple_records}
        end
      end)

    IO.puts("get_teacher took #{div(time, 1000)} milliseconds")

    result
  end

  def insert_teacher(teacher_params) do
    teacher_params = Map.from_struct(teacher_params)

    {time, result} = :timer.tc(fn ->
      case %TeacherSchema{}
           |> TeacherSchema.changeset(teacher_params)
           |> Repo.insert() do
        {:ok, struct} -> {:ok, "Teacher was saved successfully."}
        {:error, changeset} -> {:error, "Failed to save student: #{inspect(changeset)}"}
      end
    end)

    IO.puts("insert_teacher took #{time} microseconds")
    IO.puts("insert_teacher took #{div(time, 1000)} milliseconds")

    result
  end
end
