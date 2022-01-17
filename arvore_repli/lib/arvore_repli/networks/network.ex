defmodule ArvoreRepli.Networks.Network do
  use Ecto.Schema
  import Ecto.Changeset

  schema "networks" do
    field :entity_type, :string
    field :inep, :string
    field :name, :string
    field :parent_id, :string

    timestamps()
  end

  @doc false
  def changeset(network, attrs) do
    network
    |> cast(attrs, [:name, :entity_type, :inep, :parent_id])
    |> validate_required([:name, :entity_type, :inep, :parent_id])
  end
end
