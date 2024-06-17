defmodule FilmApp.Repo.Migrations.AddPosterUrlToFilm do
  use Ecto.Migration

  def change do
    alter table(:films) do
      add :poster_url, :string
    end
  end
end
