defmodule Smart.Infrastructure.EntryPoint.ApiRest do
  @moduledoc """
  Access point to the rest exposed services
  """
  alias Smart.Utils.DataTypeUtils
  alias Smart.Infrastructure.EntryPoint.ErrorHandler
  alias Smart.Domain.Model.Student
  alias Smart.Domain.UseCases.Student.StudentUsecase
  alias Smart.Domain.Model.Teacher
  alias Smart.Domain.UseCases.Teacher.TeacherUsecase

  require Logger
  use Plug.Router
  use Timex

  plug(CORSPlug,
    methods: ["GET", "POST", "PUT", "DELETE"],
    origin: [~r/.*/],
    headers: ["Content-Type", "Accept", "User-Agent"]
  )

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(OpentelemetryPlug.Propagation)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(Plug.Telemetry, event_prefix: [:smart, :plug])
  plug(:dispatch)

  forward(
    "/api/health",
    to: PlugCheckup,
    init_opts:
      PlugCheckup.Options.new(
        json_encoder: Jason,
        checks: Smart.Infrastructure.EntryPoint.HealthCheck.checks()
      )
  )

  get "/api/hello" do
    build_response("Hello Mnesia", conn)
  end

  post "/api/insert" do
    try do
      with request <- conn.body_params |> DataTypeUtils.normalize(),
           {:ok, data} <- Student.new_student(request),
           {:ok, response} <- StudentUsecase.register_student(data) do
        build_response(response, conn)
      else
        {:error, error} -> build_bad_request_response(error, conn)
      end
    rescue
      error in Exception ->
        IO.inspect(error, label: "Error occurred")
        build_response("Error occurred apirest", conn)
    end
  end

  post "/api/getstudent" do
    try do
      with request <- conn.body_params |> DataTypeUtils.normalize(),
           {:ok, data} <- Student.new_student(request),
           {:ok, response} <- StudentUsecase.get_student(data.numberId) do
        build_response(response, conn)
      else
        {:error, error} -> build_bad_request_response(error, conn)
      end
    rescue
      error in Exception ->
        IO.inspect(error, label: "Error occurred")
        build_response("Error occurred getstudent", conn)
    end
  end

  post "/api/getteacher" do
    try do
      with request <- conn.body_params |> DataTypeUtils.normalize(),
           {:ok, data} <- Teacher.new_teacher(request),
           {:ok, response} <- TeacherUsecase.get_teacher(data.numberId) do
        build_response(response, conn)
      else
        {:error, error} -> build_bad_request_response(error, conn)
      end
    rescue
      error in Exception ->
        IO.inspect(error, label: "Error occurred")
        build_response("Error occurred getteacher", conn)
    end
  end

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def build_response(response, conn), do: build_response(%{status: 200, body: response}, conn)

  match _ do
    conn
    |> handle_not_found(Logger.level())
  end

  defp handle_error(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_response(conn)
  end

  defp handle_bad_request(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_bad_request_response(conn)
  end

  defp build_bad_request_response(response, conn) do
    build_response(%{status: 400, body: response}, conn)
  end

  defp handle_not_found(conn, :debug) do
    %{request_path: path} = conn
    body = Poison.encode!(%{status: 404, path: path})
    send_resp(conn, 404, body)
  end

  defp handle_not_found(conn, _level) do
    send_resp(conn, 404, "")
  end
end
