defmodule StudyApp.Repo.Seeds.CSVSeeder do
  require Logger
  alias StudyApp.Repo

  @path "priv/repo/seeds/csv"

  def seed(filename, model) do
    Logger.debug "Seeding #{model}..."
    Repo.delete_all model
    load(filename)
    |> CSV.decode(headers: true) # CSVの1行目をheader値にする
    |> Enum.each(&add(&1, model))
  end

  defp load(file) do
    Application.app_dir(:study_app, Path.join([@path, file]))
    |> File.stream!
  end

  defp add(row, model) do
    model.changeset(struct(model), row)
    |> Repo.insert!
  end
end
