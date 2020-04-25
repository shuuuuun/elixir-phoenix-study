defmodule StudyAppWeb.Admin.OperationController do
  use StudyAppWeb, :controller

  alias StudyApp.Admin
  alias StudyApp.Operation

  plug(:put_layout, {StudyAppWeb.LayoutView, "torch.html"})

  @fields ~w{}

  def index(conn, params) do
    case Admin.paginate_operations(params) do
      {:ok, assigns} ->
        assigns = Map.put(assigns, :fields, @fields)
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Operations. #{inspect(error)}")
        |> redirect(to: Routes.admin_operation_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Admin.change_operation(%Operation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"operation" => operation_params}) do
    case Admin.create_operation(operation_params) do
      {:ok, operation} ->
        conn
        |> put_flash(:info, "Operation created successfully.")
        |> redirect(to: Routes.admin_operation_path(conn, :show, operation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    operation = Admin.get_operation!(id)
    render(conn, "show.html", operation: operation, fields: @fields)
  end

  def edit(conn, %{"id" => id}) do
    operation = Admin.get_operation!(id)
    changeset = Admin.change_operation(operation)
    render(conn, "edit.html", operation: operation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "operation" => operation_params}) do
    operation = Admin.get_operation!(id)

    case Admin.update_operation(operation, operation_params) do
      {:ok, operation} ->
        conn
        |> put_flash(:info, "Operation updated successfully.")
        |> redirect(to: Routes.admin_operation_path(conn, :show, operation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", operation: operation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = Admin.get_operation!(id)
    {:ok, _operation} = Admin.delete_operation(operation)

    conn
    |> put_flash(:info, "Operation deleted successfully.")
    |> redirect(to: Routes.admin_operation_path(conn, :index))
  end
end
