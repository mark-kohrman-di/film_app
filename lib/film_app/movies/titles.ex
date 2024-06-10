defmodule FilmApp.Movies.Titles do
  use Ecto.Schema
  import Ecto.Changeset

  schema "title" do
    field :name, :string
    field :description, :string
    field :year, :integer
    field :rating, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(titles, attrs) do
    titles
    |> cast(attrs, [:name, :rating, :year, :description])
    |> validate_required([:name, :rating, :year, :description])
  end
end
