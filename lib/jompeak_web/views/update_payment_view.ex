defmodule JompeakWeb.UpdatePaymentView do
    use JompeakWeb, :view
    alias Jompeak.Jompeak_record

    def get_user(id) do
        try do
            Jompeak_record.get_record!(id)
        rescue 
            Ecto.NoResultErorr ->
                {:error, "No query result found"}
        end
    end

    def get_currency_symbol() do
        case HTTPoison.get("http://data.fixer.io/api/latest?access_key=fb917c10a2386bbe337ea89bc7d5175c&format=1") do
		    {:ok, %{status_code: 200, body: body}} ->
                case Jason.decode(body) do
                   {:ok, %{"rates" => rates}} ->
                        Map.keys(rates)
                 
                end
	    end
    end

    def convert_currency(original_val, original_currency, default_currency) do
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
                                        default_currency_rate = Float.round(default_currency_rate, 5)
                                        Float.to_string(default_currency_rate, decimals: 5)
                                end
                        end
                
                end
        end
    end

end