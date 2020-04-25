defmodule StudyAppWeb.Admin.OperatorController do
  use StudyAppWeb, :controller

  alias StudyApp.Admin
  alias StudyApp.Operator

  plug(:put_layout, {StudyAppWeb.LayoutView, "torch.html"})

  @fields ~w{birthday name_en name_ja picture assigned_at}

  def index(conn, params) do
    case Admin.paginate_operators(params) do
      {:ok, assigns} ->
        assigns = Map.put(assigns, :fields, @fields)
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Operators. #{inspect(error)}")
        |> redirect(to: Routes.admin_operator_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Admin.change_operator(%Operator{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"operator" => operator_params}) do
    case Admin.create_operator(operator_params) do
      {:ok, operator} ->
        conn
        |> put_flash(:info, "Operator created successfully.")
        |> redirect(to: Routes.admin_operator_path(conn, :show, operator))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    operator = Admin.get_operator!(id)
    render(conn, "show.html", operator: operator, fields: @fields)
  end

  def edit(conn, %{"id" => id}) do
    operator = Admin.get_operator!(id)
    changeset = Admin.change_operator(operator)
    render(conn, "edit.html", operator: operator, changeset: changeset)
  end

  def update(conn, %{"id" => id, "operator" => operator_params}) do
    operator = Admin.get_operator!(id)

    case Admin.update_operator(operator, operator_params) do
      {:ok, operator} ->
        conn
        |> put_flash(:info, "Operator updated successfully.")
        |> redirect(to: Routes.admin_operator_path(conn, :show, operator))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", operator: operator, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    operator = Admin.get_operator!(id)
    {:ok, _operator} = Admin.delete_operator(operator)

    conn
    |> put_flash(:info, "Operator deleted successfully.")
    |> redirect(to: Routes.admin_operator_path(conn, :index))
  end
end
