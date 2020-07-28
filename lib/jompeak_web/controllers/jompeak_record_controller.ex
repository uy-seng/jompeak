defmodule JompeakWeb.JompeakRecordController do
    use JompeakWeb, :controller

    alias Jompeak.Jompeak_record.Record
    alias Jompeak.Jompeak_record
    alias Jompeak.Repo

    def new(conn, _params) do
        render(conn, "new.html")
    end

    defp convert_to_float(conn, string) do
        #string must either be float or integer or else it will throw error
        cond do
            #check if string is float
            Regex.match?(~r{^(\d*\.)\d+$}, string) ->
                String.to_float(string)
            # check if string is integer
            Regex.match?(~r{^\d+$}, string) ->
                string = string<>".0"
                String.to_float(string)
            # else condition
            true ->
                conn
                |> put_flash(:error, "Invalid Input!")
                |> redirect(to: Routes.jompeak_record_path(conn, :new))
        end
    end   

    def create(conn, %{"jompeak_record" => %{"amount_owe" => amount_owe, "currency" => currency, "debtor_name" => debtor_name}}) do
    #Here will be the implementation
        amount_owe = convert_to_float(conn, amount_owe)
        case Jompeak_record.create_record(%{amount_owe: amount_owe, currency: currency, debtor_name: debtor_name}) do
            {:ok, new_record} ->
                conn
                |> put_flash(:info, "#{debtor_name}'s debt has been added to your record!")
                |> redirect(to: Routes.page_path(conn, :index))
            {:error, Record} ->
                Record
        end
    end


end