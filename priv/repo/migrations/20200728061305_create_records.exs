defmodule Jompeak.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :debtor_name, :string
      add :amount_owe, :float
      add :currency, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:records, [:user_id])
  end
end
