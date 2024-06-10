defmodule FilmApp.PeopleTest do
  use FilmApp.DataCase

  alias FilmApp.People

  describe "director" do
    alias FilmApp.People.Directors

    import FilmApp.PeopleFixtures

    @invalid_attrs %{first_name: nil, last_name: nil}

    test "list_director/0 returns all director" do
      directors = directors_fixture()
      assert People.list_director() == [directors]
    end

    test "get_directors!/1 returns the directors with given id" do
      directors = directors_fixture()
      assert People.get_directors!(directors.id) == directors
    end

    test "create_directors/1 with valid data creates a directors" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name"}

      assert {:ok, %Directors{} = directors} = People.create_directors(valid_attrs)
      assert directors.first_name == "some first_name"
      assert directors.last_name == "some last_name"
    end

    test "create_directors/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_directors(@invalid_attrs)
    end

    test "update_directors/2 with valid data updates the directors" do
      directors = directors_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name"}

      assert {:ok, %Directors{} = directors} = People.update_directors(directors, update_attrs)
      assert directors.first_name == "some updated first_name"
      assert directors.last_name == "some updated last_name"
    end

    test "update_directors/2 with invalid data returns error changeset" do
      directors = directors_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_directors(directors, @invalid_attrs)
      assert directors == People.get_directors!(directors.id)
    end

    test "delete_directors/1 deletes the directors" do
      directors = directors_fixture()
      assert {:ok, %Directors{}} = People.delete_directors(directors)
      assert_raise Ecto.NoResultsError, fn -> People.get_directors!(directors.id) end
    end

    test "change_directors/1 returns a directors changeset" do
      directors = directors_fixture()
      assert %Ecto.Changeset{} = People.change_directors(directors)
    end
  end

  describe "actor" do
    alias FilmApp.People.Actors

    import FilmApp.PeopleFixtures

    @invalid_attrs %{first_name: nil, last_name: nil}

    test "list_actor/0 returns all actor" do
      actors = actors_fixture()
      assert People.list_actor() == [actors]
    end

    test "get_actors!/1 returns the actors with given id" do
      actors = actors_fixture()
      assert People.get_actors!(actors.id) == actors
    end

    test "create_actors/1 with valid data creates a actors" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name"}

      assert {:ok, %Actors{} = actors} = People.create_actors(valid_attrs)
      assert actors.first_name == "some first_name"
      assert actors.last_name == "some last_name"
    end

    test "create_actors/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_actors(@invalid_attrs)
    end

    test "update_actors/2 with valid data updates the actors" do
      actors = actors_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name"}

      assert {:ok, %Actors{} = actors} = People.update_actors(actors, update_attrs)
      assert actors.first_name == "some updated first_name"
      assert actors.last_name == "some updated last_name"
    end

    test "update_actors/2 with invalid data returns error changeset" do
      actors = actors_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_actors(actors, @invalid_attrs)
      assert actors == People.get_actors!(actors.id)
    end

    test "delete_actors/1 deletes the actors" do
      actors = actors_fixture()
      assert {:ok, %Actors{}} = People.delete_actors(actors)
      assert_raise Ecto.NoResultsError, fn -> People.get_actors!(actors.id) end
    end

    test "change_actors/1 returns a actors changeset" do
      actors = actors_fixture()
      assert %Ecto.Changeset{} = People.change_actors(actors)
    end
  end
end
