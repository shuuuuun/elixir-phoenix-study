defmodule StudyAppWeb.Admin.ExecutionController do
  use StudyAppWeb, :controller

  alias StudyApp.Admin
  alias StudyApp.Execution

  plug(:put_layout, {StudyAppWeb.LayoutView, "torch.html"})

  @fields ~w{}

  def index(conn, params) do
    case Admin.paginate_executions(params) do
      {:ok, assigns} ->
        assigns = Map.put(assigns, :fields, @fields)
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Executions. #{inspect(error)}")
        |> redirect(to: Routes.admin_execution_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Admin.change_execution(%Execution{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"execution" => execution_params}) do
    case Admin.create_execution(execution_params) do
      {:ok, execution} ->
        conn
        |> put_flash(:info, "Execution created successfully.")
        |> redirect(to: Routes.admin_execution_path(conn, :show, execution))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    execution = Admin.get_execution!(id)
    render(conn, "show.html", execution: execution, fields: @fields)
  end

  def edit(conn, %{"id" => id}) do
    execution = Admin.get_execution!(id)
    changeset = Admin.change_execution(execution)
    render(conn, "edit.html", execution: execution, changeset: changeset)
  end

  def update(conn, %{"id" => id, "execution" => execution_params}) do
    execution = Admin.get_execution!(id)

    case Admin.update_execution(execution, execution_params) do
      {:ok, execution} ->
        conn
        |> put_flash(:info, "Execution updated successfully.")
        |> redirect(to: Routes.admin_execution_path(conn, :show, execution))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", execution: execution, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    execution = Admin.get_execution!(id)
    {:ok, _execution} = Admin.delete_execution(execution)

    conn
    |> put_flash(:info, "Execution deleted successfully.")
    |> redirect(to: Routes.admin_execution_path(conn, :index))
  end
end
