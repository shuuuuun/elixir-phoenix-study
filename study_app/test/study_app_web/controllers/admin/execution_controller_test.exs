defmodule StudyAppWeb.Admin.ExecutionControllerTest do
  use StudyAppWeb.ConnCase

  alias StudyApp.{Admin, Repo, Site}

  @create_attrs %{site_id: 1}
  @update_attrs %{site_id: 2}
  @invalid_attrs %{site_id: nil}

  setup do
    Repo.insert! %Site{id: 1, latitude: 1.0, longitude: 1.0, name: "site1"}
    Repo.insert! %Site{id: 2, latitude: 1.0, longitude: 1.0, name: "site2"}
    :ok
  end

  def fixture(:execution) do
    {:ok, execution} = Admin.create_execution(@create_attrs)
    execution
  end

  describe "index" do
    test "lists all executions", %{conn: conn} do
      conn = get conn, Routes.admin_execution_path(conn, :index)
      assert html_response(conn, 200) =~ "Executions"
    end
  end

  describe "new execution" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_execution_path(conn, :new)
      assert html_response(conn, 200) =~ "New Execution"
    end
  end

  describe "create execution" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_execution_path(conn, :create), execution: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_execution_path(conn, :show, id)

      conn = get conn, Routes.admin_execution_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Execution Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_execution_path(conn, :create), execution: @invalid_attrs
      assert html_response(conn, 200) =~ "New Execution"
    end
  end

  describe "edit execution" do
    setup [:create_execution]

    test "renders form for editing chosen execution", %{conn: conn, execution: execution} do
      conn = get conn, Routes.admin_execution_path(conn, :edit, execution)
      assert html_response(conn, 200) =~ "Edit Execution"
    end
  end

  describe "update execution" do
    setup [:create_execution]

    test "redirects when data is valid", %{conn: conn, execution: execution} do
      conn = put conn, Routes.admin_execution_path(conn, :update, execution), execution: @update_attrs
      assert redirected_to(conn) == Routes.admin_execution_path(conn, :show, execution)

      conn = get conn, Routes.admin_execution_path(conn, :show, execution)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, execution: execution} do
      conn = put conn, Routes.admin_execution_path(conn, :update, execution), execution: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Execution"
    end
  end

  describe "delete execution" do
    setup [:create_execution]

    test "deletes chosen execution", %{conn: conn, execution: execution} do
      conn = delete conn, Routes.admin_execution_path(conn, :delete, execution)
      assert redirected_to(conn) == Routes.admin_execution_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_execution_path(conn, :show, execution)
      end
    end
  end

  defp create_execution(_) do
    execution = fixture(:execution)
    {:ok, execution: execution}
  end
end
