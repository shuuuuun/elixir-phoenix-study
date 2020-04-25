defmodule StudyApp.Site do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sites" do
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    has_many :executions, StudyApp.Execution

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [:name, :longitude, :latitude])
    |> validate_required([:name, :longitude, :latitude])
  end
end
