local M = {}

--- Returns a 'statusline' string.
--- @param name string: registered name by |stlparts.set()|
--- @param opts table|nil: {window_id = nil, hl_group = "StatusLine"}
--- @return string: statusline expression string
function M.build(name, opts)
  return require("stlparts.command").build(name, opts)
end

--- Returns a component function.
--- @param name string: component name
--- @return function: component constructor function
function M.component(name)
  local f, err = require("stlparts.command").component(name)
  if err then
    error("[stlparts] " .. err, 0)
  end
  return f
end

--- Set a component.
--- @param name string: use to refer from |stlparts.build()|
--- @param component table|function: |stlparts.nvim-types-component|
function M.set(name, component)
  return require("stlparts.command").set(name, component)
end

return M
