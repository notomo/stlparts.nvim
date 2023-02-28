--- Set default highlight group to use in children components.
--- @param hl_group string: highlight group
--- @param component StlpartsComponent |StlpartsComponent|
--- @return StlpartsFunctionComponent |StlpartsFunctionComponent|
return function(hl_group, component)
  component = require("stlparts.core.component").get(component)
  return function(ctx)
    return component(ctx:highlight(hl_group))
  end
end
