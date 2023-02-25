local helper = require("stlparts.test.helper")
local stlparts = helper.require("stlparts")

describe("stlparts.build()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("returns statusline string", function()
    vim.cmd.edit("test")

    local Separate = stlparts.component("separate")

    stlparts.set("default", {
      " ",
      Separate({
        function()
          return vim.fn.expand("%")
        end,
        {
          function()
            return "st"
          end,
          "r",
        },
      }),
      " ",
    })

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, " test   str ")
  end)

  it("can use trancate_left", function()
    vim.cmd.edit("test")

    local TrancateLeft = stlparts.component("trancate_left")

    stlparts.set(
      "default",
      TrancateLeft("test_string", {
        max_width = function()
          return 9
        end,
      })
    )

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, ".._string")
  end)
end)
