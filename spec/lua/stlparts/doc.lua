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
        if node.declaration == nil or node.declaration.type ~= "function" then
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
        if node.declaration.type ~= "anonymous_function" then
          return nil
        end
        return "COMPONENTS"
      end,
    },
    {
      name = "STRUCTURE",
      group = function(node)
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
  local f = io.open(example_path, "r")
  local exmaple = f:read("*a")
  f:close()

  local content = ([[
# stlparts.nvim

statusline components.

## Example

```lua
%s```]]):format(exmaple)

  local readme = io.open("README.md", "w")
  readme:write(content)
  readme:close()
end
gen_readme()
