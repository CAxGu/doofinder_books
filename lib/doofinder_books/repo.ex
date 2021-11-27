defmodule DoofinderBooks.Repo do
  use Ecto.Repo,
    otp_app: :doofinder_books,
    adapter: Ecto.Adapters.Postgres
end
