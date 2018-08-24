defmodule AuthWeb.BankController do
  use AuthWeb, :controller

  alias Auth.Banks
  alias Auth.Banks.Bank
  alias Auth.Accounts

  plug :check_auth when action in [:index, :new, :create, :edit, :update, :delete]

  defp check_auth(conn, _args) do
    if user_id = get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      conn
      |> assign(:current_user, current_user)
    else
      conn
      |> put_flash(:info, "You need to be signed in to access this page")
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end


  def index(conn, _params) do
    locations = Banks.list_locations()
    render(conn, "index.html", locations: locations)
  end

  def new(conn, _params) do
    changeset = Banks.change_bank(%Bank{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bank" => bank_params}) do
    case Banks.create_bank(bank_params) do
      {:ok, bank} ->
        conn
        |> put_flash(:info, "Bank created successfully.")
        |> redirect(to: bank_path(conn, :show, bank))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bank = Banks.get_bank!(id)
    render(conn, "show.html", bank: bank)
  end

  def edit(conn, %{"id" => id}) do
    bank = Banks.get_bank!(id)
    changeset = Banks.change_bank(bank)
    render(conn, "edit.html", bank: bank, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bank" => bank_params}) do
    bank = Banks.get_bank!(id)

    case Banks.update_bank(bank, bank_params) do
      {:ok, bank} ->
        conn
        |> put_flash(:info, "Bank updated successfully.")
        |> redirect(to: bank_path(conn, :show, bank))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bank: bank, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bank = Banks.get_bank!(id)
    {:ok, _bank} = Banks.delete_bank(bank)

    conn
    |> put_flash(:info, "Bank deleted successfully.")
    |> redirect(to: bank_path(conn, :index))
  end
end
