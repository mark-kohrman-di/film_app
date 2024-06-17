defmodule FilmApp.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :title, :string
      add :rating, :float
      add :year, :integer
      add :plot, :string
      add :actors, :string
      add :director, :string

      timestamps(type: :utc_datetime)
    end
  end
end
