defmodule Housebook.Repo do
  use Ecto.Repo,
    otp_app: :housebook,
    adapter: Ecto.Adapters.Postgres
end
