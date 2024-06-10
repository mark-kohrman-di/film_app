defmodule FilmAppWeb.DirectorsControllerTest do
  use FilmAppWeb.ConnCase

  import FilmApp.PeopleFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{first_name: nil, last_name: nil}

  describe "index" do
    test "lists all director", %{conn: conn} do
      conn = get(conn, ~p"/director")
      assert html_response(conn, 200) =~ "Listing Director"
    end
  end

  describe "new directors" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/director/new")
      assert html_response(conn, 200) =~ "New Directors"
    end
  end

  describe "create directors" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/director", directors: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/director/#{id}"

      conn = get(conn, ~p"/director/#{id}")
      assert html_response(conn, 200) =~ "Directors #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/director", directors: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Directors"
    end
  end

  describe "edit directors" do
    setup [:create_directors]

    test "renders form for editing chosen directors", %{conn: conn, directors: directors} do
      conn = get(conn, ~p"/director/#{directors}/edit")
      assert html_response(conn, 200) =~ "Edit Directors"
    end
  end

  describe "update directors" do
    setup [:create_directors]

    test "redirects when data is valid", %{conn: conn, directors: directors} do
      conn = put(conn, ~p"/director/#{directors}", directors: @update_attrs)
      assert redirected_to(conn) == ~p"/director/#{directors}"

      conn = get(conn, ~p"/director/#{directors}")
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, directors: directors} do
      conn = put(conn, ~p"/director/#{directors}", directors: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Directors"
    end
  end

  describe "delete directors" do
    setup [:create_directors]

    test "deletes chosen directors", %{conn: conn, directors: directors} do
      conn = delete(conn, ~p"/director/#{directors}")
      assert redirected_to(conn) == ~p"/director"

      assert_error_sent 404, fn ->
        get(conn, ~p"/director/#{directors}")
      end
    end
  end

  defp create_directors(_) do
    directors = directors_fixture()
    %{directors: directors}
  end
end
