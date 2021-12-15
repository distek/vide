local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local lib = require'nvim-tree.lib'

local wallyImport = require("wally")
local darken = require('wally.util').darken

vim.cmd("highlight! NvimTreeNormal guibg=" .. darken(wallyImport.colors.bg_highlight, 0.5))
vim.cmd("highlight! Normal guibg=" .. darken(wallyImport.colors.bg_highlight, 0.5))
vim.cmd("highlight! CursorLine guibg=" .. wallyImport.colors.bg_highlight)

vim.o.statusline = ""
vim.o.showtabline = 0
vim.o.ruler = false
vim.o.showcmd = false
vim.o.laststatus = 0

require("bufferline").setup{
    options = {
        always_show_bufferline = false
    },
}

function IfDir(node)
    local path = node.absolute_path
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local stats = vim.loop.fs_stat(path)
    local isdir = stats and stats.type == 'directory'

    if isdir then
        lib.Tree.cwd = vim.fn.expand(bufname)
        lib.expand_or_collapse(node)
        return
    end

    vim.cmd("silent exec \"!nvr --servername /tmp/" .. os.getenv('VIDESOCK') .. " " .. path .. " &\"")
    vim.cmd("silent exec \"!tmux select-pane -t 1\"")
end

local function nvim_tree_callback(callback_name)
    tree_cb("refresh")

    if callback_name == "test" then
        return string.format(":lua IfDir(require'nvim-tree.lib'.get_node_at_cursor())<cr>")
    end
end

require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = true,
    ignore_ft_on_setup  = {},
    update_to_buf_dir   = {
        enable = true,
        auto_open = true,
    },
    auto_close          = true,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    update_focused_file = {
        enable      = true,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    view = {
        width = 30,
        side = 'left',
        auto_resize = false,
        mappings = {
            custom_only = true,
            list = {
                { key = {"<CR>"},    cb = nvim_tree_callback("test")},
            }
        }
    },
}
