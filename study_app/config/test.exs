use Mix.Config

# Configure your database
config :study_app, StudyApp.Repo,
  username: System.get_env("DATABASE_USERNAME", "root"),
  password: System.get_env("DATABASE_PASSWORD", ""),
  database: System.get_env("DATABASE_DATABASE", "study_app_test"),
  hostname: System.get_env("DATABASE_HOSTNAME", "localhost"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :study_app, StudyAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
