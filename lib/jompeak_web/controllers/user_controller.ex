defmodule JompeakWeb.UserController do
  use JompeakWeb, :controller

  alias Jompeak.Accounts.User
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
end
