defmodule FilmApp.Movies.Film do
  use Ecto.Schema
  import Ecto.Changeset
  #todo change module name to film, schema to films
  schema "films" do
    field :title, :string
    field :year, :integer
    field :plot, :string
    field :director, :string
    field :user_rating, :float
    field :poster_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(film, attrs) do
    film
    |> cast(attrs, [:title, :year, :plot, :director, :user_rating, :poster_url])
    |> validate_required([:title, :year, :plot, :director, :user_rating])
  end
end
