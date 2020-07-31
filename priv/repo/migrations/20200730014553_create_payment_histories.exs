defmodule Jompeak.Repo.Migrations.CreatePaymentHistories do
  use Ecto.Migration

  def change do
    create table(:payment_histories) do
      add :debtor_name, :string
      add :amount_owe, :float
      add :amount_paid, :float
      add :paid_status, :boolean, default: false, null: false
      add :record_id, references(:records, on_delete: :nothing)

      timestamps()
    end

    create index(:payment_histories, [:record_id])
  end
end
