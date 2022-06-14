defmodule Housebook.Repo do
  use Ecto.Repo,
    otp_app: :housebook,
    adapter: Ecto.Adapters.Postgres

    use Scrivener, page_size: 10
end
