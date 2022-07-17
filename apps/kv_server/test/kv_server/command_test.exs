defmodule KVServer.CommandTest do
  use ExUnit.Case, async: true
  doctest KVServer.Command

  setup context do
    _ = start_supervised!({KV.Registry, name: context.test})
    KVServer.Command.run({:create, "shopping"}, context.test)
    %{registry: context.test}
  end

  test "create bucket", %{registry: registry} do
    assert KVServer.Command.run({:create, "shopping-2"}, registry) == {:ok, "OK\r\n"}
  end

  test "put key value", %{registry: registry} do
    assert KVServer.Command.run({:put, "shopping", "milk", 1}, registry) == {:ok, "OK\r\n"}
  end

  test "get key", %{registry: registry} do
    KVServer.Command.run({:put, "shopping", "milk", 1}, registry)
    assert KVServer.Command.run({:get, "shopping", "milk"}, registry) == {:ok, "1\r\nOK\r\n"}
  end

  test "delete key", %{registry: registry} do
    KVServer.Command.run({:put, "shopping", "milk", 1}, registry)
    assert KVServer.Command.run({:delete, "shopping", "milk"}, registry) == {:ok, "OK\r\n"}
  end
end