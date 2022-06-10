defmodule Housebook.OutgosTest do
  use Housebook.DataCase

  alias Housebook.Outgos

  describe "outgos" do
    alias Housebook.Outgos.Outgo

    import Housebook.OutgosFixtures

    @invalid_attrs %{group_id: nil, payment: nil}

    test "list_outgos/0 returns all outgos" do
      outgo = outgo_fixture()
      assert Outgos.list_outgos() == [outgo]
    end

    test "get_outgo!/1 returns the outgo with given id" do
      outgo = outgo_fixture()
      assert Outgos.get_outgo!(outgo.id) == outgo
    end

    test "create_outgo/1 with valid data creates a outgo" do
      valid_attrs = %{group_id: 42, payment: 42}

      assert {:ok, %Outgo{} = outgo} = Outgos.create_outgo(valid_attrs)
      assert outgo.group_id == 42
      assert outgo.payment == 42
    end

    test "create_outgo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Outgos.create_outgo(@invalid_attrs)
    end

    test "update_outgo/2 with valid data updates the outgo" do
      outgo = outgo_fixture()
      update_attrs = %{group_id: 43, payment: 43}

      assert {:ok, %Outgo{} = outgo} = Outgos.update_outgo(outgo, update_attrs)
      assert outgo.group_id == 43
      assert outgo.payment == 43
    end

    test "update_outgo/2 with invalid data returns error changeset" do
      outgo = outgo_fixture()
      assert {:error, %Ecto.Changeset{}} = Outgos.update_outgo(outgo, @invalid_attrs)
      assert outgo == Outgos.get_outgo!(outgo.id)
    end

    test "delete_outgo/1 deletes the outgo" do
      outgo = outgo_fixture()
      assert {:ok, %Outgo{}} = Outgos.delete_outgo(outgo)
      assert_raise Ecto.NoResultsError, fn -> Outgos.get_outgo!(outgo.id) end
    end

    test "change_outgo/1 returns a outgo changeset" do
      outgo = outgo_fixture()
      assert %Ecto.Changeset{} = Outgos.change_outgo(outgo)
    end
  end
end
