defmodule FilmAppWeb.FilmsController do
  use FilmAppWeb, :controller

  alias FilmApp.Movies
  alias FilmApp.Movies.Films

  def index(conn, _params) do
    film = Movies.list_film()
    render(conn, :index, film: film)
  end

  def new(conn, _params) do
    changeset = Movies.change_films(%Films{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"films" => films_params}) do
    case Movies.create_films(films_params) do
      {:ok, films} ->
        conn
        |> put_flash(:info, "Films created successfully.")
        |> redirect(to: ~p"/film/#{films}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    films = Movies.get_films!(id)
    render(conn, :show, films: films)
  end

  def edit(conn, %{"id" => id}) do
    films = Movies.get_films!(id)
    changeset = Movies.change_films(films)
    render(conn, :edit, films: films, changeset: changeset)
  end

  def update(conn, %{"id" => id, "films" => films_params}) do
    films = Movies.get_films!(id)

    case Movies.update_films(films, films_params) do
      {:ok, films} ->
        conn
        |> put_flash(:info, "Films updated successfully.")
        |> redirect(to: ~p"/film/#{films}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, films: films, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    films = Movies.get_films!(id)
    {:ok, _films} = Movies.delete_films(films)

    conn
    |> put_flash(:info, "Films deleted successfully.")
    |> redirect(to: ~p"/film")
  end
end
