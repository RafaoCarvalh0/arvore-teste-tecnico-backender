defmodule ArvoreRepli.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entities" do
    field :entity_type, :string
    field :inep, :string
    field :name, :string
    field :parent_id, :integer

    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :entity_type, :inep, :parent_id])
    |> validate_required([:name, :entity_type])
  end
end
