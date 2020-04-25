defmodule StudyApp.Repo.Migrations.CreateOperators do
  use Ecto.Migration

  def change do
    create table(:operators) do
      add :name_en, :string, null: false
      add :name_ja, :string, null: false
      add :birthday, :date, null: false
      add :assigned_at, :date, null: false
      add :picture, :string, null: false

      timestamps()
    end

  end
end
