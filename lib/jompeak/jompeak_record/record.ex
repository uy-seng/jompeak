defmodule Jompeak.Jompeak_record.Record do
  use Ecto.Schema
  import Ecto.Changeset

  schema "records" do
    field :amount_owe, :float
    field :currency, :string
    field :debtor_name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(record, attrs \\%{}) do
    record
    |> cast(attrs, [:debtor_name, :amount_owe, :currency])
    |> validate_required([:debtor_name, :amount_owe, :currency])
  end
end
