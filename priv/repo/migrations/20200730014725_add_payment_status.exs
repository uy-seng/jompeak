defmodule Jompeak.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    alter table(:records) do
      add :payment_status, :boolean, default: false
    end
  end
end
