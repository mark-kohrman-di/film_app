defmodule FilmApp.Movies.Searches do
  use Ecto.Schema
  import Ecto.Changeset

  schema "search" do
    field :title, :string
    field :poster_url, :string
    field :year, :string
    timestamps(type: :utc_datetime)
  end

  @spec changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => map(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(searches, attrs) do
    searches
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
