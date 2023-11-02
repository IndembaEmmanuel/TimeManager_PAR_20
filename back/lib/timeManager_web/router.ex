defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api


    # User routes
    resources "/users", UserController
    post "/user/change/role", ActionController, :userRoleModification
    post "/userAssignment", ActionController, :userAssignment

    #Auth routes
    post "/auth", AuthController, :auth
    post "/logout", AuthController, :logout
    post "/verfication_token", AuthController, :verfication


    #teams routes
    resources "/teams", TeamController



    # Working times routes
    get "/workingtimes/:user_id", WorkingTimeController, :index
    get "/workingtimes/:user_id/:id", WorkingTimeController, :index
    post "/workingtimes/:user_id", WorkingTimeController, :create
    put "/workingtimes/:working_time_id", WorkingTimeController, :update
    delete "/workingtimes/:working_time_id", WorkingTimeController, :delete

    # Clocks routes
    get "/clocks/:user_id", ClockingController, :index
    post "/clocks/:user_id", ClockingController, :create

  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:yyy, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimeManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
