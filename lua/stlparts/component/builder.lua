local get = require("stlparts.core.component").get

--- Build components dynamically.
--- @param create_component fun(ctx:StlpartsContext):StlpartsComponent
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(create_component)
  return function(ctx)
    local component = create_component(ctx)
    return get(component)(ctx)
  end
end
