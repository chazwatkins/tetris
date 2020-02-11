# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :tetris, TetrisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yaA6cKoVQ06Fw/C46n/xy12mc4Ov2LpzO/xS7m7Cx1pL6DPOyegLbBi2h6qJvhtL",
  render_errors: [view: TetrisWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tetris.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "hG+LNtiRWOrDKDL89TQ7dU4PulXRJ97a"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
