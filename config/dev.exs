use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :chat, Chat.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []


# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :guardian, Guardian,
  allowed_algos: ["RS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Chat",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: {Chat.GuardianSecretKey, :fetch},
  serializer: Chat.GuardianSerializer

# Configure your database
# Configure your database
config :account, Chat.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: System.get_env("POSTGRES_HOST"),
  port: System.get_env("POSTGRES_PORT"),
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: System.get_env("POSTGRES_DB"),
  pool_size: 10
