defmodule FilmAppWeb.ActorsControllerTest do
  use FilmAppWeb.ConnCase

  import FilmApp.PeopleFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{first_name: nil, last_name: nil}

  describe "index" do
    test "lists all actor", %{conn: conn} do
      conn = get(conn, ~p"/actor")
      assert html_response(conn, 200) =~ "Listing Actor"
    end
  end

  describe "new actors" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/actor/new")
      assert html_response(conn, 200) =~ "New Actors"
    end
  end

  describe "create actors" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/actor", actors: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/actor/#{id}"

      conn = get(conn, ~p"/actor/#{id}")
      assert html_response(conn, 200) =~ "Actors #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/actor", actors: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Actors"
    end
  end

  describe "edit actors" do
    setup [:create_actors]

    test "renders form for editing chosen actors", %{conn: conn, actors: actors} do
      conn = get(conn, ~p"/actor/#{actors}/edit")
      assert html_response(conn, 200) =~ "Edit Actors"
    end
  end

  describe "update actors" do
    setup [:create_actors]

    test "redirects when data is valid", %{conn: conn, actors: actors} do
      conn = put(conn, ~p"/actor/#{actors}", actors: @update_attrs)
      assert redirected_to(conn) == ~p"/actor/#{actors}"

      conn = get(conn, ~p"/actor/#{actors}")
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, actors: actors} do
      conn = put(conn, ~p"/actor/#{actors}", actors: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Actors"
    end
  end

  describe "delete actors" do
    setup [:create_actors]

    test "deletes chosen actors", %{conn: conn, actors: actors} do
      conn = delete(conn, ~p"/actor/#{actors}")
      assert redirected_to(conn) == ~p"/actor"

      assert_error_sent 404, fn ->
        get(conn, ~p"/actor/#{actors}")
      end
    end
  end

  defp create_actors(_) do
    actors = actors_fixture()
    %{actors: actors}
  end
end
