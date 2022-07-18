defmodule KV.Router do
    @hostname elem(:inet.gethostname(), 1)

    @doc """
    Dispatch the given `mod`, `fun`, `args` request
    to the appropriate node based on the `bucket`.
    """
    def route(bucket, mod, fun, args) do
      first = :binary.first(bucket)
      entry = Enum.find(table(), fn {enum, _node} ->
        first in enum
      end) || no_entry_error(bucket)

      if elem(entry, 1) == node() do
        apply(mod, fun, args)
      else
        {KV.RouterTasks, elem(entry, 1)}
        |> Task.Supervisor.async(KV.Router, :route, [bucket, mod, fun, args])
        |> Task.await()
      end
    end

    defp no_entry_error(bucket) do
      raise "could not find entry for #{inspect bucket} in table #{inspect table()}"
    end

    def table() do
      [{?a..?m, :"foo@#{@hostname}"}, {?n..?z, :"bar@#{@hostname}"}]
    end
end