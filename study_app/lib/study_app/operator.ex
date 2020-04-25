defmodule StudyApp.Operator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "operators" do
    field :birthday, :date
    field :name_en, :string
    field :name_ja, :string
    field :picture, :string
    field :assigned_at, :date
    has_many :operations, StudyApp.Operation

    timestamps()
  end

  @doc false
  def changeset(operator, attrs) do
    operator
    |> cast(attrs, [:name_en, :name_ja, :birthday, :assigned_at, :picture])
    |> validate_required([:name_en, :name_ja, :birthday, :assigned_at, :picture])
  end
end
