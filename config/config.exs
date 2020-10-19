# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :theme01,
  ecto_repos: [Theme01.Repo]

# Configures the endpoint
config :theme01, Theme01Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+41r7Jk4HWSQNtCcKQQ73wI5N8c0zZcSJagK+w+dLO2On15sSnp8oCMePuUvkfae",
  render_errors: [view: Theme01Web.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Theme01.PubSub,
  live_view: [signing_salt: "ZR4JAq8G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
