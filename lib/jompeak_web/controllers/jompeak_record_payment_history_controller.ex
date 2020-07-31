defmodule JompeakWeb.JompeakRecordPaymentHistoryController do
    use JompeakWeb, :controller

    def show_payment_history(conn, %{"id" => id}) do
        render(conn, "show.html", id: id) 
    end
end