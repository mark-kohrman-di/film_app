defmodule FilmAppWeb.DirectorsController do
  use FilmAppWeb, :controller

  alias FilmApp.People
  alias FilmApp.People.Directors

  def index(conn, _params) do
    director = People.list_director()
    render(conn, :index, director: director)
  end

  def new(conn, _params) do
    changeset = People.change_directors(%Directors{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"directors" => directors_params}) do
    case People.create_directors(directors_params) do
      {:ok, directors} ->
        conn
        |> put_flash(:info, "Directors created successfully.")
        |> redirect(to: ~p"/director/#{directors}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    directors = People.get_directors!(id)
    render(conn, :show, directors: directors)
  end

  def edit(conn, %{"id" => id}) do
    directors = People.get_directors!(id)
    changeset = People.change_directors(directors)
    render(conn, :edit, directors: directors, changeset: changeset)
  end

  def update(conn, %{"id" => id, "directors" => directors_params}) do
    directors = People.get_directors!(id)

    case People.update_directors(directors, directors_params) do
      {:ok, directors} ->
        conn
        |> put_flash(:info, "Directors updated successfully.")
        |> redirect(to: ~p"/director/#{directors}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, directors: directors, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    directors = People.get_directors!(id)
    {:ok, _directors} = People.delete_directors(directors)

    conn
    |> put_flash(:info, "Directors deleted successfully.")
    |> redirect(to: ~p"/director")
  end
end
