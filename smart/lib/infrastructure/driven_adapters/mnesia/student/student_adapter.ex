defmodule Smart.Infrastructure.DrivenAdapters.Mnesia.Student.StudentAdapter do
  alias Smart.Domain.Behaviours.Student.StudentRepositoryBehaviour
  alias Smart.Domain.Model.Student

  @behaviour StudentRepositoryBehaviour

  def save_student(student) do
    case :mnesia.transaction(fn ->
           :mnesia.write(
             {:students, student.numberId, student.name, student.lastname, student.age,
              student.gender, student.address, student.email, student.phone}
           )
         end) do
      {:atomic, :ok} ->
        {:ok, "Student was saved successfully."}

      {:aborted, reason} ->
        {:error, "Failed to save student: #{inspect(reason)}"}
    end
  end

  def get_student(numberId) do
    case :mnesia.transaction(fn ->
           :mnesia.read({:students, numberId})
         end) do
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
    end
  end
end
