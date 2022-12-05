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
        if not node.declaration then
          return nil
        end
        if node.declaration.module:match("%.component%.") then
          return nil
        end
        return node.declaration.module
      end,
    },
    {
      name = function()
        return "COMPONENTS"
      end,
      group = function(node)
        if not node.declaration then
          return nil
        end
        if not node.declaration.module:match("%.component%.") then
          return nil
        end
        return "components"
      end,
    },
    {
      name = "TYPES",
      body = function(ctx)
        return util.sections(ctx, {
          {
            name = "Component",
            tag_name = "types-component",
            text = [[
Type is one of the following:
- (function): returns string
- (table): {new = `component constructor`, build = `function returns string`}
]],
          },
        })
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
