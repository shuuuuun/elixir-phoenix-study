defmodule StudyApp.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :name, :string, null: false
      add :longitude, :float, null: false
      add :latitude, :float, null: false

      timestamps()
    end

  end
end
