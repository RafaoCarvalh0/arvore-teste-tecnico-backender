defmodule ArvoreRepli.NetworksTest do
  use ArvoreRepli.DataCase

  alias ArvoreRepli.Networks

  describe "networks" do
    alias ArvoreRepli.Networks.Network

    import ArvoreRepli.NetworksFixtures

    @invalid_attrs %{entity_type: nil, inep: nil, name: nil, parent_id: nil}

    test "list_networks/0 returns all networks" do
      network = network_fixture()
      assert Networks.list_networks() == [network]
    end

    test "get_network!/1 returns the network with given id" do
      network = network_fixture()
      assert Networks.get_network!(network.id) == network
    end

    test "create_network/1 with valid data creates a network" do
      valid_attrs = %{entity_type: "some entity_type", inep: "some inep", name: "some name", parent_id: "some parent_id"}

      assert {:ok, %Network{} = network} = Networks.create_network(valid_attrs)
      assert network.entity_type == "some entity_type"
      assert network.inep == "some inep"
      assert network.name == "some name"
      assert network.parent_id == "some parent_id"
    end

    test "create_network/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Networks.create_network(@invalid_attrs)
    end

    test "update_network/2 with valid data updates the network" do
      network = network_fixture()
      update_attrs = %{entity_type: "some updated entity_type", inep: "some updated inep", name: "some updated name", parent_id: "some updated parent_id"}

      assert {:ok, %Network{} = network} = Networks.update_network(network, update_attrs)
      assert network.entity_type == "some updated entity_type"
      assert network.inep == "some updated inep"
      assert network.name == "some updated name"
      assert network.parent_id == "some updated parent_id"
    end

    test "update_network/2 with invalid data returns error changeset" do
      network = network_fixture()
      assert {:error, %Ecto.Changeset{}} = Networks.update_network(network, @invalid_attrs)
      assert network == Networks.get_network!(network.id)
    end

    test "delete_network/1 deletes the network" do
      network = network_fixture()
      assert {:ok, %Network{}} = Networks.delete_network(network)
      assert_raise Ecto.NoResultsError, fn -> Networks.get_network!(network.id) end
    end

    test "change_network/1 returns a network changeset" do
      network = network_fixture()
      assert %Ecto.Changeset{} = Networks.change_network(network)
    end
  end
end
