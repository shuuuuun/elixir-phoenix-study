defmodule StudyApp.Repo do
  use Ecto.Repo,
    otp_app: :study_app,
    adapter: Ecto.Adapters.MyXQL
end
