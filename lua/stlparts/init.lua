local M = {}

--- Returns a 'statusline' string
--- @param window_id number|nil: window id
--- @return string: statusline expression string
function M.build(window_id)
  return require("stlparts.command").build(window_id)
end

--- Returns a component function
--- @param name string: component name
--- @return function: component function
function M.component(name)
  return require("stlparts.command").component(name)
end

--- Set a root component
--- @param component table:
--- @return function: component function
function M.set_root(component)
  return require("stlparts.command").set_root(component)
end

return M
