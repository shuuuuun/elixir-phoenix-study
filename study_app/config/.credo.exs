%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "config/", "priv/", "test/"],
        excluded: []
      },
      checks: [
        {Credo.Check.Readability.ModuleDoc, false},
        {Credo.Check.Design.TagTODO, exit_status: 0}
      ]
    }
  ]
}
