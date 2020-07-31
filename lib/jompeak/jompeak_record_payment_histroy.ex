defmodule Jompeak.Jompeak_record_payment_histroy do
  @moduledoc """
  The Jompeak_record_payment_histroy context.
  """

  import Ecto.Query, warn: false
  alias Jompeak.Repo

  alias Jompeak.Jompeak_record_payment_histroy.Payment_histroy

  @doc """
  Returns the list of payment_histories.

  ## Examples

      iex> list_payment_histories()
      [%Payment_histroy{}, ...]

  """
  def list_payment_histories do
    Repo.all(Payment_histroy)
  end

  @doc """
  Gets a single payment_histroy.

  Raises `Ecto.NoResultsError` if the Payment histroy does not exist.

  ## Examples

      iex> get_payment_histroy!(123)
      %Payment_histroy{}

      iex> get_payment_histroy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payment_histroy!(id), do: Repo.get!(Payment_histroy, id)

  @doc """
  Creates a payment_histroy.

  ## Examples

      iex> create_payment_histroy(%{field: value})
      {:ok, %Payment_histroy{}}

      iex> create_payment_histroy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payment_histroy(attrs \\ %{}) do
    %Payment_histroy{}
    |> Payment_histroy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payment_histroy.

  ## Examples

      iex> update_payment_histroy(payment_histroy, %{field: new_value})
      {:ok, %Payment_histroy{}}

      iex> update_payment_histroy(payment_histroy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payment_histroy(%Payment_histroy{} = payment_histroy, attrs) do
    payment_histroy
    |> Payment_histroy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payment_histroy.

  ## Examples

      iex> delete_payment_histroy(payment_histroy)
      {:ok, %Payment_histroy{}}

      iex> delete_payment_histroy(payment_histroy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payment_histroy(%Payment_histroy{} = payment_histroy) do
    Repo.delete(payment_histroy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payment_histroy changes.

  ## Examples

      iex> change_payment_histroy(payment_histroy)
      %Ecto.Changeset{data: %Payment_histroy{}}

  """
  def change_payment_histroy(%Payment_histroy{} = payment_histroy, attrs \\ %{}) do
    Payment_histroy.changeset(payment_histroy, attrs)
  end
end
