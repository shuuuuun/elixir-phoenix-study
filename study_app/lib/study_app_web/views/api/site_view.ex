defmodule StudyAppWeb.Api.SiteView do
  use StudyAppWeb, :view
  alias StudyAppWeb.Api.SiteView

  def render("index.json", %{sites: sites}) do
    render_many(sites, SiteView, "site.json")
  end

  def render("show.json", %{site: site}) do
    render_one(site, SiteView, "site.json")
  end

  def render("site.json", %{site: site}) do
    %{
      id: site.id,
      name: site.name,
      longitude: site.longitude,
      latitude: site.latitude,
    }
  end
end
