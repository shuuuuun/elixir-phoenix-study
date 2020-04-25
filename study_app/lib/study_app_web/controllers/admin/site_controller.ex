defmodule StudyAppWeb.Admin.SiteController do
  use StudyAppWeb, :controller

  alias StudyApp.Admin
  alias StudyApp.Site

  plug(:put_layout, {StudyAppWeb.LayoutView, "torch.html"})

  @fields ~w{latitude longitude name}

  def index(conn, params) do
    case Admin.paginate_sites(params) do
      {:ok, assigns} ->
        assigns = Map.put(assigns, :fields, @fields)
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Sites. #{inspect(error)}")
        |> redirect(to: Routes.admin_site_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Admin.change_site(%Site{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"site" => site_params}) do
    case Admin.create_site(site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully.")
        |> redirect(to: Routes.admin_site_path(conn, :show, site))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site = Admin.get_site!(id)
    render(conn, "show.html", site: site, fields: @fields)
  end

  def edit(conn, %{"id" => id}) do
    site = Admin.get_site!(id)
    changeset = Admin.change_site(site)
    render(conn, "edit.html", site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => site_params}) do
    site = Admin.get_site!(id)

    case Admin.update_site(site, site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site updated successfully.")
        |> redirect(to: Routes.admin_site_path(conn, :show, site))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", site: site, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site = Admin.get_site!(id)
    {:ok, _site} = Admin.delete_site(site)

    conn
    |> put_flash(:info, "Site deleted successfully.")
    |> redirect(to: Routes.admin_site_path(conn, :index))
  end
end
