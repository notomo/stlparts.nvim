--- Build context and pass to children components.
--- @param make_context fun(ctx:StlpartsContext):StlpartsContext
--- @param component StlpartsComponent |StlpartsComponent|
--- @return StlpartsFunctionComponent # |StlpartsFunctionComponent|
return function(make_context, component)
  component = require("stlparts.core.component").get(component)
  return function(ctx)
    return component(make_context(ctx))
  end
end
