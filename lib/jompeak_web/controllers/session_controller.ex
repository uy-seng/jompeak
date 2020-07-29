defmodule JompeakWeb.SessionController do
    use JompeakWeb, :controller
    alias Jompeak.Repo
    alias Jompeak.Accounts.User
    import Bcrypt, only: [check_pass: 2, no_user_verify: 0]

    def new(conn, _) do
        render(conn, "new.html")
    end

    defp verify_email(user_struct,email) do
        try do
            user = Repo.get_by!(user_struct, email: email)
            {:ok, user}
        rescue
            Ecto.NoResultsError ->
                {:error, :no_found, "No result found"}
        end
    end

    # %{"email" => email, "password" => password}
    def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
        result = case verify_email(User, email) do
           {:ok, user} ->
                case Bcrypt.check_pass(user, password) do
                   {:ok, user} ->
                        conn
                        |> login(user)
                        |> put_flash(:info, "You're logged in")
                        |> redirect(to: Routes.page_path(conn, :index))
                    {:error, invalid_password} ->
                        conn
                        |> put_flash(:error, "Wrong password!")
                        |> redirect(to: Routes.session_path(conn, :new))        
                end
            {:error, :no_found, "No result found"}  ->
                conn
                |> put_flash(:error, "Invalid email/password combination")
                |> redirect(to: Routes.session_path(conn, :new))
            
        end
    end

    defp login(conn, user) do
        conn
        |> Guardian.Plug.sign_in(user)
    end

    def delete(conn, _) do
        # here will be an implementation
        conn
        |> logout()
        |> put_flash(:info, "See you later")
        |> redirect(to: Routes.page_path(conn, :index))
    end

    defp logout(conn) do
        Guardian.Plug.sign_out(conn)
    end
end