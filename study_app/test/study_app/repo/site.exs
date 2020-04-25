defmodule StudyApp.Repo.SiteTest do
  require IEx

  use StudyApp.DataCase

  alias StudyApp.{Repo, Site}
  alias StudyApp.Repo.Site, as: SiteRepo

  describe "sites" do
    @valid_attrs %{latitude: 1.0, longitude: 1.0, name: "site"}

    def site_fixture(attrs \\ %{}) do
      attrs =
        attrs
        |> Enum.into(@valid_attrs)

      struct(Site, attrs)
      |> Repo.insert!
    end

    test "list_with_executions/0 returns all sites with executions" do
      # TODO: list_with_executions test
      # site = site_fixture()
      # assert Repo.aggregate(Site, :count, :id) == 1
      # assert Repo.aggregate(Execution, :count, :id) == 1
      # assert SiteRepo.list_with_executions() == [site]
    end

    test "all/0 returns all sites" do
      site = site_fixture()
      assert SiteRepo.all == [site]
    end

    test "get!/1 returns the site with given id" do
      site = site_fixture()
      assert SiteRepo.get!(site.id) == site
    end
  end
end
