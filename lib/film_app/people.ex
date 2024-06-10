defmodule FilmApp.People do
  @moduledoc """
  The People context.
  """

  import Ecto.Query, warn: false
  alias FilmApp.Repo

  alias FilmApp.People.Directors

  @doc """
  Returns the list of director.

  ## Examples

      iex> list_director()
      [%Directors{}, ...]

  """
  def list_director do
    Repo.all(Directors)
  end

  @doc """
  Gets a single directors.

  Raises `Ecto.NoResultsError` if the Directors does not exist.

  ## Examples

      iex> get_directors!(123)
      %Directors{}

      iex> get_directors!(456)
      ** (Ecto.NoResultsError)

  """
  def get_directors!(id), do: Repo.get!(Directors, id)

  @doc """
  Creates a directors.

  ## Examples

      iex> create_directors(%{field: value})
      {:ok, %Directors{}}

      iex> create_directors(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_directors(attrs \\ %{}) do
    %Directors{}
    |> Directors.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a directors.

  ## Examples

      iex> update_directors(directors, %{field: new_value})
      {:ok, %Directors{}}

      iex> update_directors(directors, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_directors(%Directors{} = directors, attrs) do
    directors
    |> Directors.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a directors.

  ## Examples

      iex> delete_directors(directors)
      {:ok, %Directors{}}

      iex> delete_directors(directors)
      {:error, %Ecto.Changeset{}}

  """
  def delete_directors(%Directors{} = directors) do
    Repo.delete(directors)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking directors changes.

  ## Examples

      iex> change_directors(directors)
      %Ecto.Changeset{data: %Directors{}}

  """
  def change_directors(%Directors{} = directors, attrs \\ %{}) do
    Directors.changeset(directors, attrs)
  end

  alias FilmApp.People.Actors

  @doc """
  Returns the list of actor.

  ## Examples

      iex> list_actor()
      [%Actors{}, ...]

  """
  def list_actor do
    Repo.all(Actors)
  end

  @doc """
  Gets a single actors.

  Raises `Ecto.NoResultsError` if the Actors does not exist.

  ## Examples

      iex> get_actors!(123)
      %Actors{}

      iex> get_actors!(456)
      ** (Ecto.NoResultsError)

  """
  def get_actors!(id), do: Repo.get!(Actors, id)

  @doc """
  Creates a actors.

  ## Examples

      iex> create_actors(%{field: value})
      {:ok, %Actors{}}

      iex> create_actors(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_actors(attrs \\ %{}) do
    %Actors{}
    |> Actors.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a actors.

  ## Examples

      iex> update_actors(actors, %{field: new_value})
      {:ok, %Actors{}}

      iex> update_actors(actors, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_actors(%Actors{} = actors, attrs) do
    actors
    |> Actors.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a actors.

  ## Examples

      iex> delete_actors(actors)
      {:ok, %Actors{}}

      iex> delete_actors(actors)
      {:error, %Ecto.Changeset{}}

  """
  def delete_actors(%Actors{} = actors) do
    Repo.delete(actors)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking actors changes.

  ## Examples

      iex> change_actors(actors)
      %Ecto.Changeset{data: %Actors{}}

  """
  def change_actors(%Actors{} = actors, attrs \\ %{}) do
    Actors.changeset(actors, attrs)
  end
end
