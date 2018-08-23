defmodule Auth.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt


  schema "users" do
    field :email, :string
    field :encrypted_password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password])
    |> validate_required([:email, :encrypted_password])
    |> unique_constraint(:email)
    |> update_change(:encrypted_password, &Bcrypt.hashpwsalt/1)
  end
end
