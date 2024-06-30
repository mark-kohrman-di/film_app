defmodule FilmApp.Repo.Migrations.ChangeFilmsToUserId do
  use Ecto.Migration

  def change do
    rename table(:films), :films, to: :user_id
  end
end
