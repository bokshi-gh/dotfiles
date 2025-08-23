return {
  "L3MON4D3/LuaSnip",
  dependencies = { 
    "rafamadriz/friendly-snippets" -- prebuilt snippets
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- Load prebuilt VSCode-style snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Define your own snippets
    ls.snippets = {
      all = {
        s("hw", { t("Hello, World!") }), -- snippet for any file
      },
      lua = {
        s("fn", fmt("function {}({})\n  {}\nend", { i(1, "name"), i(2, "args"), i(3, "body") })),
      },
      python = {
        s("def", fmt("def {}({}):\n    {}", { i(1, "name"), i(2, "args"), i(3, "pass") })),
      },
    }
  end,
}
