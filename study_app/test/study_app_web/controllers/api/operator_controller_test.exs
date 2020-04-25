defmodule StudyAppWeb.Api.OperatorControllerTest do
  use StudyAppWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all operators", %{conn: conn} do
      conn = get(conn, Routes.api_operator_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
