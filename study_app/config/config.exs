# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :study_app,
  ecto_repos: [StudyApp.Repo]

# Configures the endpoint
config :study_app, StudyAppWeb.Endpoint,
  url: [host: System.get_env("HOST", "localhost"), port: System.get_env("PORT", "4000")],
  secret_key_base: "wLpagbBPTqJ8FV1FIkxhXd7ym5sMq7rZbn6Yffj3C/oVLzR/IaB8zQZeh/O1shhs",
  render_errors: [view: StudyAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudyApp.PubSub, adapter: Phoenix.PubSub.PG2],
  http: [protocol_options: [max_request_line_length: 8192, max_header_value_length: 8192]]

# Configures Elixir's Logger
config :logger,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  backends: [
    :console,
    {LoggerFileBackend, :file},
    {LoggerFileBackend, :error}
  ]

config :logger, :file, path: "log/#{Mix.env()}.log"

config :logger, :error,
  path: "log/error.log",
  level: :error

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Torch Admin
config :torch,
  otp_app: :study_app,
  template_format: "eex" || "slim"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
