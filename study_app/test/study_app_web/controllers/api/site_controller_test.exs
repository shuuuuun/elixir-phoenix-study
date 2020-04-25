defmodule StudyAppWeb.Api.SiteControllerTest do
  use StudyAppWeb.ConnCase

  # alias StudyApp.Api
  # alias StudyApp.Api.Site

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sites", %{conn: conn} do
      conn = get(conn, Routes.api_site_path(conn, :index))
      assert json_response(conn, 200) == []
    end
  end
end
