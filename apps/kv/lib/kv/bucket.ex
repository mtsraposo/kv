defmodule KV.Bucket do
  use Agent, restart: :temporary

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end)
  end

  def get(agent, key) do
    Agent.get(agent, &Map.get(&1, key))
  end

  def put(agent, key, value) do
    Agent.update(agent, &Map.put(&1, key, value))
  end

  def delete(agent, key) do
    Agent.get_and_update(agent, &Map.pop(&1, key))
  end
end
