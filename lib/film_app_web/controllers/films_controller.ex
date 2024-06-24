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

        normalized_films = normalize_films(decoded_body)

        changeset = Movies.change_film(
          %Film{
            title: normalized_films.title,
            year: normalized_films.year,
            plot: normalized_films.plot,
            director: normalized_films.director,
            poster_url: normalized_films.poster_url,
            user_rating: normalized_films.user_rating,
            actors: normalized_films.actors,
            imdb_id: normalized_films.imdb_id
          }
        )

        render(conn, :new, films: normalized_films, changeset: changeset)
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received non-200 response: #{status_code}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed: #{reason}"}
    end
  end

  def create(conn, %{"film" => films_params}) do
    user_rating = String.to_float(films_params["user_rating"])
    case user_rating do
      rating when rating < 0 ->
        conn
        |> put_flash(:error, "Error, please select a valid rating.")
        |> redirect(to: ~p"/film/new/#{films_params["imdb_id"]}")
      rating when rating >= 0 ->
        case Movies.create_films(films_params) do
        {:ok, films} ->
          conn
          |> put_flash(:info, "Rating saved successfully.")
          |> redirect(to: ~p"/film/#{films}")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :new, changeset: changeset)
      end

    end
  end

  def show(conn, %{"id" => id}) do
    films = Movies.get_films!(id)
    render(conn, :show, films: films)
  end


  def normalize_films(body) do
    films = %Film{
        id: body["imdbID"],
        title: body["Title"],
        year: body["Year"],
        plot: body["Plot"],
        director: body["Director"],
        poster_url: body["Poster"],
        user_rating: -1.0,
        actors: body["Actors"],
        imdb_id: body["imdbID"]
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
