defmodule ArvoreRepliWeb.NetworkView do
  use ArvoreRepliWeb, :view
  alias ArvoreRepliWeb.NetworkView

  def render("index.json", %{networks: networks}) do
    %{data: render_many(networks, NetworkView, "network.json")}
  end

  def render("show.json", %{network: network}) do
    %{data: render_one(network, NetworkView, "network.json")}
  end

  def render("network.json", %{network: network}) do
    %{
      id: network.id,
      name: network.name,
      entity_type: network.entity_type,
      inep: network.inep,
      parent_id: network.parent_id
    }
  end
end
