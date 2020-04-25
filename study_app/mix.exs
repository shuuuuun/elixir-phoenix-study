defmodule StudyApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :study_app,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: compilers(Mix.env()) ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {StudyApp.Application, []},
      extra_applications: extra_applications(Mix.env())
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp compilers(:dev), do: [:phoenix, :gettext, :phoenix_swagger]
  defp compilers(_), do: [:phoenix, :gettext]

  defp extra_applications(:dev), do: [:logger, :runtime_tools, :logger_file_backend, :phoenix_swagger]
  defp extra_applications(_), do: [:logger, :runtime_tools, :logger_file_backend]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.9"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:myxql, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:logger_file_backend, "~> 0.0.10"},
      {:plug_cowboy, "~> 2.0"},
      {:torch, "~> 2.0"},
      {:csv, "~> 1.4.2"},
      {:cors_plug, "~> 2.0"},
      {:phoenix_swagger, github: "xerions/phoenix_swagger", branch: "master", only: [:dev, :test]},
      {:ex_json_schema, "~> 0.5"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.drop", "ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
