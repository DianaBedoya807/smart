import Config

config :smart, timezone: "America/Bogota"

config :smart,
  http_port: 8083,
  enable_server: true,
  secret_name: "",
  version: "0.0.1",
  in_test: true,
  custom_metrics_prefix_name: "smart_test"

config :smart,
  student_repository: Smart.Infrastructure.DrivenAdapters.Mnesia.Student.StudentAdapter

config :smart,
  database: "mi_escuela",
  username: "bryserna",
  password: "Cambio1234*+",
  hostname: "localhost"

config :logger,
  level: :info

config :junit_formatter,
  report_dir: "_build/release",
  report_file: "test-junit-report.xml"

config :elixir_structure_manager, # used with mix ca.release --container
  container_tool: "docker",
  container_file: "resources/cloud/Dockerfile-build",
  container_base_image: "1.16.2-otp-26-alpine" # change by your preferred image

# tracer
config :opentelemetry,
  span_processor: :batch,
  traces_exporter: {:otel_exporter_stdout, []}
