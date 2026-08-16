local ContextBuilder = require("stlparts.core.component").require("context_builder")

--- Set default highlight group to use in children components.
--- @param hl_group string: highlight group
--- @param component StlpartsComponent
--- @return StlpartsFunctionComponent
return function(hl_group, component)
  return ContextBuilder(function(ctx)
    return ctx:with_highlight(hl_group)
  end, component)
end
