defmodule ArvoreRepliWeb.EntityController do
  use ArvoreRepliWeb, :controller

  alias ArvoreRepli.Entities
  alias ArvoreRepli.Entities.Entity

  action_fallback ArvoreRepliWeb.FallbackController

  def index(conn, _params) do
    entities = Entities.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
   ## IO.inspect("inspected")
   ## IO.inspect(entity_params.entity) NEED TO FIND HOW TO ACCESS AN ITEM ISIDE entity_params

    #case entity_params.entity_type do
      #{"network", "school", "class"} ->

        with {:ok, %Entity{} = entity} <- Entities.create_entity(entity_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.entity_path(conn, :show, entity))
          |> render("entity.json", entity: entity, subtree: Entities.get_subtree!(entity, entity.entity_type))
        #end
      #_ ->
          #conn
          #|> put_flash(:error, "o entity_type dever ser network, school ou class")

      end
  end

  def show(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)
    subtree = Entities.get_subtree!(entity, entity.entity_type)
    render(conn, "entity.json", entity: entity, subtree: subtree)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Entities.get_entity!(id)
    with {:ok, %Entity{} = entity} <- Entities.update_entity(entity, entity_params) do
      render(conn, "entity.json", entity: entity, subtree: Entities.get_subtree!(entity, entity.entity_type))
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Entities.get_entity!(id)

    with {:ok, %Entity{}} <- Entities.delete_entity(entity) do
      send_resp(conn, :no_content, "")
    end
  end
end