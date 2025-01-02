defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherAdapter do
  # Alias for TeacherRepositoryBehaviour module
  alias Smart.Domain.Behaviours.Teacher.TeacherRepositoryBehaviour
  # Alias for Repo module
  alias Smart.Adapters.Ecto.Repo
  # Alias for TeacherSchema module
  alias Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherSchema

  # Import Ecto.Query for querying the database
  import Ecto.Query

  # Implement the TeacherRepositoryBehaviour
  @behaviour TeacherRepositoryBehaviour

  # Fetch a teacher by their numberId
  #
  # @param numberId The numberId of the teacher to fetch
  # @return A tuple with :ok and the teacher if found, :error otherwise
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

  # Insert a new teacher into the database
  #
  # @param teacher_params The parameters of the teacher to insert
  # @return A tuple with :ok and a success message if the insertion is successful, :error otherwise
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
