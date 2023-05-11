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


local get_git_root = function()
    local handle = io.popen("(git rev-parse --show-toplevel) 2> /dev/null || pwd")
    local result = handle:read("*a")
    handle:close()
    local format = result:gsub('[\n\r]', '')
    return format
end


local find_files = function(opts)
    opts = opts or {}
    git_root = get_git_root_alt()
    opts.entry_maker = make_entry.gen_from_file(opts)
    pickers.new(opts, {
        prompt_title = get_git_root(),
        finder = finders.new_oneshot_job({ "ag", "-l", "-f", "-p", "~/.agignore", "--hidden", "", git_root }, opts),
        previewer = conf.file_previewer(opts),
        sorter = conf.file_sorter(opts),
    }):find()
end

local my_finders = function(opts)
    if opts.type == "find_files" then
        find_files(opts)
    elseif opts.type == "second" then
        echo "second"
    else
        echo "third"
    end
end

return telescope.register_extension({ exports = { my_finders = my_finders } })
