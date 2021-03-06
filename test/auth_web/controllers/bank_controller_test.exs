defmodule AuthWeb.BankControllerTest do
  use AuthWeb.ConnCase

  alias Auth.Banks

  @create_attrs %{branch_city: "some branch_city", branch_name: "some branch_name", total_employee: 42}
  @update_attrs %{branch_city: "some updated branch_city", branch_name: "some updated branch_name", total_employee: 43}
  @invalid_attrs %{branch_city: nil, branch_name: nil, total_employee: nil}

  def fixture(:bank) do
    {:ok, bank} = Banks.create_bank(@create_attrs)
    bank
  end

  describe "index" do
    test "lists all locations", %{conn: conn} do
      conn = get conn, bank_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Locations"
    end
  end

  describe "new bank" do
    test "renders form", %{conn: conn} do
      conn = get conn, bank_path(conn, :new)
      assert html_response(conn, 200) =~ "New Bank"
    end
  end

  describe "create bank" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, bank_path(conn, :create), bank: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == bank_path(conn, :show, id)

      conn = get conn, bank_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Bank"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, bank_path(conn, :create), bank: @invalid_attrs
      assert html_response(conn, 200) =~ "New Bank"
    end
  end

  describe "edit bank" do
    setup [:create_bank]

    test "renders form for editing chosen bank", %{conn: conn, bank: bank} do
      conn = get conn, bank_path(conn, :edit, bank)
      assert html_response(conn, 200) =~ "Edit Bank"
    end
  end

  describe "update bank" do
    setup [:create_bank]

    test "redirects when data is valid", %{conn: conn, bank: bank} do
      conn = put conn, bank_path(conn, :update, bank), bank: @update_attrs
      assert redirected_to(conn) == bank_path(conn, :show, bank)

      conn = get conn, bank_path(conn, :show, bank)
      assert html_response(conn, 200) =~ "some updated branch_city"
    end

    test "renders errors when data is invalid", %{conn: conn, bank: bank} do
      conn = put conn, bank_path(conn, :update, bank), bank: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Bank"
    end
  end

  describe "delete bank" do
    setup [:create_bank]

    test "deletes chosen bank", %{conn: conn, bank: bank} do
      conn = delete conn, bank_path(conn, :delete, bank)
      assert redirected_to(conn) == bank_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, bank_path(conn, :show, bank)
      end
    end
  end

  defp create_bank(_) do
    bank = fixture(:bank)
    {:ok, bank: bank}
  end
end
