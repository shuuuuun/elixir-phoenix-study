defmodule StudyApp.Operation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "operations" do
    belongs_to(:execution, StudyApp.Execution)
    belongs_to(:operator, StudyApp.Operator)

    timestamps()
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:execution_id, :operator_id])
    |> validate_required([:execution_id, :operator_id])
  end
end
