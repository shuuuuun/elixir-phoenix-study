defmodule StudyAppWeb.PageController do
  use StudyAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
