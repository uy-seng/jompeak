defmodule JompeakWeb.Router do
  use JompeakWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Jompeak.CurrentUser
  end

  scope "/", JompeakWeb do
    pipe_through [:browser, :with_session]

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    get "/setting", UserController, :setting
    post "/setting/:id/apply_changes", UserController, :update
    resources "/sessions", SessionController, only: [:new, :delete, :create]
    resources "/debt_record", JompeakRecordController, only: [:new, :create, :show]
    resources "/currency_converter", CurrencyConverterController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", JompeakWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: JompeakWeb.Telemetry
    end
  end
end
