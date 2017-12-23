# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/j4HuKZjsya6EONeXS1IpmK6ed9y7vU4YnBKPt8Ir/CkXk+vs9tlWLWBt2Hv3EOC",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth, providers: [ github: { Ueberauth.Strategy.Github, [] } ]
config :ueberauth, Ueberauth.Strategy.Github.OAuth, client_id: "Iv1.8c45820bf26c17f7", client_secret: "58c8512c66e9bdd72e560e2bac5770d77beec9ad"
