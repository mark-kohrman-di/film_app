defmodule FilmApp.Repo.Migrations.CreateTitle do
  use Ecto.Migration

  def change do
    create table(:title) do
      add :name, :string
      add :rating, :string
      add :year, :integer
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
