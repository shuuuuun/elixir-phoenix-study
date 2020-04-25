defmodule StudyAppWeb.Admin.OperatorControllerTest do
  use StudyAppWeb.ConnCase

  alias StudyApp.Admin

  @create_attrs %{birthday: ~D[2019-01-01], name_en: "hoge", name_ja: "ほげ", picture: "picture", assigned_at: ~D[2019-01-01]}
  @update_attrs %{name_en: "fuga"}
  @invalid_attrs %{birthday: nil}

  def fixture(:operator) do
    {:ok, operator} = Admin.create_operator(@create_attrs)
    operator
  end

  describe "index" do
    test "lists all operators", %{conn: conn} do
      conn = get conn, Routes.admin_operator_path(conn, :index)
      assert html_response(conn, 200) =~ "Operators"
    end
  end

  describe "new operator" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_operator_path(conn, :new)
      assert html_response(conn, 200) =~ "New Operator"
    end
  end

  describe "create operator" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_operator_path(conn, :create), operator: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_operator_path(conn, :show, id)

      conn = get conn, Routes.admin_operator_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Operator Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_operator_path(conn, :create), operator: @invalid_attrs
      assert html_response(conn, 200) =~ "New Operator"
    end
  end

  describe "edit operator" do
    setup [:create_operator]

    test "renders form for editing chosen operator", %{conn: conn, operator: operator} do
      conn = get conn, Routes.admin_operator_path(conn, :edit, operator)
      assert html_response(conn, 200) =~ "Edit Operator"
    end
  end

  describe "update operator" do
    setup [:create_operator]

    test "redirects when data is valid", %{conn: conn, operator: operator} do
      conn = put conn, Routes.admin_operator_path(conn, :update, operator), operator: @update_attrs
      assert redirected_to(conn) == Routes.admin_operator_path(conn, :show, operator)

      conn = get conn, Routes.admin_operator_path(conn, :show, operator)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, operator: operator} do
      conn = put conn, Routes.admin_operator_path(conn, :update, operator), operator: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Operator"
    end
  end

  describe "delete operator" do
    setup [:create_operator]

    test "deletes chosen operator", %{conn: conn, operator: operator} do
      conn = delete conn, Routes.admin_operator_path(conn, :delete, operator)
      assert redirected_to(conn) == Routes.admin_operator_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_operator_path(conn, :show, operator)
      end
    end
  end

  defp create_operator(_) do
    operator = fixture(:operator)
    {:ok, operator: operator}
  end
end
