defmodule Jompeak.CurrentUser do
    import Plug.Conn
    import Guardian.Plug

    def init(opts), do: opts
    def call(conn, _opts) do
        current_user = current_resource(conn) #Guardian.Plug.current_resource/1
        assign(conn, :current_user, current_user) #Plug.conn.assing/3
    end
end