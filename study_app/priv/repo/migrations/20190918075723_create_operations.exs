defmodule StudyApp.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add(:execution_id, references(:executions), null: false)
      add(:operator_id, references(:operators), null: false)

      timestamps()
    end
  end
end
