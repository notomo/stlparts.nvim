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

local Padding = stlparts.component("padding")
local Separate = stlparts.component("separate")
local List = stlparts.component("list")

stlparts.set("default", Padding(Separate(List({ path }), List({ column, filetype }))))

vim.opt.statusline = [[%!v:lua.require("stlparts").build("default")]]
