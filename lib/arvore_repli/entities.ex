defmodule ArvoreRepli.Entities do
  @moduledoc """
  The Entities context.
  """

  import Ecto.Query, warn: false
  alias ArvoreRepli.Repo

  alias ArvoreRepli.Entities.Entity

  @doc """
  Returns the list of entities.

  ## Examples

      iex> list_entities()
      [%Entity{}, ...]

  """
  def list_entities do
    Repo.all(Entity)
  end

  @doc """
  Gets a single entity.

  Raises `Ecto.NoResultsError` if the Entity does not exist.

  ## Examples

      iex> get_entity!(123)
      %Entity{}

      iex> get_entity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entity!(id), do: Repo.get!(Entity, id)

  @doc """
  Creates a entity.

  ## Examples

      iex> create_entity(%{field: value})
      {:ok, %Entity{}}

      iex> create_entity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def get_parent_id!(id) do
    if is_nil(id) do
      nil
    else
      query =
        from e in "entities",
          where: e.id == ^id,
          select: e.id

      exists = Repo.all(query)

      if exists == [] do
        nil
      else
        exists
      end
    end
  end

  def get_subtree!(id, entity_type) do
    cond do
      is_nil(id.parent_id) and entity_type != "network" ->
        []

      entity_type == "network" ->
        ## "SELECT id from entities WHERE parent_id = ? AND entity_type = 'school'"
        query =
          from e in "entities",
            where: e.parent_id == ^id.id and e.entity_type == "school",
            select: e.id

        Repo.all(query)

      entity_type == "school" ->
        query =
          from e in "entities",
            where:
              (e.id == ^id.parent_id and e.entity_type == "network") or
                (e.entity_type == "class" and e.parent_id == ^id.id),
            select: e.id

        Repo.all(query)

      entity_type == "class" ->
        query =
          from e in "entities",
            where: e.id == ^id.parent_id and e.entity_type == "school",
            select: e.id

        Repo.all(query)
    end
  end

  def create_entity(attrs \\ %{}) do
    %Entity{}
    |> Entity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entity.

  ## Examples

      iex> update_entity(entity, %{field: new_value})
      {:ok, %Entity{}}

      iex> update_entity(entity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entity(%Entity{} = entity, attrs) do
    entity
    |> Entity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entity.

  ## Examples

      iex> delete_entity(entity)
      {:ok, %Entity{}}

      iex> delete_entity(entity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entity changes.

  ## Examples

      iex> change_entity(entity)
      %Ecto.Changeset{data: %Entity{}}

  """
  def change_entity(%Entity{} = entity, attrs \\ %{}) do
    Entity.changeset(entity, attrs)
  end
end
