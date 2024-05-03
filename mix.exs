defmodule EstudiantesApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :estudiantes_app,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:mnesia] # Incluyir mnseia aqui
    ]
  end

  defp deps do
    [
      # Lista de dependencias
    ]
  end
end
