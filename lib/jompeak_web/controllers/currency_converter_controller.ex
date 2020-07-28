defmodule JompeakWeb.CurrencyConverterController do
    use JompeakWeb, :controller

    def new(conn, _params) do
        render(conn, "new.html")
    end
end