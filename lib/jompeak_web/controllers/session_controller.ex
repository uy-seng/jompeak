defmodule JompeakWeb.SessionController do
    use JompeakWeb, :controller
    alias Jompeak.Repo
    alias Jompeak.Accounts.User
    import Bcrypt, only: [check_pass: 2, no_user_verify: 0]

    def new(conn, _) do
        render(conn, "new.html")
    end


    # %{"email" => email, "password" => password}
    def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
        # here will be an implementation

        #try to get user by unique email from database
        user = Repo.get_by(User, email: email) 
        #examine the result
        result = cond do
            # if user was found and provided password hash equals to stored hash
            user && check_pass(password, user.password_hash) ->
                {:ok, login(conn, user)}
            # else if we just found the user
            user ->
                {:error, :unauthorized, conn}
            # otherwise
            true ->
                no_user_verify()
                {:error, :not_found, conn}
        end

        case result do
            {:ok, conn} ->
                conn
                |> put_flash(:info, "You're now logged in")
                |> redirect(to: Routes.page_path(conn, :index))
            {:error, _reason, conn} ->
                conn
                |> put_flash(:error, "Invalid email/password combination")
                |> render("new.html")
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