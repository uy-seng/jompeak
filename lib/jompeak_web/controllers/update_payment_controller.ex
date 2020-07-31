defmodule JompeakWeb.UpdatePaymentController do
    use JompeakWeb, :controller
    alias Jompeak.Jompeak_record

    def update_payment(conn, %{"id" => id}) do
        value = ""
        render(conn, "update_payment.html", id: id, value: value)
    end


    defp convert_to_float(conn, id,  string) do
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
                |> redirect(to: Routes.update_payment_path(conn, :update_payment, id))
        end
    end   

    defp convert_to_default_currency_rates(original_val, original_currency, default_currency) do
        case HTTPoison.get("http://data.fixer.io/api/latest?access_key=fb917c10a2386bbe337ea89bc7d5175c&format=1") do
            {:ok, %{status_code: 200, body: body}} ->
                case Jason.decode(body) do
                {:ok, %{"rates" => rates}} ->
                        case Map.fetch(rates, original_currency) do
                            {:ok, original_currency_val} ->
                                default_currency_rate = 1 / original_currency_val
                                case Map.fetch(rates, default_currency) do
                                    {:ok, default_currency_value}->
                                        default_currency_rate = default_currency_rate * default_currency_value * original_val
                                end
                        end
                
                end
        end
    end

    def create(conn, %{"submit_button" => submit_button, "id"=> id ,"update_form" => %{"payment_val" => payment_val, "payment_currency" => payment_currency}}) do
        case submit_button do
           "convert" ->
                payment_val = convert_to_float(conn, id, payment_val)
                value = convert_to_default_currency_rates(payment_val, payment_currency, Jompeak_record.get_record!(id).currency)
                value = Float.round(value, 5)
                value = Float.to_string(value, decimals: 5)
                render(conn, "update_payment.html", id: id, value: value)
            "submit" ->
                # payment_currency = convert_to_float(conn, id, payment_val)
                    payment_val = convert_to_float(conn, id, payment_val)
                    if Jompeak_record.get_record!(id).currency != payment_currency do
                        # convert payment to the currency in database
                        # xx -> data_base_currency
                        if convert_to_default_currency_rates(payment_val, payment_currency, Jompeak_record.get_record!(id).currency) > Jompeak_record.get_record!(id).amount_owe do
                            # throw error
                            conn
                            |> put_flash(:error, "Please enter the value between 1 and #{Kernel.trunc(Jompeak_record.get_record!(id).amount_owe)}")
                            |> redirect(to: Routes.update_payment_path(conn, :update_payment, id))
                        else
                            new_data = Jompeak_record.get_record!(id).amount_owe - convert_to_default_currency_rates(payment_val, payment_currency, Jompeak_record.get_record!(id).currency)
                            # conn |> put_flash(:convert, "") |> redirect(to: Routes.page_path(conn, :index))
                        end

                    else
                    end
            
        end

    end

end