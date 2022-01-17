defmodule ArvoreRepliWeb.NetworkController do
  use ArvoreRepliWeb, :controller

  alias ArvoreRepli.Networks
  alias ArvoreRepli.Networks.Network

  action_fallback ArvoreRepliWeb.FallbackController

  def index(conn, _params) do
    networks = Networks.list_networks()
    render(conn, "index.json", networks: networks)
  end

  def create(conn, %{"network" => network_params}) do
    with {:ok, %Network{} = network} <- Networks.create_network(network_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.network_path(conn, :show, network))
      |> render("show.json", network: network)
    end
  end

  def show(conn, %{"id" => id}) do
    network = Networks.get_network!(id)
    render(conn, "show.json", network: network)
  end

  def update(conn, %{"id" => id, "network" => network_params}) do
    network = Networks.get_network!(id)

    with {:ok, %Network{} = network} <- Networks.update_network(network, network_params) do
      render(conn, "show.json", network: network)
    end
  end

  def delete(conn, %{"id" => id}) do
    network = Networks.get_network!(id)

    with {:ok, %Network{}} <- Networks.delete_network(network) do
      send_resp(conn, :no_content, "")
    end
  end
end
