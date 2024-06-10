defmodule FilmApp.Repo.Migrations.CreateDirector do
  use Ecto.Migration

  def change do
    create table(:director) do
      add :first_name, :string
      add :last_name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
