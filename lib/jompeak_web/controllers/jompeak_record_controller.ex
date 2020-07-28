defmodule JompeakWeb.JompeakRecordController do
    use JompeakWeb, :controller

    alias Jompeak.Jompeak_record.Record
    alias Jompeak.Repo

    def new(conn, _params) do
        render(conn, "new.html")
    end

    def create(conn, %{"jompeak_record" => %{"amount_owe" => amount_owe}}) do
    #Here will be the implementation
    end   
end