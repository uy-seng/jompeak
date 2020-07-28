defmodule Jompeak.Repo do
  use Ecto.Repo,
    otp_app: :jompeak,
    adapter: Ecto.Adapters.Postgres
end
