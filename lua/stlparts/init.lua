local M = {}

--- @class StlpartsBuildOption
--- @field window_id integer?
--- @field hl_group string? default: "StatusLine"

--- Returns a 'statusline' string.
--- @param name string: registered name by |stlparts.set()|
--- @param opts StlpartsBuildOption?: |StlpartsBuildOption|
--- @return string # statusline expression string
function M.build(name, opts)
  return require("stlparts.command").build(name, opts)
end

-- for type annotations
local public_components = {
  --- @module "stlparts.component.tab"
  ---@diagnostic disable-next-line: assign-type-mismatch
  tab = nil,
  --- @module "stlparts.component.builder"
  ---@diagnostic disable-next-line: assign-type-mismatch
  builder = nil,
  --- @module "stlparts.component.switch"
  ---@diagnostic disable-next-line: assign-type-mismatch
  switch = nil,
  --- @module "stlparts.component.separate"
  ---@diagnostic disable-next-line: assign-type-mismatch
  separate = nil,
  --- @module "stlparts.component.highlight"
  ---@diagnostic disable-next-line: assign-type-mismatch
  highlight = nil,
  --- @module "stlparts.component.default_highlight"
  ---@diagnostic disable-next-line: assign-type-mismatch
  default_highlight = nil,
  --- @module "stlparts.component.truncate_left"
  ---@diagnostic disable-next-line: assign-type-mismatch
  truncate_left = nil,
  --- @module "stlparts.component.truncate_right"
  ---@diagnostic disable-next-line: assign-type-mismatch
  truncate_right = nil,
  --- @module "stlparts.component.context_builder"
  ---@diagnostic disable-next-line: assign-type-mismatch
  context_builder = nil,
}

--- Components accessor.
--- - Usage: `require("stlparts").component.{component_name}`
--- - Example: |stlparts.nvim-EXAMPLES|
--- - All components: |stlparts.nvim-COMPONENTS|
M.component = setmetatable(public_components, {
  __index = function(tbl, name)
    tbl[name] = require("stlparts.command").component(name)
    return tbl[name]
  end,
})

--- Set a component.
--- @param name string: use to refer from |stlparts.build()|
--- @param component StlpartsComponent |StlpartsComponent|
function M.set(name, component)
  require("stlparts.command").set(name, component)
end

--- @alias StlpartsComponent StlpartsFunctionComponent|string|StlpartsComponent[]

--- @alias StlpartsFunctionComponent fun(ctx:StlpartsContext):string

--- @class StlpartsContext
--- @field window_id integer
--- @field hl_group string
--- @field tab_id integer|nil not nil if the component has tab component ancestor
--- @field width fun(self:StlpartsContext):integer
--- @field with_highlight fun(self:StlpartsContext,hl_group:string):StlpartsContext
--- @field with_window fun(self:StlpartsContext,window_id:integer):StlpartsContext
--- @field with_tab fun(self:StlpartsContext,window_id:integer):StlpartsContext

return M
