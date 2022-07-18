# Key-Value Store

Based on the official Elixir website's "Mix and OTP" guide, 
available <a href="https://elixir-lang.org/getting-started/introduction.html">here</a>.

The template was created using the command:
- `mix new kv --module KV`

To compile, use:
- `mix compile`

To run tests, use:
- `mix test`

To run distributed tests:
- First, start a node with 
  - `iex --sname bar -S mix`
- Then, run tests on another shell with 
  - `elixir --sname foo -S mix test --only distributed`

To launch Elixir Interactive Shell, use:
- `iex -S mix`

To create a release name `foo` in production:
- `MIX_ENV=prod mix release foo`

To start a production release named foo:
- `_build/prod/rel/foo/bin/foo start`

To connect to the application (from another shell instance):
- `telnet 127.0.0.1 4040` or `nc 127.0.0.1 4040`