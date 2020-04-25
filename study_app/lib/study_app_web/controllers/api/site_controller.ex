defmodule StudyAppWeb.Api.SiteController do
  use StudyAppWeb, :controller
  use PhoenixSwagger

  alias StudyApp.Repo.Site

  action_fallback(StudyAppWeb.FallbackController)

  def swagger_definitions do
    %{
      Site:
        swagger_schema do
          title("Site")
          description("Site")

          properties do
            id(:integer, "Unique identifier", required: true)
            name(:string, "Name of the site.", required: true)
            longitude(:integer, "Longitude of the site.", required: true)
            latitude(:integer, "Latitude of the site.", required: true)
          end

          example(%{
            id: 1,
            name: "東京タワー",
            longitude: 139.745390,
            latitude: 35.658790,
          })
        end
    }
  end

  swagger_path :index do
    get("/api/sites")
    summary("Sites API")
    description("Collection of sites which includes execution list.")
    produces("application/json")

    response(200, "Success", Schema.array(:Site))
  end

  def index(conn, _params) do
    # sites =
    #   Site.list_with_executions()
    #   |> Enum.chunk_by(&Map.get(&1, :id))
    #   |> Enum.map(&format_by_site/1)
    sites = Site.all()

    render(conn, "index.json", sites: sites)
  end

  # defp format_by_site(site) do
  #   site
  #   |> Enum.concat()
  #   |> Enum.group_by(fn {key, _} -> key end, fn {_, val} -> val end)
  #   |> Map.new(fn
  #     {key, [val | _]} -> {key, val}
  #   end)
  # end

  # defp to_unix(datetime) do
  #   DateTime.to_unix(datetime, :millisecond)
  # end
end
