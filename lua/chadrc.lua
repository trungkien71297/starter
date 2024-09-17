-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    -- Keywords and control flow
    Keyword = { bold = true },
    ["@keyword"] = { bold = true },
    Conditional = { italic = true, bold = true },
    ["@conditional"] = { italic = true, bold = true },

    -- Functions and methods
    Function = { bold = true },
    ["@function"] = { bold = true },
    ["@method"] = { bold = true },

    -- Types and variables
    Type = { italic = true },
    ["@type"] = { italic = true },
    ["@variable"] = { italic = false },
    ["@parameter"] = { italic = true },

    -- Strings and special text
    String = { italic = true },
    ["@string"] = { italic = true },
    Special = { bold = true },
    ["@text.special"] = { bold = true },

    -- Constants and numbers
    Constant = { bold = true },
    ["@constant"] = { bold = true },
    Number = { bold = true },
    ["@number"] = { bold = true },

    -- Operators and punctuation
    Operator = { bold = true },
    ["@operator"] = { bold = true },
    ["@punctuation.delimiter"] = { bold = false },

    -- Properties and fields
    ["@property"] = { italic = true },
    ["@field"] = { italic = true },

    -- Tags and attributes (for HTML/XML)
    ["@tag"] = { bold = true },
    ["@tag.attribute"] = { italic = true },
  },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
