defmodule StudyApp.AdminTest do
  require IEx

  use StudyApp.DataCase

  alias StudyApp.{Admin, User, Site, Operator, Execution, Operation}

  describe "users" do
    @valid_attrs %{type: 0, email: "user@example.com", password: "password", name: "user"}
    @update_attrs %{name: "updated-user"}
    @invalid_attrs %{name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_user()

      user
    end

    test "paginate_users/1 returns paginated list of users" do
      for _ <- 1..20 do
        user_fixture()
      end

      {:ok, %{users: users} = page} = Admin.paginate_users(%{})

      assert length(users) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Admin.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Admin.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Admin.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Admin.update_user(user, @update_attrs)
      assert %User{} = user
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_user(user, @invalid_attrs)
      assert user == Admin.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admin.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admin.change_user(user)
    end
  end

  describe "sites" do
    @valid_attrs %{latitude: 1.0, longitude: 1.0, name: "site"}
    @update_attrs %{name: "updated-site"}
    @invalid_attrs %{name: nil}

    def site_fixture(attrs \\ %{}) do
      {:ok, site} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_site()

      site
    end

    test "paginate_sites/1 returns paginated list of sites" do
      for _ <- 1..20 do
        site_fixture()
      end

      {:ok, %{sites: sites} = page} = Admin.paginate_sites(%{})

      assert length(sites) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Admin.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Admin.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      assert {:ok, %Site{} = site} = Admin.create_site(@valid_attrs)
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      assert {:ok, site} = Admin.update_site(site, @update_attrs)
      assert %Site{} = site
    end

    test "update_site/2 with invalid data returns error changeset" do
      site = site_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_site(site, @invalid_attrs)
      assert site == Admin.get_site!(site.id)
    end

    test "delete_site/1 deletes the site" do
      site = site_fixture()
      assert {:ok, %Site{}} = Admin.delete_site(site)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_site!(site.id) end
    end

    test "change_site/1 returns a site changeset" do
      site = site_fixture()
      assert %Ecto.Changeset{} = Admin.change_site(site)
    end
  end

  describe "operators" do
    @valid_attrs %{
      birthday: ~D[2019-01-01],
      name_en: "hoge",
      name_ja: "ほげ",
      picture: "picture",
      assigned_at: ~D[2019-01-01]
    }
    @update_attrs %{name_en: "fuga"}
    @invalid_attrs %{birthday: nil}

    def operator_fixture(attrs \\ %{}) do
      {:ok, operator} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_operator()

      operator
    end

    test "paginate_operators/1 returns paginated list of operators" do
      for _ <- 1..20 do
        operator_fixture()
      end

      {:ok, %{operators: operators} = page} = Admin.paginate_operators(%{})

      assert length(operators) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_operators/0 returns all operators" do
      operator = operator_fixture()
      assert Admin.list_operators() == [operator]
    end

    test "get_operator!/1 returns the operator with given id" do
      operator = operator_fixture()
      assert Admin.get_operator!(operator.id) == operator
    end

    test "create_operator/1 with valid data creates a operator" do
      assert {:ok, %Operator{} = operator} = Admin.create_operator(@valid_attrs)
    end

    test "create_operator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_operator(@invalid_attrs)
    end

    test "update_operator/2 with valid data updates the operator" do
      operator = operator_fixture()
      assert {:ok, operator} = Admin.update_operator(operator, @update_attrs)
      assert %Operator{} = operator
    end

    test "update_operator/2 with invalid data returns error changeset" do
      operator = operator_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_operator(operator, @invalid_attrs)
      assert operator == Admin.get_operator!(operator.id)
    end

    test "delete_operator/1 deletes the operator" do
      operator = operator_fixture()
      assert {:ok, %Operator{}} = Admin.delete_operator(operator)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_operator!(operator.id) end
    end

    test "change_operator/1 returns a operator changeset" do
      operator = operator_fixture()
      assert %Ecto.Changeset{} = Admin.change_operator(operator)
    end
  end

  describe "executions" do
    @valid_attrs %{site_id: 1}
    @update_attrs %{site_id: 2}
    @invalid_attrs %{site_id: nil}

    setup do
      Repo.insert!(%Site{id: 1, latitude: 1.0, longitude: 1.0, name: "site1"})
      Repo.insert!(%Site{id: 2, latitude: 1.0, longitude: 1.0, name: "site2"})
      :ok
    end

    def execution_fixture(attrs \\ %{}) do
      {:ok, execution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_execution()

      execution
    end

    test "paginate_executions/1 returns paginated list of executions" do
      for _ <- 1..20 do
        execution_fixture()
      end

      {:ok, %{executions: executions} = page} = Admin.paginate_executions(%{})

      assert length(executions) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_executions/0 returns all executions" do
      execution = execution_fixture()
      assert Admin.list_executions() == [execution]
    end

    test "get_execution!/1 returns the execution with given id" do
      execution = execution_fixture()
      assert Admin.get_execution!(execution.id) == execution
    end

    test "create_execution/1 with valid data creates a execution" do
      assert {:ok, %Execution{} = execution} = Admin.create_execution(@valid_attrs)
    end

    test "create_execution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_execution(@invalid_attrs)
    end

    test "update_execution/2 with valid data updates the execution" do
      execution = execution_fixture()
      assert {:ok, execution} = Admin.update_execution(execution, @update_attrs)
      assert %Execution{} = execution
    end

    test "update_execution/2 with invalid data returns error changeset" do
      execution = execution_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_execution(execution, @invalid_attrs)
      assert execution == Admin.get_execution!(execution.id)
    end

    test "delete_execution/1 deletes the execution" do
      execution = execution_fixture()
      assert {:ok, %Execution{}} = Admin.delete_execution(execution)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_execution!(execution.id) end
    end

    test "change_execution/1 returns a execution changeset" do
      execution = execution_fixture()
      assert %Ecto.Changeset{} = Admin.change_execution(execution)
    end
  end

  describe "operations" do
    @valid_attrs %{
      execution_id: 1,
      operator_id: 1,
      start_time: ~U[2010-10-10 10:10:10Z],
      end_time: ~U[2010-10-10 10:10:10Z],
      file:
        "priv/repo/data/data.csv"
    }
    @update_attrs %{start_time: ~U[2011-11-11 11:11:11Z], end_time: ~U[2011-11-11 11:11:11Z]}
    @invalid_attrs %{execution_id: nil, operator_id: nil}

    setup do
      Repo.insert!(%Site{id: 1, latitude: 1.0, longitude: 1.0, name: "site1"})
      Repo.insert!(%Execution{id: 1, site_id: 1})

      Repo.insert!(%Operator{
        id: 1,
        birthday: ~D[2019-01-01],
        name_en: "hoge",
        name_ja: "ほげ",
        picture: "picture",
        assigned_at: ~D[2019-01-01]
      })

      :ok
    end

    def operation_fixture(attrs \\ %{}) do
      {:ok, operation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_operation()

      operation
    end

    test "paginate_operations/1 returns paginated list of operations" do
      for _ <- 1..20 do
        operation_fixture()
      end

      {:ok, %{operations: operations} = page} = Admin.paginate_operations(%{})

      assert length(operations) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_operations/0 returns all operations" do
      operation = operation_fixture()
      assert Admin.list_operations() == [operation]
    end

    test "get_operation!/1 returns the operation with given id" do
      operation = operation_fixture()
      assert Admin.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation" do
      assert {:ok, %Operation{} = operation} = Admin.create_operation(@valid_attrs)
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_operation(@invalid_attrs)
    end

    test "update_operation/2 with valid data updates the operation" do
      operation = operation_fixture()
      assert {:ok, operation} = Admin.update_operation(operation, @update_attrs)
      assert %Operation{} = operation
    end

    test "update_operation/2 with invalid data returns error changeset" do
      operation = operation_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_operation(operation, @invalid_attrs)
      assert operation == Admin.get_operation!(operation.id)
    end

    test "delete_operation/1 deletes the operation" do
      operation = operation_fixture()
      assert {:ok, %Operation{}} = Admin.delete_operation(operation)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_operation!(operation.id) end
    end

    test "change_operation/1 returns a operation changeset" do
      operation = operation_fixture()
      assert %Ecto.Changeset{} = Admin.change_operation(operation)
    end
  end
end
