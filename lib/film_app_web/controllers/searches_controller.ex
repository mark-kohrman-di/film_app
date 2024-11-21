defmodule FilmAppWeb.SearchesController do
  use FilmAppWeb, :controller

  alias FilmApp.Movies
  alias FilmApp.Movies.Searches

  def index(conn, _params) do
    search = Movies.list_search()

    render(conn, :index, search: search)
  end

  def index_searches(conn, searches) do
    render(conn, :index, search: searches)
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Movies.change_searches(%Searches{})
    render(conn, :new, changeset: changeset)
  end

  def search(conn, %{"searches" => searches_params}) do
    url =
      "http://www.omdbapi.com/?apikey=#{System.get_env("OMDB_API_KEY")}&s=#{searches_params["title"]}&type=movie"

    encoded_url = String.replace(url, " ", "%20")
    IO.inspect(encoded_url)

    case HTTPoison.get(encoded_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> Jason.decode!()}
        decoded_body = body |> Jason.decode!()

        if decoded_body["Response"] == "False" do
          conn
          |> put_flash(:error, "Error, movie not found, please try again.")
          |> render("new.html", changeset: Movies.change_searches(%Searches{}))
        end

        normalized = normalize_searches(decoded_body)
        index_searches(conn, normalized)

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Received non-200 response: #{status_code}"}
        conn
        |> put_flash(:error, "Error, movie not found, please try again.")
        |> render("new.html", changeset: Movies.change_searches(%Searches{}))

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed: #{reason}"}
    end
  end

  @spec normalize_searches(nil | maybe_improper_list() | map()) :: list()
  def normalize_searches(body) do
    coming_soon_url = "https://i.ibb.co/nbJHbhZ/no-image-available.png"

    films =
      Enum.map(body["Search"], fn movie ->
        poster_url = if movie["Poster"] == "N/A", do: coming_soon_url, else: movie["Poster"]

        %FilmApp.Movies.Searches{
          id: movie["imdbID"],
          title: movie["Title"],
          year: movie["Year"],
          poster_url: poster_url
        }
      end)

    films
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
