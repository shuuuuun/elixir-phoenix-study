defmodule StudyApp.Repo.Site do
  import Ecto.Query, only: [from: 2]

  alias StudyApp.Repo
  alias StudyApp.Site

  def list_with_executions do
    query =
      from(
        s in Site,
        join: e in assoc(s, :executions),
        join: o in assoc(e, :operations),
        group_by: e.id,
        select: %{
          id: s.id,
          name: s.name,
          longitude: s.longitude,
          latitude: s.latitude,
          execution: %{
            id: e.id,
          }
        }
      )

    Repo.all(query)
  end

  @doc """
  Returns the list of sites.

  ## Examples

      iex> Site.all()
      [%Site{}, ...]

  """
  def all, do: Repo.all(Site)

  @doc """
  Gets a single site.

  Raises if the Site does not exist.

  ## Examples

      iex> Site.get!(123)
      %Site{}

  """
  def get!(id), do: Repo.get!(Site, id)
end
