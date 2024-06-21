defmodule FilmApp.Repo.Migrations.FilmsAddImdbIdAndActors do
  use Ecto.Migration

  def change do
    alter table("films") do
      add :actors, :string
      add :imdb_id, :string
    end
  end

end
