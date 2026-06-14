local ntf = require("ntf")
local describe, it, before_each, after_each = ntf.describe, ntf.it, ntf.before_each, ntf.after_each
local helper = require("stlparts.test.helper")
local stlparts = require("stlparts")
local assert = helper.typed_assert(ntf.assert)

describe("stlparts.component.error_boundary()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("returns fallback 'ERROR' when component raises error", function()
    local ErrorBoundary = stlparts.component.error_boundary
    stlparts.set(
      "default",
      ErrorBoundary(function()
        error("test error")
      end)
    )

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "ERROR")
  end)

  it("can use custom fallback_component", function()
    local ErrorBoundary = stlparts.component.error_boundary
    stlparts.set(
      "default",
      ErrorBoundary(function()
        error("test error")
      end, { fallback_component = "FALLBACK" })
    )

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "FALLBACK")
  end)

  it("returns the component result when no error occurs", function()
    local ErrorBoundary = stlparts.component.error_boundary
    stlparts.set("default", ErrorBoundary("ok_result"))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "ok_result")
  end)
end)
