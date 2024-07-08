defmodule FilmApp.Repo.Migrations.CreateFilms do
  use Ecto.Migration
  # todo change table to films
  def change do
    create table(:films) do
      add :title, :string
      add :year, :integer
      add :plot, :string
      add :director, :string
      add :user_rating, :float

      timestamps(type: :utc_datetime)
    end
  end
end
