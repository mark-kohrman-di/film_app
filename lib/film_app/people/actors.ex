defmodule FilmApp.People.Actors do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actor" do
    field :first_name, :string
    field :last_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(actors, attrs) do
    actors
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
