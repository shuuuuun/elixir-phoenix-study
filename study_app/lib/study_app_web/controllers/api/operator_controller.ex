defmodule StudyAppWeb.Api.OperatorController do
  use StudyAppWeb, :controller

  alias StudyApp.Repo.Operator

  action_fallback StudyAppWeb.FallbackController

  def index(conn, _params) do
    operators = Operator.all()
    render(conn, "index.json", operators: operators)
  end

  def show(conn, %{"id" => id}) do
    operator = Operator.get!(id)
    render(conn, "show.json", operator: operator)
  end
end
