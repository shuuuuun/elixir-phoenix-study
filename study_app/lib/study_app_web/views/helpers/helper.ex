defmodule StudyAppWeb.Helper do
  def unix_timestamp(datetime) do
    DateTime.from_naive!(datetime, "Etc/UTC")
    |> DateTime.to_unix(:millisecond)
  end
end
