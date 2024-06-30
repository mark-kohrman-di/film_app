defmodule FilmApp.Repo.Migrations.FilmsAddUserIdColumn do
  use Ecto.Migration

  def change do
    alter table("films") do
      add :films, :string
    end
  end
end
