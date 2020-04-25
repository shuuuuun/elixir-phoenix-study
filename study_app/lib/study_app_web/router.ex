defmodule OurAuth do
  import Plug.Conn

  def init(default), do: default

  # def call(conn, default), do: assign(conn, :current_user, default)
  def call(conn, _default), do: assign(conn, :current_user, %{id: 1})
end

defmodule StudyAppWeb.Router do
  use StudyAppWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(OurAuth)
    plug(:put_user_token)
  end

  pipeline :api do
    plug(:accepts, ["json"])

    if Mix.env() == :dev do
      plug(CORSPlug, origin: "*")
    end
  end

  scope "/", StudyAppWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/mock", PageController, :index)
  end

  scope "/admin", StudyAppWeb, as: :admin do
    pipe_through(:browser)

    resources("/users", Admin.UserController)
    resources("/sites", Admin.SiteController)
    resources("/operators", Admin.OperatorController)
    resources("/executions", Admin.ExecutionController)
    resources("/operations", Admin.OperationController)
  end

  scope "/api", StudyAppWeb, as: :api do
    pipe_through(:api)

    resources("/sites", Api.SiteController, [:index])
    resources("/operators", Api.OperatorController, only: [:index, :show])
    get("/operations/:id/timeline", Api.OperationController, :timeline)

    get("/health/ping", Api.HealthController, :ping)
    get("/health/check", Api.HealthController, :check)
  end

  scope "/api/swagger" do
    forward("/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :study_app,
      swagger_file: "swagger.json"
    )
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "StudyApp App"
      }
    }
  end
end
