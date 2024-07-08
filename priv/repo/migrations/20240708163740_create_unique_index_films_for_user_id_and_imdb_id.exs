defmodule FilmApp.Repo.Migrations.CreateUniqueIndexFilmsForUserIdAndImdbId do
  use Ecto.Migration

  def change do
    create unique_index(:films, [:user_id, :imdb_id])
  end
end
