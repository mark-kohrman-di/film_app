defmodule FilmAppWeb.TitlesController do
  use FilmAppWeb, :controller

  alias FilmApp.Movies
  alias FilmApp.Movies.Titles

  def index(conn, _params) do
    title = Movies.list_title()
    render(conn, :index, title: title)
  end

  def new(conn, _params) do
    changeset = Movies.change_titles(%Titles{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"titles" => titles_params}) do
    case Movies.create_titles(titles_params) do
      {:ok, titles} ->
        conn
        |> put_flash(:info, "Titles created successfully.")
        |> redirect(to: ~p"/title/#{titles}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    titles = Movies.get_titles!(id)
    render(conn, :show, titles: titles)
  end

  def edit(conn, %{"id" => id}) do
    titles = Movies.get_titles!(id)
    changeset = Movies.change_titles(titles)
    render(conn, :edit, titles: titles, changeset: changeset)
  end

  def update(conn, %{"id" => id, "titles" => titles_params}) do
    titles = Movies.get_titles!(id)

    case Movies.update_titles(titles, titles_params) do
      {:ok, titles} ->
        conn
        |> put_flash(:info, "Titles updated successfully.")
        |> redirect(to: ~p"/title/#{titles}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, titles: titles, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    titles = Movies.get_titles!(id)
    {:ok, _titles} = Movies.delete_titles(titles)

    conn
    |> put_flash(:info, "Titles deleted successfully.")
    |> redirect(to: ~p"/title")
  end
end
