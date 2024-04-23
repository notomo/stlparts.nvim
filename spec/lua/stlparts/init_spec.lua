local helper = require("stlparts.test.helper")
local stlparts = helper.require("stlparts")

describe("stlparts.build()", function()
  before_each(helper.before_each)
  after_each(helper.after_each)

  it("returns statusline string", function()
    vim.cmd.edit("test")

    local Separate = stlparts.component.separate

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

  it("can use truncate_left", function()
    vim.cmd.edit("test")

    local TruncateLeft = stlparts.component.truncate_left

    stlparts.set(
      "default",
      TruncateLeft("test_string", {
        max_width = function()
          return 9
        end,
      })
    )

    local str = stlparts.build("default")
    assert.statusline(str, { fillchar = " ", maxwidth = 12 }, ".._string")
  end)

  it("can switch components", function()
    local Switch = stlparts.component.switch

    stlparts.set(
      "default",
      Switch(function()
        return vim.bo.filetype
      end, {
        lua = "test1",
        json = "test2",
      })
    )

    do
      vim.bo.filetype = "lua"
      local str = stlparts.build("default")
      assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "test1")
    end

    do
      vim.bo.filetype = "json"
      local str = stlparts.build("default")
      assert.statusline(str, { fillchar = " ", maxwidth = 12 }, "test2")
    end
  end)
end)
