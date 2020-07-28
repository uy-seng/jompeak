# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jompeak,
  ecto_repos: [Jompeak.Repo]

# Configures the endpoint
config :jompeak, JompeakWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q0LKaZs2F5hzT8oq05PwF4ViOs3bSjIURVmkvgKFvBL8+Sp1vBstaXCBzxUUdNqn",
  render_errors: [view: JompeakWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Jompeak.PubSub,
  live_view: [signing_salt: "YgJBx7X+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :guardian, Guardian,
 issuer: "Jompeak.#{Mix.env()}",
 verify_issuer: true,
 serializer: Jompeak.GuardianSerializer,
 secret_key: "U8cUBBF+Fcz+BoL2pzU5awhzcFBlvn8iIgMP+qfabjx5g24u/WFH3ZWe5pVa5fHx"
