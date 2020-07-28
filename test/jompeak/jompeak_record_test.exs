defmodule Jompeak.Jompeak_recordTest do
  use Jompeak.DataCase

  alias Jompeak.Jompeak_record

  describe "records" do
    alias Jompeak.Jompeak_record.Record

    @valid_attrs %{amount_owe: 120.5, currency: "some currency", debtor_name: "some debtor_name"}
    @update_attrs %{amount_owe: 456.7, currency: "some updated currency", debtor_name: "some updated debtor_name"}
    @invalid_attrs %{amount_owe: nil, currency: nil, debtor_name: nil}

    def record_fixture(attrs \\ %{}) do
      {:ok, record} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jompeak_record.create_record()

      record
    end

    test "list_records/0 returns all records" do
      record = record_fixture()
      assert Jompeak_record.list_records() == [record]
    end

    test "get_record!/1 returns the record with given id" do
      record = record_fixture()
      assert Jompeak_record.get_record!(record.id) == record
    end

    test "create_record/1 with valid data creates a record" do
      assert {:ok, %Record{} = record} = Jompeak_record.create_record(@valid_attrs)
      assert record.amount_owe == 120.5
      assert record.currency == "some currency"
      assert record.debtor_name == "some debtor_name"
    end

    test "create_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jompeak_record.create_record(@invalid_attrs)
    end

    test "update_record/2 with valid data updates the record" do
      record = record_fixture()
      assert {:ok, %Record{} = record} = Jompeak_record.update_record(record, @update_attrs)
      assert record.amount_owe == 456.7
      assert record.currency == "some updated currency"
      assert record.debtor_name == "some updated debtor_name"
    end

    test "update_record/2 with invalid data returns error changeset" do
      record = record_fixture()
      assert {:error, %Ecto.Changeset{}} = Jompeak_record.update_record(record, @invalid_attrs)
      assert record == Jompeak_record.get_record!(record.id)
    end

    test "delete_record/1 deletes the record" do
      record = record_fixture()
      assert {:ok, %Record{}} = Jompeak_record.delete_record(record)
      assert_raise Ecto.NoResultsError, fn -> Jompeak_record.get_record!(record.id) end
    end

    test "change_record/1 returns a record changeset" do
      record = record_fixture()
      assert %Ecto.Changeset{} = Jompeak_record.change_record(record)
    end
  end
end
