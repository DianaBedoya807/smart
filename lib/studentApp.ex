defmodule StudentApp do
  def start do
    # Inicializamos Mnesia
    :mnesia.start()

    # Menú interactivo
    menu()
  end

  def menu do
    IO.puts("\nMenú:")
    IO.puts("1. Crear tabla")
    IO.puts("2. Mostrar tabla")
    IO.puts("3. Agregar estudiante")
    IO.puts("4. Salir")

    # Solicitamos una opción al usuario
    option = IO.gets("Elige una opción: ") |> String.trim() |> String.to_integer()

    case option do
      1 ->
        create_table()
        menu()
      2 ->
        display_table()
        menu()
      3 ->
        add_student()
        menu()
      4 ->
        IO.puts("Saliendo...")
        :ok
      _ ->
        IO.puts("Opción no válida.")
        menu()
    end
  end

  def create_table do
    # Crear la tabla en Mnesia
    :mnesia.create_table(:students, [
      attributes: [:id, :name, :age],
      type: :set,
      index: [:name]
    ])

    IO.puts("Tabla students creada.")
  end

  def display_table do
    # Mostramos todos los estudiantes en la tabla
    :mnesia.transaction(fn ->
      :mnesia.match_object({:students, :_, :_, :_})
      |> Enum.each(fn {_, id, name, age} ->
        IO.puts("ID: #{id}, Nombre: #{name}, Edad: #{age}")
      end)
    end)
  end

  def add_student do
    # Solicitamos la información del estudiante al usuario
    id = IO.gets("Ingresa el ID del estudiante: ") |> String.trim() |> String.to_integer()
    name = IO.gets("Ingresa el nombre del estudiante: ") |> String.trim()
    age = IO.gets("Ingresa la edad del estudiante: ") |> String.trim() |> String.to_integer()

    # Medimos el tiempo que toma agregar el estudiante a la tabla
    {time, _result} = :timer.tc(fn ->
      # Agregamos el estudiante a la tabla
      :mnesia.transaction(fn ->
        :mnesia.write({:students, id, name, age})
      end)
    end)

    # Convertir el tiempo de microsegundos a milisegundos para una mejor comprensión
    time_ms = time / 1000

    IO.puts("Estudiante agregado: #{name}")
    IO.puts("Tiempo de almacenamiento: #{time_ms} ms")
  end
end
