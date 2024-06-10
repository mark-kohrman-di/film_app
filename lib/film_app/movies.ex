defmodule FilmApp.Movies do
  @moduledoc """
  The Movies context.
  """

  import Ecto.Query, warn: false
  alias FilmApp.Repo

  alias FilmApp.Movies.Titles

  @doc """
  Returns the list of title.

  ## Examples

      iex> list_title()
      [%Titles{}, ...]

  """
  def list_title do
    Repo.all(Titles)
  end

  @doc """
  Gets a single titles.

  Raises `Ecto.NoResultsError` if the Titles does not exist.

  ## Examples

      iex> get_titles!(123)
      %Titles{}

      iex> get_titles!(456)
      ** (Ecto.NoResultsError)

  """
  def get_titles!(id), do: Repo.get!(Titles, id)

  @doc """
  Creates a titles.

  ## Examples

      iex> create_titles(%{field: value})
      {:ok, %Titles{}}

      iex> create_titles(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_titles(attrs \\ %{}) do
    %Titles{}
    |> Titles.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a titles.

  ## Examples

      iex> update_titles(titles, %{field: new_value})
      {:ok, %Titles{}}

      iex> update_titles(titles, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_titles(%Titles{} = titles, attrs) do
    titles
    |> Titles.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a titles.

  ## Examples

      iex> delete_titles(titles)
      {:ok, %Titles{}}

      iex> delete_titles(titles)
      {:error, %Ecto.Changeset{}}

  """
  def delete_titles(%Titles{} = titles) do
    Repo.delete(titles)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking titles changes.

  ## Examples

      iex> change_titles(titles)
      %Ecto.Changeset{data: %Titles{}}

  """
  def change_titles(%Titles{} = titles, attrs \\ %{}) do
    Titles.changeset(titles, attrs)
  end


  alias FilmApp.Movies.Searches

  @doc """
  Returns the list of search.

  ## Examples

      iex> list_search()
      [%Searches{}, ...]

  """
  def list_search do
    Repo.all(Searches)
  end

  @doc """
  Gets a single searches.

  Raises `Ecto.NoResultsError` if the Searches does not exist.

  ## Examples

      iex> get_searches!(123)
      %Searches{}

      iex> get_searches!(456)
      ** (Ecto.NoResultsError)

  """
  def get_searches!(id), do: Repo.get!(Searches, id)

  @doc """
  Creates a searches.

  ## Examples

      iex> create_searches(%{field: value})
      {:ok, %Searches{}}

      iex> create_searches(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_searches(attrs \\ %{}) do
    %Searches{}
    |> Searches.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a searches.

  ## Examples

      iex> update_searches(searches, %{field: new_value})
      {:ok, %Searches{}}

      iex> update_searches(searches, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_searches(%Searches{} = searches, attrs) do
    searches
    |> Searches.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a searches.

  ## Examples

      iex> delete_searches(searches)
      {:ok, %Searches{}}

      iex> delete_searches(searches)
      {:error, %Ecto.Changeset{}}

  """
  def delete_searches(%Searches{} = searches) do
    Repo.delete(searches)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking searches changes.

  ## Examples

      iex> change_searches(searches)
      %Ecto.Changeset{data: %Searches{}}

  """
  def change_searches(%Searches{} = searches, attrs \\ %{}) do
    IO.inspect("searche")
    IO.inspect(searches)
    IO.inspect("searche")
    Searches.changeset(searches, attrs)
  end
end
