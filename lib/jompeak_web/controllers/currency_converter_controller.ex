defmodule JompeakWeb.CurrencyConverterController do
    use JompeakWeb, :controller

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
                |> redirect(to: Routes.currency_converter_path(conn, :new))
        end
    end  

    def create(conn, %{"currency_from" => currency_from, "currency_to" => currency_to, "value" => value}) do
        converted_val = 
            case HTTPoison.get("http://data.fixer.io/api/latest?access_key=fb917c10a2386bbe337ea89bc7d5175c&format=1") do
                {:ok, %{status_code: 200, body: body}} ->
                    case Jason.decode(body) do
                    {:ok, %{"rates" => rates}} ->
                            case Map.fetch(rates, currency_from) do
                                {:ok, currency_from_value} ->
                                    res = 1/currency_from_value
                                    case Map.fetch(rates, currency_to) do
                                       {:ok, currency_to_value}->
                                            res = res * currency_to_value * convert_to_float(conn, value)
                                            res = Float.round(res, 5)
                                            res = Float.to_string(res, decimals: 5)
                                    end
                            end
                    
                    end
            end
        conn
        |> put_flash(:info, "#{value} #{currency_from} is equal to #{converted_val} #{currency_to}")
        |> redirect(to: Routes.currency_converter_path(conn, :new))
    end

    # base currency is EUR
end