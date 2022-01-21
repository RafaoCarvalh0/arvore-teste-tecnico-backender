defmodule ArvoreRepliWeb.EntityControllerTest do
  use ArvoreRepliWeb.ConnCase

  import ArvoreRepli.EntitiesFixtures

  alias ArvoreRepli.Entities.Entity

  @create_attrs %{
    entity_type: "some entity_type",
    inep: "some inep",
    name: "some name",
    parent_id: 42
  }
  @class_attrs_parent_id_null %{
    entity_type: "class",
    inep: "some inep",
    name: "some name",
    parent_id: nil
  }
  @class_attrs_parent_id_9999 %{
    entity_type: "class",
    inep: "some inep",
    name: "some name",
    parent_id: 9999
  }
  @update_attrs %{
    entity_type: "some updated entity_type",
    inep: "some updated inep",
    name: "some updated name",
    parent_id: 43
  }
  @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all entities", %{conn: conn} do
      conn = get(conn, Routes.entity_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create entity" do
    test "Bad Request (400) when entity_type is != network, school or class", %{
      conn: conn
    } do
      conn = post(conn, Routes.entity_path(conn, :create), entity: @create_attrs)

      assert %{
               "detail" => "Bad Request"
             } = json_response(conn, 400)["errors"]
    end

    test "Bad Request (400) when entity_type = class and parent_id = null", %{
      conn: conn
    } do
      conn = post(conn, Routes.entity_path(conn, :create), entity: @class_attrs_parent_id_null)

      assert %{
               "detail" => "Bad Request"
             } = json_response(conn, 400)["errors"]
    end

    test "Bad Request (400) when entity_type = class and parent_id does not exists in database", %{
      conn: conn
    } do
      conn = post(conn, Routes.entity_path(conn, :create), entity: @class_attrs_parent_id_9999)

      assert %{
               "detail" => "Bad Request"
             } = json_response(conn, 400)["errors"]
    end

    @doc """
        CREATE is suposed to render entity as response when data is valid. This one ins't needed

        test "renders entity when data is valid", %{conn: conn} do
          conn = post(conn, Routes.entity_path(conn, :create), entity: @create_attrs)
          assert %{"id" => id} = json_response(conn, 201)["data"]

          conn = get(conn, Routes.entity_path(conn, :show, id))

          assert %{
                  "id" => ^id,
                  "entity_type" => "some entity_type",
                  "inep" => "some inep",
                  "name" => "some name",
                  "parent_id" => 42
                } = json_response(conn, 200)["data"]
      end
    """
  end

  test "renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, Routes.entity_path(conn, :create), entity: @invalid_attrs)
    assert json_response(conn, 400)["errors"] != %{}
  end

  describe "update entity" do
    setup [:create_entity]

    @doc """

    UPDATE is suposed to render entity as response when data is valid. This one ins't needed

    test "renders entity when data is valid", %{conn: conn, entity: %Entity{id: id} = entity} do
    conn = put(conn, Routes.entity_path(conn, :update, entity), entity: @update_attrs)
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get(conn, Routes.entity_path(conn, :show, id))

    assert %{
             "id" => ^id,
             "entity_type" => "some updated entity_type",
             "inep" => "some updated inep",
             "name" => "some updated name",
             "parent_id" => 43
           } = json_response(conn, 200)["data"]
    end
    """

    test "renders errors when data is invalid", %{conn: conn, entity: entity} do
      conn = put(conn, Routes.entity_path(conn, :update, entity), entity: @invalid_attrs)
      assert json_response(conn, 400)["errors"] != %{}
    end

    test "Bad Request (400) when entity_type is != network, school or class", %{
      conn: conn,
      entity: entity
    } do
      conn = put(conn, Routes.entity_path(conn, :update, entity), entity: @update_attrs)

      assert %{
               "detail" => "Bad Request"
             } = json_response(conn, 400)["errors"]
    end

    test "Bad Request (400) when entity_type = class and parent_id = null", %{
      conn: conn,
      entity: entity
    } do
      conn =
        put(conn, Routes.entity_path(conn, :update, entity), entity: @class_attrs_parent_id_null)

      assert %{
               "detail" => "Bad Request"
             } = json_response(conn, 400)["errors"]
    end

    test "Bad Request (400) when entity_type = class and parent_id does not exists in database", %{
      conn: conn,
      entity: entity
    } do
      conn =
        put(conn, Routes.entity_path(conn, :update, entity), entity: @class_attrs_parent_id_9999)

      assert %{
               "detail" => "Bad Request"
             } = json_response(conn, 400)["errors"]
    end

  end

  describe "delete entity" do
    setup [:create_entity]

    test "deletes chosen entity", %{conn: conn, entity: entity} do
      conn = delete(conn, Routes.entity_path(conn, :delete, entity))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.entity_path(conn, :show, entity))
      end
    end
  end

  defp create_entity(_) do
    entity = entity_fixture()
    %{entity: entity}
  end
end
