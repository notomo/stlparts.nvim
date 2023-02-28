local M = {}

--- Returns a 'statusline' string.
--- @param name string: registered name by |stlparts.set()|
--- @param opts table|nil: {window_id = nil, hl_group = "StatusLine"}
--- @return string: statusline expression string
function M.build(name, opts)
  return require("stlparts.command").build(name, opts)
end

-- TODO: impl typed componets

--- Returns a component function.
--- @param name string: component name
--- @return fun(...:any):StlpartsFunctionComponent
function M.component(name)
  local f, err = require("stlparts.command").component(name)
  if err then
    error("[stlparts] " .. err, 0)
  end
  return f
end

--- Set a component.
--- @param name string: use to refer from |stlparts.build()|
--- @param component StlpartsComponent |StlpartsComponent|
function M.set(name, component)
  return require("stlparts.command").set(name, component)
end

--- @alias StlpartsComponent StlpartsFunctionComponent|string|StlpartsComponent[]

--- @alias StlpartsFunctionComponent fun(ctx:StlpartsContext):string

--- @class StlpartsContext
--- @field window_id integer
--- @field hl_group string
--- @field highlight fun(self:StlpartsContext,hl_group:string):StlpartsContext
--- @field window fun(self:StlpartsContext,window_id:integer):StlpartsContext

return M
