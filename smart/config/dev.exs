import Config

config :smart, timezone: "America/Bogota"

config :smart,
  http_port: 8083,
  enable_server: true,
  secret_name: "",
  version: "0.0.1",
  in_test: false,
  custom_metrics_prefix_name: "smart_local"

config :smart,
  student_repository: Smart.Infrastructure.DrivenAdapters.Mnesia.Student.StudentAdapter,
  teacher_repository: Smart.Infrastructure.DrivenAdapters.Ecto.Teacher.TeacherAdapter

config :smart,
  database: "postgres",
  username: "postgres",
  password: "system",
  hostname: "localhost",
  port: "5432"

config :logger,
  level: :debug

# tracer
config :opentelemetry,
  span_processor: :batch,
  traces_exporter: {:otel_exporter_stdout, []}
