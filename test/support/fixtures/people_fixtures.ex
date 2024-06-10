defmodule FilmApp.PeopleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FilmApp.People` context.
  """

  @doc """
  Generate a directors.
  """
  def directors_fixture(attrs \\ %{}) do
    {:ok, directors} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> FilmApp.People.create_directors()

    directors
  end

  @doc """
  Generate a actors.
  """
  def actors_fixture(attrs \\ %{}) do
    {:ok, actors} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> FilmApp.People.create_actors()

    actors
  end
end
