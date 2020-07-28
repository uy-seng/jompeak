defmodule JompeakWeb.CurrencyConverterView do
    use JompeakWeb, :view

    def get_currency_symbol() do
        case HTTPoison.get("http://data.fixer.io/api/latest?access_key=fb917c10a2386bbe337ea89bc7d5175c&format=1") do
		    {:ok, %{status_code: 200, body: body}} ->
                case Jason.decode(body) do
                   {:ok, %{"rates" => rates}} ->
                        Map.keys(rates)
                 
                end
	    end
    end
end