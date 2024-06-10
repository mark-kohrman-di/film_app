defmodule FilmAppWeb.TitlesControllerTest do
  use FilmAppWeb.ConnCase

  import FilmApp.MoviesFixtures

  @create_attrs %{name: "some name", description: "some description", year: 42, rating: "some rating"}
  @update_attrs %{name: "some updated name", description: "some updated description", year: 43, rating: "some updated rating"}
  @invalid_attrs %{name: nil, description: nil, year: nil, rating: nil}

  describe "index" do
    test "lists all title", %{conn: conn} do
      conn = get(conn, ~p"/title")
      assert html_response(conn, 200) =~ "Listing Title"
    end
  end

  describe "new titles" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/title/new")
      assert html_response(conn, 200) =~ "New Titles"
    end
  end

  describe "create titles" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/title", titles: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/title/#{id}"

      conn = get(conn, ~p"/title/#{id}")
      assert html_response(conn, 200) =~ "Titles #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/title", titles: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Titles"
    end
  end

  describe "edit titles" do
    setup [:create_titles]

    test "renders form for editing chosen titles", %{conn: conn, titles: titles} do
      conn = get(conn, ~p"/title/#{titles}/edit")
      assert html_response(conn, 200) =~ "Edit Titles"
    end
  end

  describe "update titles" do
    setup [:create_titles]

    test "redirects when data is valid", %{conn: conn, titles: titles} do
      conn = put(conn, ~p"/title/#{titles}", titles: @update_attrs)
      assert redirected_to(conn) == ~p"/title/#{titles}"

      conn = get(conn, ~p"/title/#{titles}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, titles: titles} do
      conn = put(conn, ~p"/title/#{titles}", titles: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Titles"
    end
  end

  describe "delete titles" do
    setup [:create_titles]

    test "deletes chosen titles", %{conn: conn, titles: titles} do
      conn = delete(conn, ~p"/title/#{titles}")
      assert redirected_to(conn) == ~p"/title"

      assert_error_sent 404, fn ->
        get(conn, ~p"/title/#{titles}")
      end
    end
  end

  defp create_titles(_) do
    titles = titles_fixture()
    %{titles: titles}
  end
end
