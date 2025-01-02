defmodule Smart.Infrastructure.DrivenAdapters.Mnesia.Student.StudentAdapter do
  # Alias for StudentRepositoryBehaviour module
  alias Smart.Domain.Behaviours.Student.StudentRepositoryBehaviour
  # Alias for Student module
  alias Smart.Domain.Model.Student

  # Implement the StudentRepositoryBehaviour
  @behaviour StudentRepositoryBehaviour

  # Save a student in the Mnesia database
  #
  # @param student The student to save
  # @return A tuple with :ok and a success message if the save is successful, :error otherwise
  def save_student(student) do
    {time, result} =
      :timer.tc(fn ->
        :mnesia.transaction(fn ->
          :mnesia.write(
            {:students, student.numberId, student.name, student.lastname, student.age,
             student.gender, student.address, student.email, student.phone}
          )
        end)
      end)

    IO.puts("save_student took #{time} microseconds")
    IO.puts("save_student took #{div(time, 1000)} milliseconds")

    case result do
      {:atomic, :ok} ->
        {:ok, "Student was saved successfully."}

      {:aborted, reason} ->
        {:error, "Failed to save student: #{inspect(reason)}"}
    end
  end

  # Fetch a student by their numberId from the Mnesia database
  #
  # @param numberId The numberId of the student to fetch
  # @return A tuple with :ok and the student if found, :error otherwise
  def get_student(numberId) do
    {time, result} =
      :timer.tc(fn ->
        :mnesia.transaction(fn ->
          :mnesia.read({:students, numberId})
        end)
      end)

    IO.puts("get_student took #{time} microseconds")
    IO.puts("get_student took #{div(time, 1000)} milliseconds")

    case result do
      {:atomic, [{:students, numberId, name, lastname, age, gender, address, email, phone}]} ->
        {:ok,
         %Student{
           name: name,
           lastname: lastname,
           numberId: numberId,
           age: age,
           gender: gender,
           address: address,
           email: email,
           phone: phone
         }}

      {:atomic, []} ->
        {:error, "No student found with the given numberId"}

      _ ->
        {:error, "An unexpected error occurred"}
    end
  end
end
