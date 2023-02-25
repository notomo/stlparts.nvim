# stlparts.nvim

statusline components.

## Example

```lua
local stlparts = require("stlparts")

local path = function()
  return vim.fn.expand("%:p:~")
end

local column = function()
  return vim.fn.col(".")
end

local filetype = function()
  return vim.bo.filetype
end

local Separate = stlparts.component("separate")

stlparts.set("default", {
  " ",
  Separate({
    path,
    { column, " ", filetype },
  }),
  " ",
})

vim.opt.statusline = [[%!v:lua.require("stlparts").build("default")]]
```