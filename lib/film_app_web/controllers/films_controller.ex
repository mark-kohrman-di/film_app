defmodule FilmAppWeb.FilmsController do
  use FilmAppWeb, :controller

  alias FilmApp.Movies
  alias FilmApp.Movies.Film

  def index(conn, _params) do
    film = Movies.list_film()
    render(conn, :index, film: film)
  end

  def new(conn, %{"id" => id}) do
    url = "http://www.omdbapi.com/?apikey=#{Application.get_env(:film_app, :api_key)}&i=#{id}"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> Jason.decode!()}
        decoded_body = body |> Jason.decode!()

        normalized = normalize_films(decoded_body)

        changeset = Movies.change_film(
          %Film{
            title: normalized.title,
            year: normalized.year,
            plot: normalized.plot,
            director: normalized.director,
            poster_url: normalized.poster_url,
            user_rating: normalized.user_rating
          }
        )

        render(conn, :new, films: normalized, changeset: changeset)
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received non-200 response: #{status_code}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed: #{reason}"}
    end
  end

  def create(conn, %{"film" => films_params}) do
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

  def show_film(conn, %{"id" => id}) do
    url = "http://www.omdbapi.com/?apikey=#{Application.get_env(:film_app, :api_key)}&i=#{id}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> Jason.decode!()}
        decoded_body = body |> Jason.decode!()

        normalized = normalize_films(decoded_body)
        render(conn, :show, films: normalized)
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received non-200 response: #{status_code}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed: #{reason}"}
    end

  end

  def normalize_films(body) do
    films = %Film{
        id: body["imdbID"],
        title: body["Title"],
        year: body["Year"],
        plot: body["Plot"],
        director: body["Director"],
        poster_url: body["Poster"],
        user_rating: 0
       }

    films
  end

  def edit(conn, %{"id" => id}) do
    films = Movies.get_films!(id)
    changeset = Movies.change_film(films)
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
    {:ok, _films} = Movies.delete_film(films)

    conn
    |> put_flash(:info, "Films deleted successfully.")
    |> redirect(to: ~p"/film")
  end
end
