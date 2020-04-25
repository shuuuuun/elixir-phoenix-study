defmodule StudyAppWeb.Admin.UserControllerTest do
  use StudyAppWeb.ConnCase

  alias StudyApp.Admin

  @create_attrs %{type: 0, email: "user@example.com", password: "password", name: "user"}
  @update_attrs %{name: "updated-user"}
  @invalid_attrs %{name: nil}

  def fixture(:user) do
    {:ok, user} = Admin.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, Routes.admin_user_path(conn, :index)
      assert html_response(conn, 200) =~ "Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_user_path(conn, :new)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_user_path(conn, :create), user: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_user_path(conn, :show, id)

      conn = get conn, Routes.admin_user_path(conn, :show, id)
      assert html_response(conn, 200) =~ "User Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_user_path(conn, :create), user: @invalid_attrs
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get conn, Routes.admin_user_path(conn, :edit, user)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = put conn, Routes.admin_user_path(conn, :update, user), user: @update_attrs
      assert redirected_to(conn) == Routes.admin_user_path(conn, :show, user)

      conn = get conn, Routes.admin_user_path(conn, :show, user)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put conn, Routes.admin_user_path(conn, :update, user), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, Routes.admin_user_path(conn, :delete, user)
      assert redirected_to(conn) == Routes.admin_user_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_user_path(conn, :show, user)
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
