
local telescope = require('telescope')
local pickers = require('telescope.pickers')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local actions = require "telescope.actions"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"
local utils = require "telescope.utils"
local conf = require("telescope.config").values
local log = require "telescope.log"
local flatten = vim.tbl_flatten
local filter = vim.tbl_filter
local lib = require('telescope._extensions.lib')

local my_finders = function(opts)
    if opts.type == "first" then
        echo "first"
    elseif opts.type == "second" then
        echo "second"
    else
        echo "third"
    end
end

return telescope.register_extension({ exports = { my_finders = my_finders } })
