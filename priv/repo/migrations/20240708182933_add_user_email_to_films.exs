defmodule FilmApp.Repo.Migrations.AddUserEmailToFilms do
  use Ecto.Migration

  def change do
    alter table("films") do
      add :user_email, :string
    end
  end
end
