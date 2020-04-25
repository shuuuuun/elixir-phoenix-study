defmodule StudyApp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :type, :integer
    field :email, :string
    field :password, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:type, :email, :password, :name])
    |> validate_required([:type, :email, :password, :name])
  end
end
