defmodule FilmAppWeb.Router do
  use FilmAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FilmAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FilmAppWeb do
    pipe_through :browser

    get "/", PageController, :home

    get "/titles", TitlesController, :index
    get "/title", TitlesController, :index
    get "/title/new", TitlesController, :new
    post "/title", TitlesController, :create
    get "/title/:id", TitlesController, :show
    get "/title/:id/edit", TitlesController, :edit
    put "/title/:id", TitlesController, :update
    delete "/title/:id", TitlesController, :delete


    get "/actors", ActorsController, :index
    get "/actor", ActorsController, :index
    get "/actor/new", ActorsController, :new
    post "/actor", ActorsController, :create
    get "/actor/:id", ActorsController, :show
    get "/actor/:id/edit", ActorsController, :edit
    put "/actor/:id", ActorsController, :update
    delete "/actor/:id", ActorsController, :delete


    get "/directors", DirectorsController, :index
    get "/director", DirectorsController, :index
    get "/director/new", DirectorsController, :new
    post "/director", DirectorsController, :create
    get "/director/:id", DirectorsController, :show
    get "/director/:id/edit", DirectorsController, :edit
    put "/director/:id", DirectorsController, :update
    delete "/director/:id", DirectorsController, :delete

    get "/searches", SearchesController, :index
    get "/search", SearchesController, :index
    get "/search/new", SearchesController, :new
    post "/search", SearchesController, :create
    get "/search/:id", SearchesController, :show
    get "/search/:id/edit", SearchesController, :edit
    put "/search/:id", SearchesController, :update
    delete "/search/:id", SearchesController, :delete

    get "/films", FilmsController, :index
    get "/film", FilmsController, :index
    get "/film/new", FilmsController, :new
    post "/film", FilmsController, :create
    get "/film/:id", FilmsController, :show
    get "/film-s/:id", FilmsController, :show_film
    get "/film/:id/edit", FilmsController, :edit
    put "/film/:id", FilmsController, :update
    delete "/film/:id", FilmsController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", FilmAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:film_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FilmAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
