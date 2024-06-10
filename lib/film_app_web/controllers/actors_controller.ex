defmodule FilmAppWeb.ActorsController do
  use FilmAppWeb, :controller

  alias FilmApp.People
  alias FilmApp.People.Actors

  def index(conn, _params) do
    actor = People.list_actor()
    render(conn, :index, actor: actor)
  end

  def new(conn, _params) do
    changeset = People.change_actors(%Actors{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"actors" => actors_params}) do
    case People.create_actors(actors_params) do
      {:ok, actors} ->
        conn
        |> put_flash(:info, "Actors created successfully.")
        |> redirect(to: ~p"/actor/#{actors}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    actors = People.get_actors!(id)
    render(conn, :show, actors: actors)
  end

  def edit(conn, %{"id" => id}) do
    actors = People.get_actors!(id)
    changeset = People.change_actors(actors)
    render(conn, :edit, actors: actors, changeset: changeset)
  end

  def update(conn, %{"id" => id, "actors" => actors_params}) do
    actors = People.get_actors!(id)

    case People.update_actors(actors, actors_params) do
      {:ok, actors} ->
        conn
        |> put_flash(:info, "Actors updated successfully.")
        |> redirect(to: ~p"/actor/#{actors}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, actors: actors, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    actors = People.get_actors!(id)
    {:ok, _actors} = People.delete_actors(actors)

    conn
    |> put_flash(:info, "Actors deleted successfully.")
    |> redirect(to: ~p"/actor")
  end
end
