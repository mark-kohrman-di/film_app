defmodule FilmApp.People.Directors do
  use Ecto.Schema
  import Ecto.Changeset

  schema "director" do
    field :first_name, :string
    field :last_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(directors, attrs) do
    directors
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
