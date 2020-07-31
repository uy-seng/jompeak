defmodule JompeakWeb.JompeakRecordPaymentHistoryView do
    use JompeakWeb, :view
    alias Jompeak.Jompeak_record
    alias Jompeak.Jompeak_record_payment_histroy

    def get_user(id) do
        try do
            Jompeak_record.get_record!(id)
        rescue 
            Ecto.NoResultErorr ->
                {:error, "No query result found"}
        end
    end


end