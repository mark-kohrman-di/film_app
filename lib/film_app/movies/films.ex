defmodule FilmApp.Movies.Films do
  use Ecto.Schema
  import Ecto.Changeset

  schema "film" do
    field :title, :string
    field :year, :integer
    field :plot, :string
    field :director, :string
    field :user_rating, :float
    field :poster_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(films, attrs) do
    films
    |> cast(attrs, [:title, :year, :plot, :director, :user_rating, :poster_url])
    |> validate_required([:title, :year, :plot, :director, :user_rating])
  end
end
