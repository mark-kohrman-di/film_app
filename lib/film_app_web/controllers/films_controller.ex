defmodule FilmAppWeb.FilmsController do
  use FilmAppWeb, :controller

  alias FilmApp.Repo
  alias FilmApp.Movies
  alias FilmApp.Movies.Film

  def index(conn, _params) do
    film = Movies.list_film()
    render(conn, :index, film: film)
  end

  def index_by_title(conn, _params) do
    film = Movies.list_film()
    render(conn, :index_by_title, film: film)
  end

  def index_user_films(conn, _params) do
    import Ecto.Query, only: [from: 2]

    if conn.assigns.current_user == nil do
      conn
      |> put_flash(:error, "Please login to view your ratings.")
      |> redirect(to: ~p"/users/log_in")
    end

    current_user_id = Integer.to_string(conn.assigns.current_user.id)

    film_query = from(f in Film, where: f.user_id == ^current_user_id)
    films = Repo.all(film_query)

    render(conn, :index_user_films, film: films)
  end


  def new(conn, %{"id" => id}) do
    url = "http://www.omdbapi.com/?apikey=#{System.get_env("OMDB_API_KEY")}&i=#{id}"
    validate_user(conn)
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> Jason.decode!()}
        decoded_body = body |> Jason.decode!()

        user_id = conn.assigns.current_user.id
        user_email = conn.assigns.current_user.email

        normalized_films = normalize_films(decoded_body, user_id, user_email)

        changeset =
          Movies.change_film(%Film{
            title: normalized_films.title,
            year: normalized_films.year,
            plot: normalized_films.plot,
            director: normalized_films.director,
            poster_url: normalized_films.poster_url,
            user_rating: normalized_films.user_rating,
            actors: normalized_films.actors,
            imdb_id: normalized_films.imdb_id,
            user_id: normalized_films.user_id,
            user_email: normalized_films.user_email
          })

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

            {:error, %Ecto.Changeset{} = _} ->
              conn
              |> put_flash(:error, "Error, this film has already been rated.")
              |> redirect(to: ~p"/film/new/#{films_params["imdb_id"]}")
          end
    end
  end

  def show(conn, %{"id" => id}) do
    films = Movies.get_films!(id)
    render(conn, :show, films: films)
  end

  def normalize_films(body, user_id, user_email) do
    films = %Film{
      id: body["imdbID"],
      title: body["Title"],
      year: body["Year"],
      plot: body["Plot"],
      director: body["Director"],
      poster_url: body["Poster"],
      user_rating: -1.0,
      actors: body["Actors"],
      imdb_id: body["imdbID"],
      user_id: user_id,
      user_email: user_email
    }

    films
  end

  def edit(conn, %{"id" => id}) do
    film = Movies.get_films!(id)
    validate_user(conn, film.user_id)

    changeset = Movies.change_film(film)
    render(conn, :edit, films: film, changeset: changeset)
  end

  def update(conn, %{"id" => id, "film" => films_params}) do
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
    film = Movies.get_films!(id)
    current_user_id = Integer.to_string(conn.assigns.current_user.id)

    if current_user_id == film.user_id do
      {:ok, _films} = Movies.delete_film(film)
      conn
      |> put_flash(:info, "Film deleted successfully.")
      |> redirect(to: ~p"/films/user")
    else
      conn
      |> put_flash(:error, "Error, you can only delete your own ratings.")
      |> redirect(to: ~p"/films/user")
    end

  end

  def validate_user(conn) do
    case conn.assigns.current_user do
      user when user != nil ->
        true
      user when user == nil ->
        conn
        |> put_flash(:error, "Error, please sign up or log in to rate.")
        |> redirect(to: ~p"/users/log_in")
      end
  end

  def validate_user(conn, film_user_id) do
    current_user_id = Integer.to_string(conn.assigns.current_user.id)
    case current_user_id do
      id when id == film_user_id ->
        true
      id when id != film_user_id ->
        conn
        |> put_flash(:error, "Error, you can only edit your own ratings.")
        |> redirect(to: ~p"/films/user")
      end
  end
end
