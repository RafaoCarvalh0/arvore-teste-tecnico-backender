defmodule ArvoreRepliWeb.EntityView do
  use ArvoreRepliWeb, :view
  alias ArvoreRepliWeb.EntityView

  def render("index.json", %{entities: entities}) do
    %{data: render_many(entities, EntityView, "allentites.json")}
  end

  def render("show.json", %{entity: entity}) do
    %{data: render_one(entity, EntityView, "entity.json")}
  end

  def render("entity.json", %{entity: entity, subtree: subtree}) do
    %{
      data: %{
        id: entity.id,
        name: entity.name,
        entity_type: entity.entity_type,
        inep: entity.inep,
        parent_id: entity.parent_id,
        subtree: subtree
      }
    }
  end

  def render("allentites.json", %{entity: entities}) do
    %{
      id: entities.id,
      name: entities.name,
      entity_type: entities.entity_type,
      inep: entities.inep,
      parent_id: entities.parent_id
    }
  end
end
