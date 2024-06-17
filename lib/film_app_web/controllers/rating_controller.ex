defmodule FilmAppWeb.RatingController do
  use FilmAppWeb, :controller

  alias FilmApp.Users
  alias FilmApp.Users.Rating

  def index(conn, _params) do
    ratings = Users.list_ratings()
    render(conn, :index, ratings: ratings)
  end

  def new(conn, _params) do
    changeset = Users.change_rating(%Rating{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"rating" => rating_params}) do
    case Users.create_rating(rating_params) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating created successfully.")
        |> redirect(to: ~p"/ratings/#{rating}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rating = Users.get_rating!(id)
    render(conn, :show, rating: rating)
  end

  def edit(conn, %{"id" => id}) do
    rating = Users.get_rating!(id)
    changeset = Users.change_rating(rating)
    render(conn, :edit, rating: rating, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rating" => rating_params}) do
    rating = Users.get_rating!(id)

    case Users.update_rating(rating, rating_params) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating updated successfully.")
        |> redirect(to: ~p"/ratings/#{rating}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, rating: rating, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rating = Users.get_rating!(id)
    {:ok, _rating} = Users.delete_rating(rating)

    conn
    |> put_flash(:info, "Rating deleted successfully.")
    |> redirect(to: ~p"/ratings")
  end
end
