defmodule StudyApp.Repo.Migrations.AddColumnToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :type, :integer, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      modify :name, :string, null: false
    end

  end
end
