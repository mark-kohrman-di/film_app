defmodule FilmApp.Repo do
  use Ecto.Repo,
    otp_app: :film_app,
    adapter: Ecto.Adapters.Postgres
end
