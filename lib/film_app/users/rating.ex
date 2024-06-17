defmodule FilmApp.Users.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :title, :string
    field :year, :integer
    field :rating, :float
    field :plot, :string
    field :actors, :string
    field :director, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:title, :rating, :year, :plot, :actors, :director])
    |> validate_required([:title, :rating, :year, :plot, :actors, :director])
  end
end
