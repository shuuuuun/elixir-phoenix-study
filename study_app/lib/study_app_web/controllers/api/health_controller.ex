defmodule StudyAppWeb.Api.HealthController do
  use StudyAppWeb, :controller

  alias StudyApp.Repo

  action_fallback StudyAppWeb.FallbackController

  def ping(conn, _params) do
    text(conn, "pong")
  end

  def check(conn, _params) do
    {:ok, _res} = Ecto.Adapters.SQL.query(Repo, "SELECT 1") # DB connection check
    text(conn, "ok")
  end
end
