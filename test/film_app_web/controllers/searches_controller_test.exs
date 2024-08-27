defmodule FilmAppWeb.SearchesControllerTest do
  use FilmAppWeb.ConnCase

  import FilmApp.MoviesFixtures

  @create_attrs %{
    title: "some title",
    director: "some director",
    release_year: "some release_year"
  }
  @update_attrs %{
    title: "some updated title",
    director: "some updated director",
    release_year: "some updated release_year"
  }
  @invalid_attrs %{title: nil, director: nil, release_year: nil}

  describe "index" do
    test "lists all search", %{conn: conn} do
      conn = get(conn, ~p"/search")
      assert html_response(conn, 200) =~ "Search Results"
    end
  end

  describe "new searches" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/search/new")
      assert html_response(conn, 200) =~ "Search Movies"
    end
  end

  describe "create searches" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/search", searches: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/film/new/#{id}"

      conn = get(conn, ~p"/film/new/#{id}")
      assert html_response(conn, 200) =~ "Searches #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/search", searches: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Searches"
    end
  end

  describe "edit searches" do
    setup [:create_searches]

    test "renders form for editing chosen searches", %{conn: conn, searches: searches} do
      conn = get(conn, ~p"/search/#{searches}/edit")
      assert html_response(conn, 200) =~ "Edit Searches"
    end
  end

  describe "update searches" do
    setup [:create_searches]

    test "redirects when data is valid", %{conn: conn, searches: searches} do
      conn = put(conn, ~p"/search/#{searches}", searches: @update_attrs)
      assert redirected_to(conn) == ~p"/search/#{searches}"

      conn = get(conn, ~p"/search/#{searches}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, searches: searches} do
      conn = put(conn, ~p"/search/#{searches}", searches: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Searches"
    end
  end

  describe "delete searches" do
    setup [:create_searches]

    test "deletes chosen searches", %{conn: conn, searches: searches} do
      conn = delete(conn, ~p"/search/#{searches}")
      assert redirected_to(conn) == ~p"/search"

      assert_error_sent 404, fn ->
        get(conn, ~p"/search/#{searches}")
      end
    end
  end

  defp create_searches(_) do
    searches = searches_fixture()
    %{searches: searches}
  end
end
