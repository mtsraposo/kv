import Config
config :iex, default_prompt: ">>>"
config :kv, routing_table: [{?a..?z, node()}]
config :kv, hostname: elem(:inet.gethostname(), 1)