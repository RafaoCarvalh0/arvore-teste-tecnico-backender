defmodule ArvoreRepli.Repo.Migrations.CreateNetworks do
  use Ecto.Migration

  def change do
    create table(:networks) do
      add :name, :string
      add :entity_type, :string
      add :inep, :string
      add :parent_id, :string

      timestamps()
    end
  end
end
