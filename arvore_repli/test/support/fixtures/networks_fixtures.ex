defmodule ArvoreRepli.NetworksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArvoreRepli.Networks` context.
  """

  @doc """
  Generate a network.
  """
  def network_fixture(attrs \\ %{}) do
    {:ok, network} =
      attrs
      |> Enum.into(%{
        entity_type: "some entity_type",
        inep: "some inep",
        name: "some name",
        parent_id: "some parent_id"
      })
      |> ArvoreRepli.Networks.create_network()

    network
  end
end
