defmodule KVServer.CommandTest do
  use ExUnit.Case, async: true
  doctest KVServer.Command

  setup context do
    _ = start_supervised!({KV.Registry, name: context.test})
    KVServer.Command.run({:create, "bucket-name"}, context.test)
    %{registry: context.test}
  end

  test "create bucket", %{registry: registry} do
    assert KVServer.Command.run({:create, "bucket-name-2"}, registry) == {:ok, "OK\r\n"}
  end

  test "put key value", %{registry: registry} do
    assert KVServer.Command.run({:put, "bucket-name", "milk", 1}, registry) == {:ok, "OK\r\n"}
  end

  test "get key", %{registry: registry} do
    KVServer.Command.run({:put, "bucket-name", "milk", 1}, registry)
    assert KVServer.Command.run({:get, "bucket-name", "milk"}, registry) == {:ok, "1\r\nOK\r\n"}
  end

  test "delete key", %{registry: registry} do
    KVServer.Command.run({:put, "bucket-name", "milk", 1}, registry)
    assert KVServer.Command.run({:delete, "bucket-name", "milk"}, registry) == {:ok, "OK\r\n"}
  end
end