defmodule FilmApp.MoviesTest do
  use FilmApp.DataCase

  alias FilmApp.Movies

  describe "title" do
    alias FilmApp.Movies.Titles

    import FilmApp.MoviesFixtures

    @invalid_attrs %{name: nil, description: nil, year: nil, rating: nil}

    test "list_title/0 returns all title" do
      titles = titles_fixture()
      assert Movies.list_title() == [titles]
    end

    test "get_titles!/1 returns the titles with given id" do
      titles = titles_fixture()
      assert Movies.get_titles!(titles.id) == titles
    end

    test "create_titles/1 with valid data creates a titles" do
      valid_attrs = %{name: "some name", description: "some description", year: 42, rating: "some rating"}

      assert {:ok, %Titles{} = titles} = Movies.create_titles(valid_attrs)
      assert titles.name == "some name"
      assert titles.description == "some description"
      assert titles.year == 42
      assert titles.rating == "some rating"
    end

    test "create_titles/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_titles(@invalid_attrs)
    end

    test "update_titles/2 with valid data updates the titles" do
      titles = titles_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", year: 43, rating: "some updated rating"}

      assert {:ok, %Titles{} = titles} = Movies.update_titles(titles, update_attrs)
      assert titles.name == "some updated name"
      assert titles.description == "some updated description"
      assert titles.year == 43
      assert titles.rating == "some updated rating"
    end

    test "update_titles/2 with invalid data returns error changeset" do
      titles = titles_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_titles(titles, @invalid_attrs)
      assert titles == Movies.get_titles!(titles.id)
    end

    test "delete_titles/1 deletes the titles" do
      titles = titles_fixture()
      assert {:ok, %Titles{}} = Movies.delete_titles(titles)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_titles!(titles.id) end
    end

    test "change_titles/1 returns a titles changeset" do
      titles = titles_fixture()
      assert %Ecto.Changeset{} = Movies.change_titles(titles)
    end
  end


  describe "search" do
    alias FilmApp.Movies.Searches

    import FilmApp.MoviesFixtures

    @invalid_attrs %{title: nil}

    test "list_search/0 returns all search" do
      searches = searches_fixture()
      assert Movies.list_search() == [searches]
    end

    test "get_searches!/1 returns the searches with given id" do
      searches = searches_fixture()
      assert Movies.get_searches!(searches.id) == searches
    end

    test "create_searches/1 with valid data creates a searches" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Searches{} = searches} = Movies.create_searches(valid_attrs)
      assert searches.title == "some title"
    end

    test "create_searches/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_searches(@invalid_attrs)
    end

    test "update_searches/2 with valid data updates the searches" do
      searches = searches_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Searches{} = searches} = Movies.update_searches(searches, update_attrs)
      assert searches.title == "some updated title"
    end

    test "update_searches/2 with invalid data returns error changeset" do
      searches = searches_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_searches(searches, @invalid_attrs)
      assert searches == Movies.get_searches!(searches.id)
    end

    test "delete_searches/1 deletes the searches" do
      searches = searches_fixture()
      assert {:ok, %Searches{}} = Movies.delete_searches(searches)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_searches!(searches.id) end
    end

    test "change_searches/1 returns a searches changeset" do
      searches = searches_fixture()
      assert %Ecto.Changeset{} = Movies.change_searches(searches)
    end
  end

  describe "film" do
    alias FilmApp.Movies.Film

    import FilmApp.MoviesFixtures

    @invalid_attrs %{title: nil, year: nil, plot: nil, director: nil, user_rating: nil}

    test "list_film/0 returns all film" do
      films = films_fixture()
      assert Movies.list_film() == [films]
    end

    test "get_films!/1 returns the films with given id" do
      films = films_fixture()
      assert Movies.get_films!(films.id) == films
    end

    test "create_films/1 with valid data creates a films" do
      valid_attrs = %{
        title: "some title",
        year: 42,
        plot: "some plot",
        director: "some director",
        user_rating: 120.5,
        poster_url: "someposter.url",
        actors: "some actors",
        imdb_id: "some id"
      }

      assert {:ok, %Film{} = films} = Movies.create_films(valid_attrs)
      assert films.title == "some title"
      assert films.year == 42
      assert films.plot == "some plot"
      assert films.director == "some director"
      assert films.user_rating == 120.5
      assert films.poster_url == "someposter.url"
      assert films.actors == "some actors"
      assert films.imdb_id == "some id"



    end

    test "create_films/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_films(@invalid_attrs)
    end

    test "update_films/2 with valid data updates the films" do
      films = films_fixture()
      update_attrs = %{title: "some updated title", year: 43, plot: "some updated plot", director: "some updated director", user_rating: 456.7}

      assert {:ok, %Film{} = films} = Movies.update_films(films, update_attrs)
      assert films.title == "some updated title"
      assert films.year == 43
      assert films.plot == "some updated plot"
      assert films.director == "some updated director"
      assert films.user_rating == 456.7
    end

    test "update_films/2 with invalid data returns error changeset" do
      films = films_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_films(films, @invalid_attrs)
      assert films == Movies.get_films!(films.id)
    end

    test "delete_film/1 deletes the films" do
      films = films_fixture()
      assert {:ok, %Film{}} = Movies.delete_film(films)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_films!(films.id) end
    end

    test "change_film/1 returns a films changeset" do
      films = films_fixture()
      assert %Ecto.Changeset{} = Movies.change_film(films)
    end
  end
end
