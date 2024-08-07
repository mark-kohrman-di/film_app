defmodule FilmAppWeb.RatingControllerTest do
  use FilmAppWeb.ConnCase

  import FilmApp.UsersFixtures

  @create_attrs %{
    title: "some title",
    year: 42,
    rating: 120.5,
    plot: "some plot",
    actors: "some actors",
    director: "some director"
  }
  @update_attrs %{
    title: "some updated title",
    year: 43,
    rating: 456.7,
    plot: "some updated plot",
    actors: "some updated actors",
    director: "some updated director"
  }
  @invalid_attrs %{title: nil, year: nil, rating: nil, plot: nil, actors: nil, director: nil}

  describe "index" do
    test "lists all ratings", %{conn: conn} do
      conn = get(conn, ~p"/ratings")
      assert html_response(conn, 200) =~ "Listing Ratings"
    end
  end

  describe "new rating" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/ratings/new")
      assert html_response(conn, 200) =~ "New Rating"
    end
  end

  describe "create rating" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/ratings", rating: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/ratings/#{id}"

      conn = get(conn, ~p"/ratings/#{id}")
      assert html_response(conn, 200) =~ "Rating #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/ratings", rating: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Rating"
    end
  end

  describe "edit rating" do
    setup [:create_rating]

    test "renders form for editing chosen rating", %{conn: conn, rating: rating} do
      conn = get(conn, ~p"/ratings/#{rating}/edit")
      assert html_response(conn, 200) =~ "Edit Rating"
    end
  end

  describe "update rating" do
    setup [:create_rating]

    test "redirects when data is valid", %{conn: conn, rating: rating} do
      conn = put(conn, ~p"/ratings/#{rating}", rating: @update_attrs)
      assert redirected_to(conn) == ~p"/ratings/#{rating}"

      conn = get(conn, ~p"/ratings/#{rating}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, rating: rating} do
      conn = put(conn, ~p"/ratings/#{rating}", rating: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Rating"
    end
  end

  describe "delete rating" do
    setup [:create_rating]

    test "deletes chosen rating", %{conn: conn, rating: rating} do
      conn = delete(conn, ~p"/ratings/#{rating}")
      assert redirected_to(conn) == ~p"/ratings"

      assert_error_sent 404, fn ->
        get(conn, ~p"/ratings/#{rating}")
      end
    end
  end

  defp create_rating(_) do
    rating = rating_fixture()
    %{rating: rating}
  end
end
