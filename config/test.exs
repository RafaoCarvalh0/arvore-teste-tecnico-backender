import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :arvore_repli, ArvoreRepli.Repo,
  username: System.get_env("TEST_DB_USERNAME"),
  password: System.get_env("TEST_DB_PASSWORD"),
  hostname: System.get_env("TEST_DB_HOSTNAME"),
  database: "arvore_repli_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :arvore_repli, ArvoreRepliWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xsYNYi6q+46RTqsw81J1mxVHOhzoYow6juPoeuWoHEtrZ9uEbIIMeB3Xk4kPlvbz",
  server: false

# In test we don't send emails.
config :arvore_repli, ArvoreRepli.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
