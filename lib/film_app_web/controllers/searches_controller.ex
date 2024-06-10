defmodule FilmAppWeb.SearchesController do
  use FilmAppWeb, :controller

  alias FilmApp.Movies
  alias FilmApp.Movies.Searches

  def index(conn, params) do
    search = Movies.list_search()
    IO.inspect("yo")
    IO.inspect(params)
    IO.inspect("yo")

    render(conn, :index, search: search)
  end

  def new(conn, params) do
    changeset = Movies.change_searches(%Searches{})
    IO.inspect("changeset")
    IO.inspect(changeset)
    IO.inspect("changeset")
    IO.inspect("params")
    IO.inspect(params)
    IO.inspect("params")

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"searches" => searches_params}) do
    case Movies.create_searches(searches_params) do
      {:ok, searches} ->
        conn
        |> put_flash(:info, "Searches created successfully.")
        |> redirect(to: ~p"/search/#{searches}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    searches = Movies.get_searches!(id)
    render(conn, :show, searches: searches)
  end

  def edit(conn, %{"id" => id}) do
    searches = Movies.get_searches!(id)
    changeset = Movies.change_searches(searches)
    render(conn, :edit, searches: searches, changeset: changeset)
  end

  def update(conn, %{"id" => id, "searches" => searches_params}) do
    searches = Movies.get_searches!(id)

    case Movies.update_searches(searches, searches_params) do
      {:ok, searches} ->
        conn
        |> put_flash(:info, "Searches updated successfully.")
        |> redirect(to: ~p"/search/#{searches}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, searches: searches, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    searches = Movies.get_searches!(id)
    {:ok, _searches} = Movies.delete_searches(searches)

    conn
    |> put_flash(:info, "Searches deleted successfully.")
    |> redirect(to: ~p"/search")
  end
end
