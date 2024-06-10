defmodule FilmApp.Repo.Migrations.CreateActor do
  use Ecto.Migration

  def change do
    create table(:actor) do
      add :first_name, :string
      add :last_name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
