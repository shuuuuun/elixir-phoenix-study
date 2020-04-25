defmodule StudyApp.Admin do
  @moduledoc """
  The Admin context.
  """

  import Ecto.Query, warn: false
  alias StudyApp.Repo

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias StudyApp.User

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of users using filtrex
  filters.

  ## Examples

      iex> list_users(%{})
      %{users: [%User{}], ...}
  """
  @spec paginate_users(map) :: {:ok, map} | {:error, any}
  def paginate_users(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:users), params["user"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_users(filter, params) do
      {:ok,
        %{
          users: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_users(filter, params) do
    User
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias StudyApp.Site

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of sites using filtrex
  filters.

  ## Examples

      iex> list_sites(%{})
      %{sites: [%Site{}], ...}
  """
  @spec paginate_sites(map) :: {:ok, map} | {:error, any}
  def paginate_sites(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:sites), params["site"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_sites(filter, params) do
      {:ok,
        %{
          sites: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_sites(filter, params) do
    Site
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of sites.

  ## Examples

      iex> list_sites()
      [%Site{}, ...]

  """
  def list_sites do
    Repo.all(Site)
  end

  @doc """
  Gets a single site.

  Raises `Ecto.NoResultsError` if the Site does not exist.

  ## Examples

      iex> get_site!(123)
      %Site{}

      iex> get_site!(456)
      ** (Ecto.NoResultsError)

  """
  def get_site!(id), do: Repo.get!(Site, id)

  @doc """
  Creates a site.

  ## Examples

      iex> create_site(%{field: value})
      {:ok, %Site{}}

      iex> create_site(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_site(attrs \\ %{}) do
    %Site{}
    |> Site.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a site.

  ## Examples

      iex> update_site(site, %{field: new_value})
      {:ok, %Site{}}

      iex> update_site(site, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_site(%Site{} = site, attrs) do
    site
    |> Site.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Site.

  ## Examples

      iex> delete_site(site)
      {:ok, %Site{}}

      iex> delete_site(site)
      {:error, %Ecto.Changeset{}}

  """
  def delete_site(%Site{} = site) do
    Repo.delete(site)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking site changes.

  ## Examples

      iex> change_site(site)
      %Ecto.Changeset{source: %Site{}}

  """
  def change_site(%Site{} = site) do
    Site.changeset(site, %{})
  end

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias StudyApp.Operator

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of operators using filtrex
  filters.

  ## Examples

      iex> list_operators(%{})
      %{operators: [%Operator{}], ...}
  """
  @spec paginate_operators(map) :: {:ok, map} | {:error, any}
  def paginate_operators(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:operators), params["operator"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_operators(filter, params) do
      {:ok,
        %{
          operators: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_operators(filter, params) do
    Operator
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of operators.

  ## Examples

      iex> list_operators()
      [%Operator{}, ...]

  """
  def list_operators do
    Repo.all(Operator)
  end

  @doc """
  Gets a single operator.

  Raises `Ecto.NoResultsError` if the Operator does not exist.

  ## Examples

      iex> get_operator!(123)
      %Operator{}

      iex> get_operator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operator!(id), do: Repo.get!(Operator, id)

  @doc """
  Creates a operator.

  ## Examples

      iex> create_operator(%{field: value})
      {:ok, %Operator{}}

      iex> create_operator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operator(attrs \\ %{}) do
    %Operator{}
    |> Operator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operator.

  ## Examples

      iex> update_operator(operator, %{field: new_value})
      {:ok, %Operator{}}

      iex> update_operator(operator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operator(%Operator{} = operator, attrs) do
    operator
    |> Operator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Operator.

  ## Examples

      iex> delete_operator(operator)
      {:ok, %Operator{}}

      iex> delete_operator(operator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operator(%Operator{} = operator) do
    Repo.delete(operator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operator changes.

  ## Examples

      iex> change_operator(operator)
      %Ecto.Changeset{source: %Operator{}}

  """
  def change_operator(%Operator{} = operator) do
    Operator.changeset(operator, %{})
  end

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias StudyApp.Execution

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of executions using filtrex
  filters.

  ## Examples

      iex> list_executions(%{})
      %{executions: [%Execution{}], ...}
  """
  @spec paginate_executions(map) :: {:ok, map} | {:error, any}
  def paginate_executions(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:executions), params["execution"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_executions(filter, params) do
      {:ok,
        %{
          executions: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_executions(filter, params) do
    Execution
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of executions.

  ## Examples

      iex> list_executions()
      [%Execution{}, ...]

  """
  def list_executions do
    Repo.all(Execution)
  end

  @doc """
  Gets a single execution.

  Raises `Ecto.NoResultsError` if the Execution does not exist.

  ## Examples

      iex> get_execution!(123)
      %Execution{}

      iex> get_execution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_execution!(id), do: Repo.get!(Execution, id)

  @doc """
  Creates a execution.

  ## Examples

      iex> create_execution(%{field: value})
      {:ok, %Execution{}}

      iex> create_execution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_execution(attrs \\ %{}) do
    %Execution{}
    |> Execution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a execution.

  ## Examples

      iex> update_execution(execution, %{field: new_value})
      {:ok, %Execution{}}

      iex> update_execution(execution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_execution(%Execution{} = execution, attrs) do
    execution
    |> Execution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Execution.

  ## Examples

      iex> delete_execution(execution)
      {:ok, %Execution{}}

      iex> delete_execution(execution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_execution(%Execution{} = execution) do
    Repo.delete(execution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking execution changes.

  ## Examples

      iex> change_execution(execution)
      %Ecto.Changeset{source: %Execution{}}

  """
  def change_execution(%Execution{} = execution) do
    Execution.changeset(execution, %{})
  end

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias StudyApp.Operation

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of operations using filtrex
  filters.

  ## Examples

      iex> list_operations(%{})
      %{operations: [%Operation{}], ...}
  """
  @spec paginate_operations(map) :: {:ok, map} | {:error, any}
  def paginate_operations(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:operations), params["operation"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_operations(filter, params) do
      {:ok,
        %{
          operations: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_operations(filter, params) do
    Operation
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of operations.

  ## Examples

      iex> list_operations()
      [%Operation{}, ...]

  """
  def list_operations do
    Repo.all(Operation)
  end

  @doc """
  Gets a single operation.

  Raises `Ecto.NoResultsError` if the Operation does not exist.

  ## Examples

      iex> get_operation!(123)
      %Operation{}

      iex> get_operation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operation!(id), do: Repo.get!(Operation, id)

  @doc """
  Creates a operation.

  ## Examples

      iex> create_operation(%{field: value})
      {:ok, %Operation{}}

      iex> create_operation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operation(attrs \\ %{}) do
    %Operation{}
    |> Operation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operation.

  ## Examples

      iex> update_operation(operation, %{field: new_value})
      {:ok, %Operation{}}

      iex> update_operation(operation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operation(%Operation{} = operation, attrs) do
    operation
    |> Operation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Operation.

  ## Examples

      iex> delete_operation(operation)
      {:ok, %Operation{}}

      iex> delete_operation(operation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operation(%Operation{} = operation) do
    Repo.delete(operation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operation changes.

  ## Examples

      iex> change_operation(operation)
      %Ecto.Changeset{source: %Operation{}}

  """
  def change_operation(%Operation{} = operation) do
    Operation.changeset(operation, %{})
  end

  defp filter_config(:users) do
    defconfig do
    end
  end

  defp filter_config(:sites) do
    defconfig do
    end
  end

  defp filter_config(:operators) do
    defconfig do
    end
  end

  defp filter_config(:executions) do
    defconfig do
    end
  end

  defp filter_config(:operations) do
    defconfig do
    end
  end
end
