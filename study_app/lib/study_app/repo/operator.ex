defmodule StudyApp.Repo.Operator do
  alias StudyApp.Repo
  alias StudyApp.Operator

  @doc """
  Returns the list of sites.

  ## Examples

      iex> Operator.all()
      [%Operator{}, ...]

  """
  def all, do: Repo.all(Operator)

  @doc """
  Gets a single site.

  Raises if the Operator does not exist.

  ## Examples

      iex> Operator.get!(123)
      %Operator{}

  """
  def get!(id), do: Repo.get!(Operator, id)
end
