defmodule Jompeak.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string
      add :default_currency, :string, default: "USD"

      timestamps()
    end
    create unique_index(:users, [:username])
  end
end