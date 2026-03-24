return {
  root_markers = { "deno.json", "deno.jsonc" },
  single_file_support = false,
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true
        }
      }
    }
  },
  settings = {
    deno = {
      enable = true,
      lint = true,
      unstable = true,
      codeLens = {
        implementations = true,
        references = true,
        referencesAllFunctions = true,
        test = true
      },
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true
          }
        }
      }
    }
  }
}