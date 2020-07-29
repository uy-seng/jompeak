defmodule JompeakWeb.UserController do
  use JompeakWeb, :controller

  alias Jompeak.Accounts.User
  alias Jompeak.Accounts
  alias Jompeak.Repo

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"user" => user_params}) do
        #here will be an implementation
        changeset = %User{}  |>
        User.registration_changeset(user_params)

        case Repo.insert(changeset) do
           {:ok, user} ->
                conn
                |> Guardian.Plug.sign_in(user)
                |> put_flash(:info, "#{user.username} created !")
                |> redirect(to: Routes.page_path(conn, :index))
            {:error, changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def setting(conn, _params) do
        render(conn, "setting.html")
    end

    def update(conn, %{"changes" => %{"changes_default_currency" => changes_default_currency, "changes_password" => changes_password, "changes_username" => changes_username}, "id" => id}) do
        # do something
        user = Accounts.get_user!(id)
        cond do
            changes_default_currency != user.default_currency ->
                Accounts.update_user(user, %{default_currency: changes_default_currency})
                conn
                |> put_flash(:info, "Default currency updated !")
                |> redirect(to: Routes.user_path(conn, :setting))
            String.length(String.trim(changes_password)) != 0 and Bcrypt.check_pass(changes_password,user.password_hash) ->
                changes_password = Bcrypt.hash_pwd_salt(changes_password)
                Accounts.update_user(user, %{password_hash: changes_password})
                conn
                |> put_flash(:info, "Password updated !")
                |> redirect(to: Routes.user_path(conn, :setting))
            String.length(String.trim(changes_username)) != 0 and changes_username !=  user.username ->
                Accounts.update_user(user, %{user_name: changes_username})
                conn
                |> put_flash(:info, "Username updated !")
                |> redirect(to: Routes.user_path(conn, :setting))
            true ->
                conn
                |> put_flash(:error, "No changes were made :( ")
                |> redirect(to: Routes.user_path(conn, :setting))
            
        end
    end
end
