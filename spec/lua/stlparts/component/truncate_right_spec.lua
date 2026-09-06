local ntf = require("ntf")
local describe, it, before_each, after_each = ntf.describe, ntf.it, ntf.before_each, ntf.after_each
local helper = require("stlparts.test.helper")
local stlparts = require("stlparts")
local assert = helper.typed_assert(ntf.assert)

describe("stlparts.component.truncate_right()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("cuts the end away and marks it with the ellipsis", function()
    local TruncateRight = stlparts.component.truncate_right
    stlparts.set("default", TruncateRight("test_string", { max_width = 9 }))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "test_st..")
  end)

  it("counts a wide character as the cells it takes, not as its bytes", function()
    local TruncateRight = stlparts.component.truncate_right
    stlparts.set("default", TruncateRight("あいうえおかきくけこ", { max_width = 8 }))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "あいう..")
  end)

  it("keeps every character it returns whole, cutting on no byte inside one", function()
    local TruncateRight = stlparts.component.truncate_right
    stlparts.set("default", TruncateRight("aaa🙂🙂🙂bbb", { max_width = 8 }))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "aaa🙂..")
  end)

  it("returns the string as it is when it already fits", function()
    local TruncateRight = stlparts.component.truncate_right
    stlparts.set("default", TruncateRight("あい", { max_width = 8 }))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "あい")
  end)

  it("cuts the ellipsis itself when even that does not fit", function()
    local TruncateRight = stlparts.component.truncate_right
    stlparts.set("default", TruncateRight("あいうえお", { max_width = 1 }))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, ".")
  end)

  it("can use custom ellipsis", function()
    local TruncateRight = stlparts.component.truncate_right
    stlparts.set("default", TruncateRight("あいうえおかきくけこ", { max_width = 8, ellipsis = "…" }))

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "あいう…")
  end)
end)
