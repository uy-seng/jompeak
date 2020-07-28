defmodule Jompeak.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :default_currency, :string, default: "USD"
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :username, :string

    has_many :records, Jompeak.Jompeak_record.Record
    timestamps()
  end

  @required_fields ~w(email username password)a
  @optional_fields ~w(default_currency)a

  @doc false
  def changeset(user, attrs \\%{}) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email, message: "Email already taken")
    |> unique_constraint(:username, message: "Username already existed.")
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
      _->
        changeset
        
    end
  end
end 