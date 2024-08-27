defmodule FilmAppWeb.Router do
  use FilmAppWeb, :router

  import FilmAppWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FilmAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FilmAppWeb do
    pipe_through :browser

    get "/", SearchesController, :new

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

    get "/search/new", SearchesController, :new
    post "/search", SearchesController, :search
    get "/search/:id", SearchesController, :show
    get "/search/:id/edit", SearchesController, :edit
    put "/search/:id", SearchesController, :update
    delete "/search/:id", SearchesController, :delete

    get "/films", FilmsController, :index
    get "/films-by-title", FilmsController, :index_by_title
    get "/films/user", FilmsController, :index_user_films

    get "/film", FilmsController, :index
    get "/film/new/:id", FilmsController, :new
    post "/film", FilmsController, :create
    get "/film/:id", FilmsController, :show
    get "/film/:id/rate", FilmsController, :show_film
    get "/film/:id/edit", FilmsController, :edit
    put "/film/:id", FilmsController, :update
    delete "/film/:id", FilmsController, :delete

    get "/ratings", RatingController, :index
    get "/ratings/new", RatingController, :new
    post "/ratings", RatingController, :create
    get "/ratings/:id", RatingController, :show
    get "/ratings/:id/edit", RatingController, :edit
    put "/ratings/:id", RatingController, :update
    delete "/ratings/:id", RatingController, :delete
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

  ## Authentication routes

  scope "/", FilmAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FilmAppWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", FilmAppWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FilmAppWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", FilmAppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{FilmAppWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
