defmodule FilmAppWeb.FilmsControllerTest do
  use FilmAppWeb.ConnCase

  import FilmApp.MoviesFixtures

  @create_attrs %{
    title: "some title",
    year: 42,
    plot: "some plot",
    director: "some director",
    user_rating: 120.5
  }
  @update_attrs %{
    title: "some updated title",
    year: 43,
    plot: "some updated plot",
    director: "some updated director",
    user_rating: 456.7
  }
  @invalid_attrs %{title: nil, year: nil, plot: nil, director: nil, user_rating: nil}

  describe "index" do
    test "lists all film", %{conn: conn} do
      conn = get(conn, ~p"/film")
      assert html_response(conn, 200) =~ "Listing Film"
    end
  end

  describe "new films" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/film/new")
      assert html_response(conn, 200) =~ "New Films"
    end
  end

  describe "create films" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/film/new/fakeid", films: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/film/#{id}"

      conn = get(conn, ~p"/film/#{id}")
      assert html_response(conn, 200) =~ "Films #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/film", films: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Films"
    end
  end

  describe "edit films" do
    setup [:create_films]

    test "renders form for editing chosen films", %{conn: conn, films: films} do
      conn = get(conn, ~p"/film/#{films}/edit")
      assert html_response(conn, 200) =~ "Edit Films"
    end
  end

  describe "update films" do
    setup [:create_films]

    test "redirects when data is valid", %{conn: conn, films: films} do
      conn = put(conn, ~p"/film/#{films}", films: @update_attrs)
      assert redirected_to(conn) == ~p"/film/#{films}"

      conn = get(conn, ~p"/film/#{films}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, films: films} do
      conn = put(conn, ~p"/film/#{films}", films: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Films"
    end
  end

  describe "delete films" do
    setup [:create_films]

    test "deletes chosen films", %{conn: conn, films: films} do
      conn = delete(conn, ~p"/film/#{films}")
      assert redirected_to(conn) == ~p"/film"

      assert_error_sent 404, fn ->
        get(conn, ~p"/film/#{films}")
      end
    end
  end

  defp create_films(_) do
    films = films_fixture()
    %{films: films}
  end
end
