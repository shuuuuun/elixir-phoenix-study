defmodule StudyAppWeb.Api.OperatorView do
  use StudyAppWeb, :view
  alias StudyAppWeb.Api.OperatorView

  def render("index.json", %{operators: operators}) do
    %{data: render_many(operators, OperatorView, "operator.json")}
  end

  def render("show.json", %{operator: operator}) do
    %{data: render_one(operator, OperatorView, "operator.json")}
  end

  def render("operator.json", %{operator: operator}) do
    # %{id: operator.id}
    [:id, :name_en, :name_ja, :birthday, :assigned_at, :picture]
    |> Enum.map(fn field -> {field, Map.get(operator, field)} end)
    |> Map.new
  end
end
