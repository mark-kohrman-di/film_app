defmodule FilmApp.Repo.Migrations.RemoveDirectorAndYearFromSearch do
  use Ecto.Migration

  def change do
    alter table(:search) do
      remove :release_year
      remove :director
    end
  end
end
