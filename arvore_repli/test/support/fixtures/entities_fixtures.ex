defmodule ArvoreRepli.EntitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArvoreRepli.Entities` context.
  """

  @doc """
  Generate a entity.
  """
  def entity_fixture(attrs \\ %{}) do
    {:ok, entity} =
      attrs
      |> Enum.into(%{
        entity_type: "some entity_type",
        inep: "some inep",
        name: "some name",
        parent_id: 42
      })
      |> ArvoreRepli.Entities.create_entity()

    entity
  end
end
