defmodule StudyApp.Execution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "executions" do
    belongs_to :site, StudyApp.Site
    has_many :operations, StudyApp.Operation

    timestamps()
  end

  @doc false
  def changeset(execution, attrs) do
    execution
    |> cast(attrs, [:site_id])
    |> validate_required([:site_id])
  end
end
