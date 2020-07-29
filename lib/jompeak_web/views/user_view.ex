defmodule JompeakWeb.UserView do
    use JompeakWeb, :view


    def get_user_currency(conn) do
        default_currency = ["USD", "KHR"]
        current_user = Guardian.Plug.current_resource(conn)
        default_currency = List.delete(default_currency, current_user.default_currency)
        default_currency = List.insert_at(default_currency, 0, current_user.default_currency)
    end

end