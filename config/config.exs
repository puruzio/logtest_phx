# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :logtest_phx, LogtestPhxWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: LogtestPhxWeb.ErrorHTML, json: LogtestPhxWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LogtestPhx.PubSub,
  live_view: [signing_salt: "wrttGUWt"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :logtest_phx, LogtestPhx.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.1.8",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, backends: [:console, LokiLogger],
  format: "$time $metadata[$level] $message\n",
  metadata: :all

config :logger, :keen_loki_logger,
  level: :debug,
  format: "$metadata level=$level $message",
  metadata: [:erl_level, :application, :file, :module, :function, :reason],
  max_buffer: 300,
  loki_host: "https://logs-prod-021.grafana.net",
  loki_path: "/loki/api/v1/push",
  basic_auth_user: "user1",
  basic_auth_password: "password",
  finch_protocols: [:http1],
  mint_conn_opts: []
  # mint_conn_opts: [transport_opts: [cacerts: :public_key.cacerts_get()]]



# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
