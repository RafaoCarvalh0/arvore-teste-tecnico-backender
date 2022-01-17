defmodule ArvoreRepliWeb.NetworkControllerTest do
  use ArvoreRepliWeb.ConnCase

  import ArvoreRepli.NetworksFixtures

  alias ArvoreRepli.Networks.Network

  @create_attrs %{
    entity_type: "some entity_type",
    inep: "some inep",
    name: "some name",
    parent_id: "some parent_id"
  }
  @update_attrs %{
    entity_type: "some updated entity_type",
    inep: "some updated inep",
    name: "some updated name",
    parent_id: "some updated parent_id"
  }
  @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all networks", %{conn: conn} do
      conn = get(conn, Routes.network_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create network" do
    test "renders network when data is valid", %{conn: conn} do
      conn = post(conn, Routes.network_path(conn, :create), network: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.network_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "entity_type" => "some entity_type",
               "inep" => "some inep",
               "name" => "some name",
               "parent_id" => "some parent_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.network_path(conn, :create), network: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update network" do
    setup [:create_network]

    test "renders network when data is valid", %{conn: conn, network: %Network{id: id} = network} do
      conn = put(conn, Routes.network_path(conn, :update, network), network: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.network_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "entity_type" => "some updated entity_type",
               "inep" => "some updated inep",
               "name" => "some updated name",
               "parent_id" => "some updated parent_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, network: network} do
      conn = put(conn, Routes.network_path(conn, :update, network), network: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete network" do
    setup [:create_network]

    test "deletes chosen network", %{conn: conn, network: network} do
      conn = delete(conn, Routes.network_path(conn, :delete, network))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.network_path(conn, :show, network))
      end
    end
  end

  defp create_network(_) do
    network = network_fixture()
    %{network: network}
  end
end
