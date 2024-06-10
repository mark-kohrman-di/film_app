defmodule FilmApp.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FilmApp.Movies` context.
  """

  @doc """
  Generate a titles.
  """
  def titles_fixture(attrs \\ %{}) do
    {:ok, titles} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        rating: "some rating",
        year: 42
      })
      |> FilmApp.Movies.create_titles()

    titles
  end


  @doc """
  Generate a searches.
  """
  def searches_fixture(attrs \\ %{}) do
    {:ok, searches} =
      attrs
      |> Enum.into(%{
        director: "some director",
        release_year: "some release_year",
        title: "some title"
      })
      |> FilmApp.Movies.create_searches()

    searches
  end
end
