defmodule Theme01Web.Router do
  use Theme01Web, :router

  pipeline :api do
    plug CORSPlug, origin: ["http://localhost:8080", "http://localhost:8081"]
    plug :accepts, ["json"]
  end

  scope "/api", Theme01Web do
    pipe_through :api
    resources "/users", UserController
    resources "/workingtimes", WorkingTimeController, only: [:update, :delete]
    get "/workingtimes/:userID", WorkingTimeController, :index
    get "/workingtimes/:userID/:id", WorkingTimeController, :index
    post "/workingtimes/:userID", WorkingTimeController, :create
    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :create 
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: Theme01Web.Telemetry
    end
  end
end
