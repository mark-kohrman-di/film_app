defmodule FilmApp.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FilmApp.Users` context.
  """

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{
        actors: "some actors",
        director: "some director",
        plot: "some plot",
        rating: 120.5,
        title: "some title",
        year: 42
      })
      |> FilmApp.Users.create_rating()

    rating
  end
end
