defmodule Jompeak.Jompeak_record_payment_histroyTest do
  use Jompeak.DataCase

  alias Jompeak.Jompeak_record_payment_histroy

  describe "payment_histories" do
    alias Jompeak.Jompeak_record_payment_histroy.Payment_histroy

    @valid_attrs %{amount_owe: 120.5, amount_paid: 120.5, debtor_name: "some debtor_name", paid_status: true}
    @update_attrs %{amount_owe: 456.7, amount_paid: 456.7, debtor_name: "some updated debtor_name", paid_status: false}
    @invalid_attrs %{amount_owe: nil, amount_paid: nil, debtor_name: nil, paid_status: nil}

    def payment_histroy_fixture(attrs \\ %{}) do
      {:ok, payment_histroy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jompeak_record_payment_histroy.create_payment_histroy()

      payment_histroy
    end

    test "list_payment_histories/0 returns all payment_histories" do
      payment_histroy = payment_histroy_fixture()
      assert Jompeak_record_payment_histroy.list_payment_histories() == [payment_histroy]
    end

    test "get_payment_histroy!/1 returns the payment_histroy with given id" do
      payment_histroy = payment_histroy_fixture()
      assert Jompeak_record_payment_histroy.get_payment_histroy!(payment_histroy.id) == payment_histroy
    end

    test "create_payment_histroy/1 with valid data creates a payment_histroy" do
      assert {:ok, %Payment_histroy{} = payment_histroy} = Jompeak_record_payment_histroy.create_payment_histroy(@valid_attrs)
      assert payment_histroy.amount_owe == 120.5
      assert payment_histroy.amount_paid == 120.5
      assert payment_histroy.debtor_name == "some debtor_name"
      assert payment_histroy.paid_status == true
    end

    test "create_payment_histroy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jompeak_record_payment_histroy.create_payment_histroy(@invalid_attrs)
    end

    test "update_payment_histroy/2 with valid data updates the payment_histroy" do
      payment_histroy = payment_histroy_fixture()
      assert {:ok, %Payment_histroy{} = payment_histroy} = Jompeak_record_payment_histroy.update_payment_histroy(payment_histroy, @update_attrs)
      assert payment_histroy.amount_owe == 456.7
      assert payment_histroy.amount_paid == 456.7
      assert payment_histroy.debtor_name == "some updated debtor_name"
      assert payment_histroy.paid_status == false
    end

    test "update_payment_histroy/2 with invalid data returns error changeset" do
      payment_histroy = payment_histroy_fixture()
      assert {:error, %Ecto.Changeset{}} = Jompeak_record_payment_histroy.update_payment_histroy(payment_histroy, @invalid_attrs)
      assert payment_histroy == Jompeak_record_payment_histroy.get_payment_histroy!(payment_histroy.id)
    end

    test "delete_payment_histroy/1 deletes the payment_histroy" do
      payment_histroy = payment_histroy_fixture()
      assert {:ok, %Payment_histroy{}} = Jompeak_record_payment_histroy.delete_payment_histroy(payment_histroy)
      assert_raise Ecto.NoResultsError, fn -> Jompeak_record_payment_histroy.get_payment_histroy!(payment_histroy.id) end
    end

    test "change_payment_histroy/1 returns a payment_histroy changeset" do
      payment_histroy = payment_histroy_fixture()
      assert %Ecto.Changeset{} = Jompeak_record_payment_histroy.change_payment_histroy(payment_histroy)
    end
  end
end
