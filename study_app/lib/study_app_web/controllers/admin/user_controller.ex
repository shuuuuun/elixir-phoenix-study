defmodule StudyAppWeb.Admin.UserController do
  require Logger

  use StudyAppWeb, :controller

  alias StudyApp.Admin
  alias StudyApp.User

  plug(:put_layout, {StudyAppWeb.LayoutView, "torch.html"})

  @fields ~w{type email password name}

  def index(conn, params) do
    case Admin.paginate_users(params) do
      {:ok, assigns} ->
        Logger.debug(inspect(assigns))
        assigns = Map.put(assigns, :fields, @fields)
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Users. #{inspect(error)}")
        |> redirect(to: Routes.admin_user_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Admin.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Admin.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.admin_user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    render(conn, "show.html", user: user, fields: @fields)
  end

  def edit(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    changeset = Admin.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admin.get_user!(id)

    case Admin.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.admin_user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    {:ok, _user} = Admin.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end
end
