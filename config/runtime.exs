import Config

config :kv, routing_table: [{?a..?z, node()}]
config :kv, hostname: elem(:inet.gethostname(), 1)

if config_env() == :prod do
  config :kv, :routing_table, [
    {?a..?m, :"foo@#{elem(:inet.gethostname(), 1)}"},
    {?n..?z, :"bar@#{elem(:inet.gethostname(), 1)}"}
  ]
end
