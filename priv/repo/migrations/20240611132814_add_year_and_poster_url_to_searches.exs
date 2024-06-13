defmodule FilmApp.Repo.Migrations.AddYearAndPosterUrlToSearches do
  use Ecto.Migration

  def change do
    alter table(:search) do
      add :poster_url, :string
      add :year, :integer
    end
  end
end
