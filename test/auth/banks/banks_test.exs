defmodule Auth.BanksTest do
  use Auth.DataCase

  alias Auth.Banks

  describe "locations" do
    alias Auth.Banks.Bank

    @valid_attrs %{branch_city: "some branch_city", branch_name: "some branch_name", total_employee: 42}
    @update_attrs %{branch_city: "some updated branch_city", branch_name: "some updated branch_name", total_employee: 43}
    @invalid_attrs %{branch_city: nil, branch_name: nil, total_employee: nil}

    def bank_fixture(attrs \\ %{}) do
      {:ok, bank} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banks.create_bank()

      bank
    end

    test "list_locations/0 returns all locations" do
      bank = bank_fixture()
      assert Banks.list_locations() == [bank]
    end

    test "get_bank!/1 returns the bank with given id" do
      bank = bank_fixture()
      assert Banks.get_bank!(bank.id) == bank
    end

    test "create_bank/1 with valid data creates a bank" do
      assert {:ok, %Bank{} = bank} = Banks.create_bank(@valid_attrs)
      assert bank.branch_city == "some branch_city"
      assert bank.branch_name == "some branch_name"
      assert bank.total_employee == 42
    end

    test "create_bank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banks.create_bank(@invalid_attrs)
    end

    test "update_bank/2 with valid data updates the bank" do
      bank = bank_fixture()
      assert {:ok, bank} = Banks.update_bank(bank, @update_attrs)
      assert %Bank{} = bank
      assert bank.branch_city == "some updated branch_city"
      assert bank.branch_name == "some updated branch_name"
      assert bank.total_employee == 43
    end

    test "update_bank/2 with invalid data returns error changeset" do
      bank = bank_fixture()
      assert {:error, %Ecto.Changeset{}} = Banks.update_bank(bank, @invalid_attrs)
      assert bank == Banks.get_bank!(bank.id)
    end

    test "delete_bank/1 deletes the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{}} = Banks.delete_bank(bank)
      assert_raise Ecto.NoResultsError, fn -> Banks.get_bank!(bank.id) end
    end

    test "change_bank/1 returns a bank changeset" do
      bank = bank_fixture()
      assert %Ecto.Changeset{} = Banks.change_bank(bank)
    end
  end
end
