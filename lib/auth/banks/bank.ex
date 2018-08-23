defmodule Auth.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset


  schema "locations" do
    field :branch_city, :string
    field :branch_name, :string
    field :total_employee, :integer

    timestamps()
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:branch_name, :total_employee, :branch_city])
    |> validate_required([:branch_name, :total_employee, :branch_city])
  end
end
