defmodule FilmApp.UsersTest do
  use FilmApp.DataCase

  alias FilmApp.Users

  describe "ratings" do
    alias FilmApp.Users.Rating

    import FilmApp.UsersFixtures

    @invalid_attrs %{title: nil, year: nil, rating: nil, plot: nil, actors: nil, director: nil}

    test "list_ratings/0 returns all ratings" do
      rating = rating_fixture()
      assert Users.list_ratings() == [rating]
    end

    test "get_rating!/1 returns the rating with given id" do
      rating = rating_fixture()
      assert Users.get_rating!(rating.id) == rating
    end

    test "create_rating/1 with valid data creates a rating" do
      valid_attrs = %{
        title: "some title",
        year: 42,
        rating: 120.5,
        plot: "some plot",
        actors: "some actors",
        director: "some director"
      }

      assert {:ok, %Rating{} = rating} = Users.create_rating(valid_attrs)
      assert rating.title == "some title"
      assert rating.year == 42
      assert rating.rating == 120.5
      assert rating.plot == "some plot"
      assert rating.actors == "some actors"
      assert rating.director == "some director"
    end

    test "create_rating/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_rating(@invalid_attrs)
    end

    test "update_rating/2 with valid data updates the rating" do
      rating = rating_fixture()

      update_attrs = %{
        title: "some updated title",
        year: 43,
        rating: 456.7,
        plot: "some updated plot",
        actors: "some updated actors",
        director: "some updated director"
      }

      assert {:ok, %Rating{} = rating} = Users.update_rating(rating, update_attrs)
      assert rating.title == "some updated title"
      assert rating.year == 43
      assert rating.rating == 456.7
      assert rating.plot == "some updated plot"
      assert rating.actors == "some updated actors"
      assert rating.director == "some updated director"
    end

    test "update_rating/2 with invalid data returns error changeset" do
      rating = rating_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_rating(rating, @invalid_attrs)
      assert rating == Users.get_rating!(rating.id)
    end

    test "delete_rating/1 deletes the rating" do
      rating = rating_fixture()
      assert {:ok, %Rating{}} = Users.delete_rating(rating)
      assert_raise Ecto.NoResultsError, fn -> Users.get_rating!(rating.id) end
    end

    test "change_rating/1 returns a rating changeset" do
      rating = rating_fixture()
      assert %Ecto.Changeset{} = Users.change_rating(rating)
    end
  end
end
