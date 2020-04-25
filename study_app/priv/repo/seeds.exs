# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StudyApp.Repo.insert!(%StudyApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

"priv/repo/seeds/"
|> Path.join("**/*.exs")
|> Path.wildcard()
|> Enum.map(&Code.require_file/1)

require Logger
# alias StudyApp.{Repo, Frame}
alias StudyApp.Repo.Seeds.CSVSeeder

Logger.debug("Seed start!")

CSVSeeder.seed("operator.csv", StudyApp.Operator)
CSVSeeder.seed("site.csv", StudyApp.Site)
CSVSeeder.seed("execution.csv", StudyApp.Execution)
CSVSeeder.seed("user.csv", StudyApp.User)
CSVSeeder.seed("operation.csv", StudyApp.Operation)

# Logger.debug("Seeding Frame...")
#
# "priv/repo/data/frame.csv"
# |> File.stream!()
# |> CSV.decode(headers: true)
# |> Stream.map(fn datum ->
#   attrs =
#     datum
#     |> Enum.map(fn {k, v} -> {String.downcase(String.replace(k, " ", "_")), v} end)
#     |> Map.new()
#
#   Frame.changeset(struct(Frame), attrs)
# end)
# |> Stream.filter(fn changeset -> changeset.valid? end)
# |> Stream.map(fn changeset ->
#   now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
#   Map.merge(changeset.changes, %{inserted_at: now, updated_at: now})
# end)
# # 1000件ずつ
# |> Stream.chunk_every(1000)
# |> Stream.each(fn entries ->
#   IO.write(".")
#   Repo.insert_all(Frame, entries)
# end)
# |> Stream.run()

Logger.debug("Seed end!")
