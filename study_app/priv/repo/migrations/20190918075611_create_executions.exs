defmodule StudyApp.Repo.Migrations.CreateExecutions do
  use Ecto.Migration

  def change do
    create table(:executions) do
      add :site_id, references(:sites), null: false

      timestamps()
    end

  end
end
