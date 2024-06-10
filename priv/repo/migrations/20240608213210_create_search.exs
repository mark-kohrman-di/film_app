defmodule FilmApp.Repo.Migrations.CreateSearch do
  use Ecto.Migration

  def change do
    create table(:search) do
      add :title, :string
      add :director, :string
      add :release_year, :string

      timestamps(type: :utc_datetime)
    end
  end
end
