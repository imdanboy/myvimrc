--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- NOTE(jinbei): 
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Insert 모드 탈출' })

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 0

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- 현재 파일 경로 복사. clipboard=unnamedplus 라 @+ = OS 클립보드. which-key 그룹은 spec 의 '<leader>c' 참고.
local function copy_path(mod, label)
  return function()
    local p = vim.fn.expand('%' .. mod)
    vim.fn.setreg('+', p)
    vim.notify('복사됨 (' .. label .. '): ' .. p)
  end
end
vim.keymap.set('n', '<leader>cp', copy_path(':p', '절대'), { desc = 'Copy [P]ath (절대)' })
vim.keymap.set('n', '<leader>cr', copy_path(':.', 'cwd상대'), { desc = 'Copy path ([R]elative)' })
vim.keymap.set('n', '<leader>cn', copy_path(':t', '파일명'), { desc = 'Copy file[N]ame' })
vim.keymap.set('n', '<leader>cd', copy_path(':p:h', '디렉토리'), { desc = 'Copy [D]ir' })

-- 터미널 모드 탈출(→ Normal): 단일 키 <C-q>.
--   <Esc><Esc> 는 안 씀 — 첫 Esc 를 timeoutlen(300ms) 동안 붙들어, claude 등 TUI 의 Esc 가
--   느려지고 오작동하는 부작용이 있었음. 단일 키라 지연 0, claude 의 Esc 는 그대로 claude 로 감.
--   <C-q> 는 claude/셸이 거의 안 쓰는 키. 캐논 폴백은 항상 <C-\><C-n>.
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode (to Normal)' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
  { 'NMAC427/guess-indent.nvim', opts = {} },

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>c', group = '[C]opy path' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
        { '<leader>g', group = 'AI/Gemini' },
        -- \w*: 프로젝트/홈 위키 진입. 상세는 [[/topics/nvim-wiki-keys]].
        { '\\w', group = 'Wiki' },
        { '\\wt', group = 'todos (w/h)' },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    -- By default, Telescope is included and acts as your picker for everything.

    -- If you would like to switch to a different picker (like snacks, or fzf-lua)
    -- you can disable the Telescope plugin by setting enabled to false and enable
    -- your replacement picker by requiring it explicitly (e.g. 'custom.plugins.snacks')

    -- Note: If you customize your config for yourself,
    -- it’s best to remove the Telescope plugin config entirely
    -- instead of just disabling it here, to keep your config clean.
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
      -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Find references for the word under your cursor.
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

          -- Jump to the implementation of the word under your cursor.
          -- Useful when your language has ways of declaring types without an actual implementation.
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

          -- Jump to the definition of the word under your cursor.
          -- This is where a variable was first declared, or where a function is defined, etc.
          -- To jump back, press <C-t>.
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

          -- Fuzzy find all the symbols in your current document.
          -- Symbols are things like variables, functions, types, etc.
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

          -- Fuzzy find all the symbols in your current workspace.
          -- Similar to document symbols, except searches over your entire project.
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

          -- Jump to the type of the word under your cursor.
          -- Useful when you're not sure what type a variable is and you want to see
          -- the definition of its *type*, not where it was *defined*.
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })

      -- Override default behavior and theme when searching
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        ---@diagnostic disable-next-line: missing-fields
        opts = {},
      },
      -- Maps LSP server names between nvim-lspconfig and Mason package names.
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  See `:help lsp-config` for information about keys and how to configure
      ---@type table<string, vim.lsp.Config>
      local servers = {
        -- clangd = {},
        -- gopls = {},
        pyright = {},
        -- rust_analyzer = {},
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},

        stylua = {}, -- Used to format Lua code

        -- Special Lua Config, as recommended by neovim help docs
        lua_ls = {
          on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                  '${3rd}/luv/library',
                  '${3rd}/busted/library',
                }),
              },
            })
          end,
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              format = { enable = false }, -- Disable formatting (formatting is done by stylua)
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- You can add other tools here that you want Mason to install
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- You can specify filetypes to autoformat on save here:
        local enabled_filetypes = {
          -- lua = true,
          -- python = true,
        }
        if enabled_filetypes[vim.bo[bufnr].filetype] then
          return { timeout_ms = 500 }
        else
          return nil
        end
      end,
      default_format_opts = {
        lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
      },
      -- You can also specify external formatters in here.
      formatters_by_ft = {
        -- rust = { 'rustfmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
        config = function(_, opts)
          local ls = require 'luasnip'
          ls.setup(opts)
          local s, t, i = ls.snippet, ls.text_node, ls.insert_node
          ls.add_snippets('markdown', {
            s('task', {
              t '## ', i(1, '번호'), t { '.', '**목표:**', '' }, i(2),
              t { '', '**컨텍스트:**', '' }, i(3),
              t { '', '**지시사항:**', '' }, i(4),
              t { '', '**완료 기준:**', '' }, i(0),
            }),
          })
        end,
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- Colorscheme: catppuccin (latte = 낮용 라이트, mocha/frappe/macchiato = 야간 다크)
    -- 다른 테마로 바꾸려면 아래 플러그인 이름과 vim.cmd.colorscheme 만 교체.
    -- 설치된 테마 둘러보기: `:Telescope colorscheme`
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('catppuccin').setup {
        flavour = 'latte', -- latte | frappe | macchiato | mocha
        no_italic = true,  -- 댓글/키워드 이탤릭 끔
        integrations = {
          -- 기본 enabled: treesitter / telescope / gitsigns / mini / nvimtree
          neotree = true,
          render_markdown = true,
          which_key = true,
          blink_cmp = true,
          fidget = true,
          mason = true,
          todo_comments = true,
          markdown = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin-latte'

      -- <leader>tt: catppuccin latte(light) ↔ macchiato(dark) 토글
      vim.keymap.set('n', '<leader>tt', function()
        local current = vim.g.colors_name or ''
        if current == 'catppuccin-latte' then
          vim.cmd.colorscheme 'catppuccin-macchiato'
        else
          vim.cmd.colorscheme 'catppuccin-latte'
        end
      end, { desc = '[T]oggle [T]heme (catppuccin light/dark)' })
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup {
        -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
        mappings = {
          around_next = 'aa',
          inside_next = 'ii',
        },
        n_lines = 500,
      }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end

      -- Show open buffers in the tabline (top bar)
      require('mini.tabline').setup { use_icons = vim.g.have_nerd_font }

      -- Buffer navigation keymaps (similar to unimpaired or common setups)
      --vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = 'Go to previous buffer' })
      --vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Go to next buffer' })
      -- Optional: Use Tab/Shift-Tab for faster navigation
      --vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Go to next buffer' })
      --vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Go to previous buffer' })

      -- ... and there is more!
      --  Check out: https://github.com/nvim-mini/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
      -- ensure basic parser are installed
      local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then return end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based folds
        -- for more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

        -- enables treesitter based indentation
        if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommended keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- NOTE(jinbei): add to kickstart.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Neo-tree toggle' },
    },
    opts = {
    filesystem = {
      window = {
      position = 'left',
      width = 30,
           },
      filtered_items = {
        hide_gitignored = false,
      },
         },
     },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
      },
    keys = {
        { '<leader>O', '<cmd>AerialToggle!<CR>', desc = 'Aerial Toggle' },
      },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {},
    keys = {
      { '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', desc = '[T]oggle [M]arkdown render', ft = 'markdown' },
    },
  },
  {
    "lervag/wiki.vim",
    init = function()
      vim.g.wiki_filetypes = { 'md' }
      vim.g.wiki_link_extension = '.md'
      -- 기본 wiki_root. \ww 가 프로젝트 인지 시 동적으로 덮어씀.
      -- wiki.vim 은 ~ 을 자동 확장하지 않으므로 expand() 로 절대경로 변환.
      vim.g.wiki_root = vim.fn.expand('~/wiki')

      -- 프로젝트 위키 루트 탐색 헬퍼.
      --   위로 올라가며 docs/wiki/ 디렉토리를 가진 곳을 프로젝트 위키 루트로 판정.
      --   CLAUDE.md 는 이제 판별자로 못 씀 — agent-agnostic 부트스트랩으로 홈 위키
      --   ~/wiki/ 에도 AGENTS.md + CLAUDE.md/GEMINI.md (@AGENTS.md import stub) 를 두기 때문.
      --   docs/wiki/ 는 llm-wiki 프로젝트 구조의 고유 시그니처라 홈 위키·일반 docs 사이트
      --   (docs/index.md 만 있는 Sphinx/Docusaurus 등) 와 확실히 구분됨 (WIKI-CONVENTIONS §11).
      --   반환: 프로젝트 루트 절대경로 또는 nil.
      local function find_project_wiki_root(start)
        local wiki_dir = vim.fn.finddir('docs/wiki', start .. ';')
        if wiki_dir == '' then return nil end
        local abs = vim.fn.fnamemodify(wiki_dir, ':p'):gsub('/$', '')
        return vim.fn.fnamemodify(abs, ':h:h') -- .../docs/wiki → docs → 루트
      end

      -- 키맵 공통: 탐색 시작 디렉토리 (현재 버퍼 dir, 없으면 cwd).
      local function wiki_start_dir()
        local d = vim.fn.expand('%:p:h')
        if d == '' or d == '.' then d = vim.fn.getcwd() end
        return d
      end

      -- \ww: 위키 인덱스 (MOC) 진입점
      --   위로 올라가며 docs/wiki/ 로 프로젝트 위키 루트 식별.
      --   - 발견: wiki_root 를 프로젝트 루트로, docs/index.md (프로젝트 MOC) 열기.
      --   - 미발견: wiki_root 를 ~/wiki 로 복원 + WikiIndex (~/wiki/index.md, 홈 MOC).
      --   CLAUDE.md (agent 부트스트랩) 로 직접 점프하려면 \wc.
      vim.keymap.set('n', '\\ww', function()
        local root = find_project_wiki_root(wiki_start_dir())
        if root then
          vim.g.wiki_root = root
          local moc = root .. '/docs/index.md'
          if vim.fn.filereadable(moc) == 0 then
            vim.notify('docs/wiki/ 는 있으나 docs/index.md 없음 — 빈 버퍼로 엶', vim.log.levels.WARN)
          end
          vim.cmd('edit ' .. vim.fn.fnameescape(moc))
        else
          vim.g.wiki_root = vim.fn.expand('~/wiki')
          vim.cmd('WikiIndex')
        end
      end, { desc = 'Wiki Index / MOC (docs/index.md or ~/wiki/index.md)' })

      -- \wc: CLAUDE.md (agent 세션 부트스트랩) 로 점프
      --   \ww 와 분리 — \ww 는 vault MOC, \wc 는 agent 부트스트랩 파일.
      --   홈 위키(~/wiki/CLAUDE.md, @AGENTS.md import) 에서도 동작.
      vim.keymap.set('n', '\\wc', function()
        local claude = vim.fn.findfile('CLAUDE.md', wiki_start_dir() .. ';')
        if claude == '' then
          vim.notify('CLAUDE.md not found — not in a project', vim.log.levels.WARN)
          return
        end
        vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.fnamemodify(claude, ':p')))
      end, { desc = 'Wiki CLAUDE.md (agent bootstrap)' })

      -- \wT: 오늘의 작업 명세 (docs/task/YYYYMMDD.md) 로 점프
      --   docs/wiki/ 로 프로젝트 위키 루트를 찾고, <root>/docs/task/<today>.md 열기.
      --   파일이 없어도 그 경로의 빈 버퍼가 열림 (템플릿 생성은 /project-new-task 스킬).
      --   NOTE: \wt 는 todos 프리픽스(\wtw/\wth)에 양보하고 task 는 대문자 \wT 로 이전.
      vim.keymap.set('n', '\\wT', function()
        local root = find_project_wiki_root(wiki_start_dir())
        if not root then
          vim.notify('docs/wiki/ not found — not in a project wiki', vim.log.levels.WARN)
          return
        end
        local task_path = root .. '/docs/task/' .. os.date('%Y%m%d') .. '.md'
        vim.cmd('edit ' .. vim.fn.fnameescape(task_path))
      end, { desc = "Wiki Today's Task (docs/task/YYYYMMDD.md)" })

      -- \wr: 오늘의 리포트 (docs/reports/YYYY-MM-DD.md) 로 점프
      --   리포트는 대시 포맷 (YYYY-MM-DD), task/logs 는 YYYYMMDD 임에 주의.
      vim.keymap.set('n', '\\wr', function()
        local root = find_project_wiki_root(wiki_start_dir())
        if not root then
          vim.notify('docs/wiki/ not found — not in a project wiki', vim.log.levels.WARN)
          return
        end
        local report_path = root .. '/docs/reports/' .. os.date('%Y-%m-%d') .. '.md'
        vim.cmd('edit ' .. vim.fn.fnameescape(report_path))
      end, { desc = "Wiki Today's Report (docs/reports/YYYY-MM-DD.md)" })

      -- \wl: 오늘의 logs 디렉토리 (docs/logs/YYYYMMDD/) 를 neo-tree 로 열기
      vim.keymap.set('n', '\\wl', function()
        local root = find_project_wiki_root(wiki_start_dir())
        if not root then
          vim.notify('docs/wiki/ not found — not in a project wiki', vim.log.levels.WARN)
          return
        end
        local logs_dir = root .. '/docs/logs/' .. os.date('%Y%m%d')
        vim.fn.mkdir(logs_dir, 'p')
        vim.cmd('Neotree dir=' .. vim.fn.fnameescape(logs_dir) .. ' reveal')
      end, { desc = "Wiki Today's Logs (docs/logs/YYYYMMDD/)" })

      -- \wj: 홈 위키 — 오늘의 저널 (~/wiki/journal/YYYY-MM-DD.md)
      --   프로젝트 task (\wt) 와 대칭. 저널은 대시 포맷.
      --   파일이 없어도 그 경로의 빈 버퍼가 열림 (생성은 /home-journal-today 스킬).
      vim.keymap.set('n', '\\wj', function()
        local path = vim.fn.expand('~/wiki/journal/') .. os.date('%Y-%m-%d') .. '.md'
        vim.cmd('edit ' .. vim.fn.fnameescape(path))
      end, { desc = "Wiki home today's Journal (~/wiki/journal/YYYY-MM-DD.md)" })

      -- \wtw / \wth: 홈 위키 — todos (업무/개인 분리)
      --   t=todo, 다음 글자로 work/home 갈라짐. \wt 가 프리픽스가 되며 project task 는 \wT 로 이전.
      vim.keymap.set('n', '\\wtw', function()
        vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.expand('~/wiki/todos-work.md')))
      end, { desc = 'Wiki home todos · Work (~/wiki/todos-work.md)' })
      vim.keymap.set('n', '\\wth', function()
        vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.expand('~/wiki/todos-home.md')))
      end, { desc = 'Wiki home todos · Home (~/wiki/todos-home.md)' })

      -- \wi: 홈 위키 — journal 인덱스 (~/wiki/journal/index.md)
      --   홈 vault 전체 인덱스(~/wiki/index.md) 는 \ww 폴백이 담당. 여기 i 는 journal MOC.
      vim.keymap.set('n', '\\wi', function()
        vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.expand('~/wiki/journal/index.md')))
      end, { desc = 'Wiki home journal Index (~/wiki/journal/index.md)' })

      -- \wb: 홈 위키 — journal inbox (~/wiki/journal/inbox.md)
      --   raw 캡처용. b = inBox.
      vim.keymap.set('n', '\\wb', function()
        vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.expand('~/wiki/journal/inbox.md')))
      end, { desc = 'Wiki home journal inBox (~/wiki/journal/inbox.md)' })

      -- ============================================================
      -- 시크릿 노트: age 암호화 (전략 B-pty — 의존성 0, jobstart pty)
      --   대상: */wiki/secrets/*.age   (예: ~/wiki/secrets/memo.md.age)
      --   · 평문은 nvim 버퍼 안에서만. 디스크/동기화 경로엔 .age 암호문만.
      --   · age 패스프레이즈 모드는 /dev/tty 전용인데, 이 환경에선 `:!` 자식이
      --     /dev/tty 에 접근 불가("device not configured"). 그래서 jobstart({pty=true})
      --     로 age 에 새 제어 터미널(pty)을 직접 할당 → age 가 /dev/tty 를 연다.
      --   · 패스프레이즈: nvim inputsecret() 로 받아 pty 로 전달(chansend). 매번 재입력,
      --     캐시 안 함, 사용 직후 변수 해제. 평문 출력은 별도 FIFO 로 받아 pty CR/LF
      --     변환에 오염되지 않게 함.
      --   · 트레이드오프(전략 A 대비): 패스프레이즈가 입력 순간 nvim 프로세스 메모리에
      --     잠깐 존재. age-plugin-batchpass(전략 B)와 달리 세션 캐시/추가 바이너리는 없음.
      -- ============================================================
      local secret_grp = vim.api.nvim_create_augroup('SecretAge', { clear = true })

      -- 평문 디스크 누수 차단 + shada 억제 (시크릿 버퍼 진입 즉시)
      local function secret_lockdown()
        vim.bo.swapfile = false        -- .swp 평문 누수 방지
        vim.bo.undofile = false        -- 영구 undo 파일 누수 방지
        vim.bo.bufhidden = 'wipe'      -- 숨길 때 버퍼 폐기(평문 메모리 잔존 최소화)
        vim.opt_local.backup = false
        vim.opt_local.writebackup = false
        -- shada 는 per-buffer 불가 → 세션 동안 기록 차단(마크/레지스터/검색어 누수 방지). 1회 고지.
        if vim.o.shadafile ~= 'NONE' then
          vim.o.shadafile = 'NONE'
          vim.schedule(function()
            vim.notify('[secret] 이 세션 동안 shada 기록 OFF (시크릿 메타데이터 누수 방지)', vim.log.levels.WARN)
          end)
        end
      end

      -- 복호화: age -d 를 pty job 으로 실행(/dev/tty=pty 확보), 패스프레이즈는 pty 로 전달.
      -- 평문은 stdout→FIFO→cat reader 로 깨끗하게 수집. 반환: 라인 테이블 또는 nil(+에러).
      local function age_decrypt(file, pw)
        local fifo = vim.fn.tempname() .. '.fifo'   -- tempname 부모 dir 은 사용자 전용
        vim.fn.system({ 'mkfifo', '-m', '600', fifo })
        if vim.v.shell_error ~= 0 then return nil, 'mkfifo 실패' end
        local chunks, rdone = { '' }, false
        local reader = vim.fn.jobstart({ 'cat', fifo }, {
          on_stdout = function(_, data)
            if not data then return end
            chunks[#chunks] = chunks[#chunks] .. data[1]
            for i = 2, #data do chunks[#chunks + 1] = data[i] end
          end,
          on_exit = function() rdone = true end,
        })
        if reader <= 0 then vim.fn.delete(fifo); return nil, 'reader 기동 실패' end
        vim.wait(100)   -- cat 가 fifo read-end 를 열 시간 확보
        local edone, erc = false, -1
        local age = vim.fn.jobstart(
          { 'sh', '-c', 'age -d -- ' .. vim.fn.shellescape(file) .. ' > ' .. vim.fn.shellescape(fifo) },
          { pty = true, on_exit = function(_, code) erc = code; edone = true end }
        )
        if age <= 0 then vim.fn.delete(fifo); return nil, 'age 기동 실패' end
        vim.fn.chansend(age, pw .. '\n')   -- /dev/tty(pty) 로 패스프레이즈 전달
        vim.wait(15000, function() return edone and rdone end, 20)
        vim.fn.delete(fifo)
        if erc ~= 0 then return nil, '복호화 실패(패스프레이즈?)' end
        if #chunks > 1 and chunks[#chunks] == '' then table.remove(chunks) end  -- trailing newline
        return chunks
      end

      -- 재암호화: 버퍼 평문을 FIFO→age -p stdin 으로, age 는 pty job(패스프레이즈 enter+confirm
      -- 2회를 pty 로 전달). 암호문 tmp 후 원자적 교체. 평문은 디스크 미경유.
      local function age_encrypt(file, lines, pw)
        local fifo = vim.fn.tempname() .. '.fifo'
        vim.fn.system({ 'mkfifo', '-m', '600', fifo })
        if vim.v.shell_error ~= 0 then return false, 'mkfifo 실패' end
        local tmp = file .. '.tmp'
        local wdone = false
        local writer = vim.fn.jobstart({ 'sh', '-c', 'cat > ' .. vim.fn.shellescape(fifo) }, {
          on_exit = function() wdone = true end,
        })
        if writer <= 0 then vim.fn.delete(fifo); return false, 'writer 기동 실패' end
        vim.fn.chansend(writer, table.concat(lines, '\n') .. '\n')
        vim.fn.chanclose(writer, 'stdin')
        vim.wait(100)
        local edone, erc = false, -1
        local age = vim.fn.jobstart(
          { 'sh', '-c', 'age -p -o ' .. vim.fn.shellescape(tmp) .. ' < ' .. vim.fn.shellescape(fifo) },
          { pty = true, on_exit = function(_, code) erc = code; edone = true end }
        )
        if age <= 0 then vim.fn.delete(fifo); return false, 'age 기동 실패' end
        vim.fn.chansend(age, pw .. '\n' .. pw .. '\n')   -- Enter + Confirm
        vim.wait(15000, function() return edone and wdone end, 20)
        vim.fn.delete(fifo)
        if erc ~= 0 then vim.fn.delete(tmp); return false, '암호화 실패' end
        if vim.loop.fs_rename(tmp, file) == nil and not os.rename(tmp, file) then
          vim.fn.delete(tmp); return false, '교체 실패'
        end
        return true
      end

      -- .age → 버퍼 로드(복호화). bufnr 명시: startup 지연 호출에서도 안전.
      local function decrypt_into_buffer(bufnr, file)
        if not vim.api.nvim_buf_is_valid(bufnr) then return end
        local pw = vim.fn.inputsecret('age 패스프레이즈 (복호화): ')
        local lines, err
        if pw == '' then
          err = '취소됨'
        else
          lines, err = age_decrypt(file, pw)
        end
        pw = nil   -- 사용 직후 해제
        vim.api.nvim_buf_call(bufnr, function()
          if not lines then
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
            vim.b[bufnr].secret_decrypt_failed = true   -- 빈 버퍼 저장→암호문 덮어쓰기 거부
            vim.bo.modifiable = false
            vim.bo.modified = false
            vim.api.nvim_echo({ { '[secret] ' .. (err or '복호화 실패') .. ' — .age 원본 보존(:w 차단). 다시 :e 로 재시도.', 'ErrorMsg' } }, true, {})
            return
          end
          vim.bo.modifiable = true
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
          vim.b[bufnr].secret_decrypt_failed = false
          vim.bo.filetype = 'markdown'
          vim.bo.modified = false
        end)
        vim.cmd('redraw!')
      end

      -- 복호화 트리거: startup 중(BufReadCmd가 VimEnter 이전)이면 :! 터미널 양도가 안 되므로
      -- VimEnter 이후로 지연(vim-gnupg 와 동일 전략). 지연 중에는 :w 차단 플래그로 보호.
      vim.api.nvim_create_autocmd('BufReadCmd', {
        group = secret_grp,
        pattern = '*/wiki/secrets/*.age',
        callback = function(ev)
          secret_lockdown()
          local file = vim.fn.fnamemodify(ev.match, ':p')
          local bufnr = ev.buf
          if vim.fn.filereadable(file) == 0 then
            -- 새 시크릿(.age 미존재): 복호화 안 함. 빈 markdown 버퍼, 첫 :w 에서 암호화.
            vim.bo.filetype = 'markdown'
            vim.b[bufnr].secret_decrypt_failed = false
            return
          end
          vim.b[bufnr].secret_decrypt_failed = true   -- 복호화 완료 전까지 :w 차단
          if vim.v.vim_did_enter == 1 then
            decrypt_into_buffer(bufnr, file)
          else
            vim.api.nvim_create_autocmd('VimEnter', {
              once = true,
              callback = function() decrypt_into_buffer(bufnr, file) end,
            })
          end
        end,
      })

      -- 재암호화: 버퍼 → .age
      vim.api.nvim_create_autocmd('BufWriteCmd', {
        group = secret_grp,
        pattern = '*/wiki/secrets/*.age',
        callback = function(ev)
          if vim.b.secret_decrypt_failed then        -- 복호화 실패 버퍼는 저장 거부(.age 보호)
            vim.api.nvim_echo({ { '[secret] 복호화 실패 상태 — 저장 거부. .age 원본 보존.', 'ErrorMsg' } }, true, {})
            return
          end
          local file = vim.fn.fnamemodify(ev.match, ':p')
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          local p1 = vim.fn.inputsecret('age 패스프레이즈 (저장): ')
          local p2 = vim.fn.inputsecret('확인: ')
          if p1 == '' then
            p1 = nil; p2 = nil
            vim.api.nvim_echo({ { '[secret] 취소됨 — 저장 안 함. .age 보존.', 'WarningMsg' } }, false, {})
            return
          end
          if p1 ~= p2 then
            p1 = nil; p2 = nil
            vim.api.nvim_echo({ { '[secret] 패스프레이즈 불일치 — 저장 안 함. 다시 :w.', 'ErrorMsg' } }, true, {})
            return
          end
          local ok, err = age_encrypt(file, lines, p1)
          p1 = nil; p2 = nil   -- 사용 직후 해제
          if not ok then
            vim.api.nvim_echo({ { '[secret] ' .. (err or '실패') .. ' — .age 보존됨. 다시 :w.', 'ErrorMsg' } }, true, {})
            return
          end
          vim.bo.modified = false
          vim.cmd('redraw!')
          vim.api.nvim_echo({ { '[secret] 암호화 저장: ' .. vim.fn.fnamemodify(file, ':t'), 'MoreMsg' } }, false, {})
        end,
      })

      -- 새 시크릿 파일(.age 미존재): 빈 버퍼 잠금 + markdown. 첫 :w 에서 암호화.
      vim.api.nvim_create_autocmd('BufNewFile', {
        group = secret_grp,
        pattern = '*/wiki/secrets/*.age',
        callback = function()
          secret_lockdown()
          vim.bo.filetype = 'markdown'
        end,
      })

      -- \sc: 시크릿 파일 브라우저 (~/wiki/secrets/*.age, age 자동 복호화)
      --   Telescope 로 secrets 폴더 내 .age 파일 전체 검색. 새 파일 추가 시 키매핑 수정 불필요.
      vim.keymap.set('n', '\\sc', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.expand('~/wiki/secrets'),
          prompt_title = 'Wiki Secrets',
        }
      end, { desc = 'Find & open wiki secret files (~/wiki/secrets/*.age)' })
    end
  },

  -- NOTE(jinbei): Claude Code 통합 — nvim 안에서 Claude Code CLI 연동
  --   터미널 split 으로 claude 실행 + 버퍼/선택 영역 전송 + 변경 제안을 nvim diff 로 수락/거부.
  --   prefix <leader>a (AI). 의존성 snacks.nvim 은 터미널/디퍼 UI 용(lazy 가 자동 설치).
  --   claude CLI 가 PATH 에 있어야 함. 자세한 사용법: 위키 [[remote-dev-workflow]] 참고.
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    -- lazy-load (cmd/keys 트리거) — 시작 오버헤드 0. claude 안 쓰는 nvim 세션엔 로드 안 됨.
    --   별도 cmux pane 의 claude 를 /ide 로 붙이려면, 먼저 이 nvim 에서 :ClaudeCodeStart
    --   (또는 <leader>a*) 한 번 실행 → WS 서버 기동 + ~/.claude/ide/<port>.lock 기록. 그다음 /ide.
    opts = {
      -- 별도 cmux pane 의 claude 에 /ide 로 연결해 쓰는 워크플로우라, nvim 이 자체 터미널을
      -- 띄우지 않게 no-op provider 사용. (기본값이면 send 후 ensure_visible() 가 내장 터미널
      -- claude 를 새로 띄움 — 외부 pane 과 중복.) send/선택전송/diff 는 WS 로 그대로 동작.
      terminal = { provider = 'none' },
      -- auto_start=false: 플러그인 로드 시 WS 서버를 자동 기동하지 않음. 외부 pane 의 claude 를
      --   /ide 로 붙이는 워크플로우라, /ide 연결 전 <leader>a* (send/선택전송) 는 의미가 없음.
      --   <leader>aS 로 명시적으로 서버를 띄운 뒤 /ide → 작업, 순서를 명확히 하려는 의도.
      auto_start = false,
    },
    cmd = {
      'ClaudeCode', 'ClaudeCodeFocus', 'ClaudeCodeSelectModel',
      'ClaudeCodeAdd', 'ClaudeCodeSend', 'ClaudeCodeTreeAdd', 'ClaudeCodeStatus',
      'ClaudeCodeStart', 'ClaudeCodeStop', 'ClaudeCodeOpen', 'ClaudeCodeClose',
      'ClaudeCodeDiffAccept', 'ClaudeCodeDiffDeny', 'ClaudeCodeCloseAllDiffs',
    },
    keys = {
      { '<leader>a', nil, desc = 'AI/Claude Code' },
      { '<leader>aS', '<cmd>ClaudeCodeStart<cr>', desc = 'Start Claude WS server (/ide 전 1단계)' },
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send selection to Claude' },
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },

  -- NOTE(jinbei): opencode.nvim — nvim 안에서 OpenCode AI 연동
  --   snacks.nvim(claudecode.nvim 의존성)을 터미널/피커/인풋/디퍼로 재활용.
  --   opencode CLI 는 이미 homebrew 로 설치됨. 외부 cmux pane 에서 --port 로 실행하거나,
  --   snacks.terminal 로 내장 실행. <leader>o* prefix.
  {
    'nickjvandyke/opencode.nvim',
    version = '*',
    dependencies = { 'folke/snacks.nvim' },
    -- opencode.nvim 은 setup() 이 없음 — 설정은 vim.g.opencode_opts 로 (lazy `opts` 는 무시됨).
    --   서버는 server/discovery 가 실행 중인 opencode 프로세스(외부 cmux pane 등)를 자동 발견.
    init = function()
      vim.o.autoread = true -- events.reload (opencode 가 편집한 버퍼 자동 리로드)에 필요
      vim.g.opencode_opts = {
        select = {
          prompts = { -- 내장 라이브러리(explain/fix/test/document/optimize/review…)에 커스텀 merge
            refactor = 'Refactor @this for clarity without changing behavior',
          },
        },
      }
    end,
    keys = {
      { '<leader>o', nil, desc = 'AI/OpenCode' },
      { '<leader>oa', function() require('opencode').ask('@this: ') end, desc = 'Ask opencode…', mode = { 'n', 'x' } },
      { '<leader>ob', function() require('opencode').ask('@buffer: ') end, desc = 'Ask opencode (buffer)', mode = { 'n', 'x' } },
      { '<leader>os', function() require('opencode').select() end, desc = 'Select opencode prompt…', mode = { 'n', 'x' } },
      -- 최소 프롬프트 한 키 호출 (gp hook 대응) — 내장 prompts 라이브러리 직결. 비주얼 선택 시 @this=선택영역.
      { '<leader>oe', function() require('opencode').prompt('Explain @this and its context') end, desc = 'opencode: Explain', mode = { 'n', 'x' } },
      { '<leader>of', function() require('opencode').prompt('Fix @diagnostics') end, desc = 'opencode: Fix diagnostics', mode = { 'n', 'x' } },
      { '<leader>ot', function() require('opencode').prompt('Add tests for @this') end, desc = 'opencode: Tests', mode = { 'n', 'x' } },
      { '<leader>od', function() require('opencode').prompt('Add comments documenting @this') end, desc = 'opencode: Document', mode = { 'n', 'x' } },
      { '<leader>or', function() require('opencode').prompt('Review @this for correctness and readability') end, desc = 'opencode: Review', mode = { 'n', 'x' } },
      { 'go', function() return require('opencode').operator('@this ') end, desc = 'Add range to opencode', expr = true, mode = { 'n', 'x' } },
      { 'goo', function() return require('opencode').operator('@this ') .. '_' end, desc = 'Add line to opencode', expr = true },
      { '<C-.>', function() require('opencode').command('session.half.page.up') end, desc = 'Scroll opencode up', mode = { 'n', 't' } },
      { '<C-,>', function() require('opencode').command('session.half.page.down') end, desc = 'Scroll opencode down', mode = { 'n', 't' } },
    },
    -- snacks.nvim integration: input/picker
    config = function()
      require('snacks').setup({
        input = { enabled = true },
        picker = {
          enabled = true,
          actions = {
            -- 선택한 picker 항목(파일/grep 결과 등)을 opencode 컨텍스트로 전송. (<a-a>)
            opencode_send = function(picker)
              local items = vim.tbl_map(function(item)
                return item.file and require('opencode').format { path = item.file, from = item.pos, to = item.end_pos } or item.text
              end, picker:selected { fallback = true })
              require('opencode').prompt(table.concat(items, ', ') .. ' ')
            end,
          },
          win = { input = { keys = { ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } } } } },
        },
      })
    end,
  },

  -- NOTE(jinbei): gp.nvim — nvim 안에서 Gemini(googleai) 연동
  --   채팅(GpChatNew/Toggle/Finder) + 인라인 리라이트/추가/설명. API 키는 환경변수
  --   GOOGLEAI_API_KEY (셸 프로파일 export, 평문은 디스크 미경유). <leader>g prefix.
  --   기본 모델 gemini-2.5-flash (무료 티어 OK). 에이전트 전환은 :GpNextAgent. opencode 와는
  --   직접 연동 불가(opencode 서버는 OpenAI 비호환) — 같은 백엔드 공유만 가능.
  {
    'robitx/gp.nvim',
    -- lazy-load: gp 명령/키맵 트리거 시에만 로드 → 시작 오버헤드 0.
    cmd = {
      'GpChatNew', 'GpChatToggle', 'GpChatFinder', 'GpChatRespond',
      'GpRewrite', 'GpAppend', 'GpPrepend', 'GpExplain', 'GpImplement',
      'GpContext', 'GpNextAgent', 'GpAgent', 'GpStop', 'GpChatDelete',
      'GpNew', 'GpVnew', 'GpEnew', 'GpTabnew', 'GpPopup',
    },
    config = function()
      require('gp').setup {
        -- googleai 프로바이더만 키를 연결. (gp 기본 openai 등은 그대로 남지만 키 없어 미사용)
        providers = {
          googleai = {
            endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}',
            secret = os.getenv 'GOOGLEAI_API_KEY',
          },
        },
        -- Gemini 에이전트만 노출. gp 기본 OpenAI/Gemini 에이전트는 전부 비활성 →
        --   :GpNextAgent 순환이 아래 명시 에이전트로만 단순화됨.
        --   ⚠️ 무료 티어 주의: gemini-2.5-pro / gemini-2.0-flash 는 free tier 한도 0(=429).
        --      gemini-2.5-flash, gemini-2.5-flash-lite (및 *-latest) 만 무료로 응답함.
        --      유료(결제 등록) 전환 시 아래 GeminiPro 주석 해제하면 됨.
        agents = {
          { name = 'ChatGPT4o', disable = true },
          { name = 'ChatGPT4o-mini', disable = true },
          { name = 'ChatGPT-o3-mini', disable = true },
          { name = 'CodeGPT4o', disable = true },
          { name = 'CodeGPT4o-mini', disable = true },
          { name = 'CodeGPT-o3-mini', disable = true },
          { name = 'ChatGemini', disable = true },   -- gp 내장 Gemini 에이전트 숨김
          { name = 'CodeGemini', disable = true },
          {
            name = 'Gemini', provider = 'googleai', chat = true, command = true,
            model = { model = 'gemini-2.5-flash', temperature = 0.7, top_p = 1 },
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
          {
            name = 'GeminiFlashLite', provider = 'googleai', chat = true, command = true,
            model = { model = 'gemini-2.5-flash-lite', temperature = 0.7, top_p = 1 },
            system_prompt = require('gp.defaults').code_system_prompt,
          },
          -- 유료 전환 시 해제:
          -- {
          --   name = 'GeminiPro', provider = 'googleai', chat = true, command = true,
          --   model = { model = 'gemini-2.5-pro', temperature = 0.7, top_p = 1 },
          --   system_prompt = require('gp.defaults').chat_system_prompt,
          -- },
        },
        default_chat_agent = 'Gemini',
        default_command_agent = 'Gemini',
        hooks = {
          -- :GpExplain — 선택 코드를 팝업으로 설명 (gp 기본 예시 hook, 버퍼 미수정)
          Explain = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please respond by explaining the code above.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
          end,
          -- :GpPopup — 자유 질문 입력 → 팝업창에 답변(새 버퍼 안 엶). 순수 질의(선택영역 미포함).
          Popup = function(gp, params)
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, '{{command}}', 'Ask Gemini (popup): ')
          end,
        },
      }
    end,
    keys = {
      { '<leader>g', nil, desc = 'AI/Gemini' },
      { '<leader>gc', '<cmd>GpChatNew<cr>', desc = 'New Gemini chat', mode = { 'n', 'x' } },
      { '<leader>gt', '<cmd>GpChatToggle<cr>', desc = 'Toggle Gemini chat' },
      { '<leader>gf', '<cmd>GpChatFinder<cr>', desc = 'Find Gemini chats' },
      { '<leader>gd', '<cmd>GpChatDelete<cr>', desc = 'Delete Gemini chat' },
      { '<leader>gr', '<cmd>GpRewrite<cr>', desc = 'Gemini rewrite', mode = { 'n', 'x' } },
      { '<leader>ga', '<cmd>GpAppend<cr>', desc = 'Gemini append', mode = { 'n', 'x' } },
      { '<leader>gp', '<cmd>GpPrepend<cr>', desc = 'Gemini prepend', mode = { 'n', 'x' } },
      { '<leader>ge', '<cmd>GpExplain<cr>', desc = 'Gemini explain', mode = { 'n', 'x' } },
      { '<leader>gq', '<cmd>GpPopup<cr>', desc = 'Gemini ask (popup)', mode = { 'n', 'x' } },
      { '<leader>gn', '<cmd>GpNextAgent<cr>', desc = 'Next Gemini agent' },
      { '<leader>gs', '<cmd>GpStop<cr>', desc = 'Stop Gemini' },
    },
  },

  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, { ---@diagnostic disable-line: missing-fields
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
