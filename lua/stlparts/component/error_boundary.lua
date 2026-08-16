--- Catch errors from component and show notification once.
--- @param component StlpartsComponent |StlpartsComponent|
--- @param opts StlpartsErrorBoundaryOption? |StlpartsErrorBoundaryOption|
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(component, opts)
  component = require("stlparts.core.component").get(component)
  opts = opts or {}

  local fallback_component = require("stlparts.core.component").get(opts.fallback_component or "ERROR")

  return function(ctx)
    local ok, result = pcall(component, ctx)
    if ok then
      return result
    end
    vim.notify_once(result, vim.log.levels.WARN)
    return fallback_component(ctx)
  end
end

--- @class StlpartsErrorBoundaryOption
--- @field fallback_component StlpartsComponent? default: "ERROR"
