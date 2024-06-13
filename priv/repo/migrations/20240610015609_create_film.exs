defmodule FilmApp.Repo.Migrations.CreateFilm do
  use Ecto.Migration

  def change do
    create table(:film) do
      add :title, :string
      add :year, :integer
      add :plot, :string
      add :director, :string
      add :user_rating, :float

      timestamps(type: :utc_datetime)
    end
  end
end
