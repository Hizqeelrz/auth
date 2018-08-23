defmodule Auth.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :branch_name, :string
      add :total_employee, :integer
      add :branch_city, :string

      timestamps()
    end

  end
end
