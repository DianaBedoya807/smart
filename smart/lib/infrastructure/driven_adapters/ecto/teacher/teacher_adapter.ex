defmodule Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherAdapter do
  alias Smart.Domain.Behaviours.Teacher.TeacherRepositoryBehaviour
  alias Smart.Infrastructure.DrivenAdapters.Ecto.Repo
  alias Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherSchema

  import Ecto.Query

  @behaviour TeacherRepositoryBehaviour

  def get_teacher(numberId) do
    {time, result} = :timer.tc(fn ->
      IO.inspect(numberId, label: "numberId")
      query = from(t in TeacherSchema, where: t.numberid == ^numberId)
      Repo.all(query) |> IO.inspect(label: "query")
      case Repo.all(query) do
        [] -> {:error, :not_found}
        [teachers] ->
          teachers
          |> Map.from_struct()
          |> Map.delete(:__meta__)
          |> (&{:ok, &1}).()
        _ -> {:error, :multiple_records}
      end
    end)

    IO.puts("get_teacher took #{div(time,1000)} milliseconds")

    result
  end
end
