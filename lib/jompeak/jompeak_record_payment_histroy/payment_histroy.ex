defmodule Jompeak.Jompeak_record_payment_histroy.Payment_histroy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payment_histories" do
    field :amount_owe, :float
    field :amount_paid, :float
    field :debtor_name, :string
    field :paid_status, :boolean, default: false
    field :record_id, :id

    timestamps()
  end

  @doc false
  def changeset(payment_histroy, attrs) do
    payment_histroy
    |> cast(attrs, [:debtor_name, :amount_owe, :amount_paid, :paid_status])
    |> validate_required([:debtor_name, :amount_owe, :amount_paid])
  end
end
