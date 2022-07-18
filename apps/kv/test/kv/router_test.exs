defmodule KV.RouterTest do
  use ExUnit.Case

  setup_all do
    current = Application.get_env(:kv, :routing_table)
    hostname = Application.get_env(:kv, :hostname)

    Application.put_env(:kv, :routing_table, [
      {?a..?m, :"foo@#{hostname}"},
      {?n..?z, :"bar@#{hostname}"}
    ])

    on_exit fn -> Application.put_env(:kv, :routing_table, current) end
    %{hostname: hostname}
  end

  @tag :distributed
  test "route requests across nodes", %{hostname: hostname} do
    assert KV.Router.route("hello", Kernel, :node, []) == :"foo@#{hostname}"
    assert KV.Router.route("world", Kernel, :node, []) == :"bar@#{hostname}"
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      KV.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end