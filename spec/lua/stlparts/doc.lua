local util = require("genvdoc.util")
local plugin_name = vim.env.PLUGIN_NAME

local example_path = ("./spec/lua/%s/example.lua"):format(plugin_name)

vim.o.runtimepath = vim.fn.getcwd() .. "," .. vim.o.runtimepath
dofile(example_path)

require("genvdoc").generate(plugin_name .. ".nvim", {
  source = {
    patterns = {
      ("lua/%s/init.lua"):format(plugin_name),
      ("lua/%s/component/*.lua"):format(plugin_name),
    },
  },
  chapters = {
    {
      name = function(group)
        return "Lua module: " .. group
      end,
      group = function(node)
        if node.declaration == nil or not vim.tbl_contains({ "function", "property" }, node.declaration.type) then
          return nil
        end
        return node.declaration.module
      end,
    },
    {
      name = "COMPONENTS",
      group = function(node)
        if not node.declaration then
          return nil
        end
        if not node.declaration.module:match("%.component%.") then
          return nil
        end
        if
          node.declaration == nil or not vim.tbl_contains({ "anonymous_function", "class" }, node.declaration.type)
        then
          return nil
        end
        return "COMPONENTS"
      end,
    },
    {
      name = "STRUCTURE",
      group = function(node)
        if node.declaration.module:match("%.component%.") then
          return nil
        end
        if node.declaration == nil or not vim.tbl_contains({ "class" }, node.declaration.type) then
          return nil
        end
        return "STRUCTURE"
      end,
    },
    {
      name = "EXAMPLES",
      body = function()
        return util.help_code_block_from_file(example_path, { language = "lua" })
      end,
    },
  },
})

local gen_readme = function()
  local exmaple = util.read_all(example_path)

  local content = ([[
# stlparts.nvim

statusline components.

## Example

```lua
%s```]]):format(exmaple)

  util.write("README.md", content)
end
gen_readme()
