local map = vim.keymap.set
local buf_map = vim.api.nvim_buf_set_keymap
local diagnostic = vim.diagnostic
local otps = { noremap = true, silent = true }
local table_utils = require("utils.table-utils")
local merge = table_utils.merge

-- Modes
-- v: visual mode
-- i: insert mode
-- x: visual block mode
-- t: term mode
-- c: command mode

map("n", ";", ":")

-- better panes naviagation
map("n", "<C-l>", "<C-w>l", otps)
map("n", "<C-h>", "<C-w>h", otps)
map("n", "<C-k>", "<C-w>k", otps)
map("n", "<C-j>", "<C-w>j", otps)

-- better buffers navigation
map("n", "<leader>bn", ":bnext<CR>", otps)
map("n", "<leader>bp", ":bprevious<CR>", otps)
map("n", "<leader>x", ":bp|bd #<CR>", otps)
-- resize pane
map("n", "<C-Up>", ":resize +2<CR>", otps)
map("n", "<C-Down>", ":resize -2<CR>", otps)
map("n", "<C-Left>", ":vertical resize -2<CR>", otps)
map("n", "<C-Right>", ":vertical resize +2<CR>", otps)

-- stay indent
map("v", ">", ">gv", otps)
map("v", "<", "<gv", otps)

map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")
map({ "n", "v" }, "n", "nzzzv")
map({ "n", "v" }, "N", "Nzzzv")
map("v", "P", "_dP")

map("n", "<leader>ne", diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>pe", diagnostic.goto_prev, { desc = "Previous diagnostic" })

map("v", "<M-j>", ":m '>+1<CR>gv=gv", otps)
map("v", "<M-k>", ":m '<-2<CR>gv=gv", otps)
map("x", "J", ":m '>+1<CR>gv=gv", otps)
map("x", "K", ":m '<-2<CR>gv=gv", otps)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", otps)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", otps)

-- plugins keymaps --

-- kulala
buf_map(
	0,
	"n",
	"<leader>rr",
	"<cmd>lua require('kulala').run()<cr>",
	{ noremap = true, silent = true, desc = "Execute the request" }
)

-- customs
map("n", "<leader>ft", ":SelectThemes<CR>", merge({ desc = "Themes Picker" }, otps))
map("n", "<leader>hp", ":SelectHeaderImage<CR>", merge({ desc = "Header Image Picker" }, otps))

-- lsp
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", merge({ desc = "Hover information" }, otps))
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", merge({ desc = "Go to definition" }, otps))
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", merge({ desc = "Go to declaration" }, otps))
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", merge({ desc = "Go to implementation" }, otps))

-- telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", merge({ desc = "Find files" }, otps))
map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<CR>", merge({ desc = "Live grep" }, otps))
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", merge({ desc = "Find buffers" }, otps))
map(
	"n",
	"<leader>fh",
	"<cmd>lua require('telescope.builtin').help_tags()<CR>",
	merge({ desc = "Find help tags" }, otps)
)
map(
	"n",
	"<leader>fd",
	"<cmd>lua require('telescope.builtin').diagnostics()<CR>",
	merge({ desc = "Find diagnostics" }, otps)
)
map(
	"n",
	"<leader>fs",
	"<cmd>lua require('telescope.builtin').lsp_references()<CR>",
	merge({ desc = "Find references" }, otps)
)

-- neotree
map("n", "<leader>e", ":Neotree source=filesystem toggle left<CR>", otps)

-- tmux navigator
map({ "n", "v" }, "<C-j>", "<cmd> TmuxNavigateDown<CR>", otps)
map({ "n", "v" }, "<C-h>", "<cmd> TmuxNavigateLeft<CR>", otps)
map({ "n", "v" }, "<C-k>", "<cmd> TmuxNavigateUp<CR>", otps)
map({ "n", "v" }, "<C-l>", "<cmd> TmuxNavigateRight<CR>", otps)

-- toggle term
map(
	{ "n", "v" },
	"<leader>th",
	"<cmd> ToggleTerm direction=horizontal<CR>",
	merge({ desc = "Toggle horizontal terminal" }, otps)
)
map(
	{ "n", "v" },
	"<leader>tv",
	"<cmd> ToggleTerm direction=vertical<CR>",
	merge({ desc = "Toggle vertical terminal" }, otps)
)
map(
	{ "n", "v" },
	"<leader>tf",
	"<cmd> ToggleTerm direction=float<CR>",
	merge({ desc = "Toggle floating terminal" }, otps)
)

-- lazy git
map({ "n" }, "<leader>gg", "<cmd>LazyGit<CR>", merge({ desc = "Lazy git" }, otps))

-- todo
map({ "n", "v" }, "<leader>fn", ":TodoTelescope<CR>", merge({ desc = "Find all todos" }, otps))
map({ "n", "v" }, "<leader>fq", ":TodoQuickFix<CR>", merge({ desc = "Find quick fixes notes" }, otps))

-- render markdown
map({ "n", "v" }, "<leader>tm", ":RenderMarkdown toggle<CR>", merge({ desc = "Toggle markdown preview" }, otps))

-- comments
map(
	"n",
	"<leader>/c",
	":lua require('Comment.api').toggle.linewise.current()<CR>",
	merge({ desc = "[/] Toggle line comment" }, otps)
)
map(
	"v",
	"<leader>/c",
	":<C-u>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	merge({ desc = "[/] Toggle line comment on selection" }, otps)
)
map(
	"n",
	"<leader>/b",
	":lua require('Comment.api').toggle.blockwise.current()<CR>",
	merge({ desc = "[/] Toggle block comment" }, otps)
)
map(
	"v",
	"<leader>/b",
	":<C-u>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
	merge({ desc = "[/] Toggle block comment on selection" }, otps)
)
map("n", "<leader>/}", ":normal gca{<CR>", merge({ desc = "[/] Toggle comment around {}" }, otps))
map("n", "<leader>/i", ":normal gci{<CR>", merge({ desc = "[/] Toggle comment inside {}" }, otps))
map("n", "<leader>/p", ":normal gcip<CR>", merge({ desc = "[/] Toggle comment paragraph" }, otps))
map("n", "<leader>cb", ":normal gco<CR>", merge({ desc = "Insert comment below." }, otps))
map("n", "<leader>ca", ":normal gcO<CR>", merge({ desc = "Insert comment above." }, otps))
map("n", "<leader>ce", ":normal gcA<CR>", merge({ desc = "Insert comment at the end." }, otps))

-- ufo
map("n", "zR", require("ufo").openAllFolds, merge({ desc = "Open all folds" }, otps))
map("n", "zM", require("ufo").closeAllFolds, merge({ desc = "Close all folds" }, otps))
map("n", "zK", function()
	local windid = require("ufo").peekFoldedLinesUnderCursor()
	if not windid then
		vim.lsp.buf.hover()
	end
end, merge({ desc = "Peek fold" }, otps))
map("n", "+", "zo", merge({ desc = "Unfolds" }, otps))
map("n", "-", "zc", merge({ desc = "Folds" }, otps))

-- git conflicts
map({ "n", "v" }, "<leader>go", ":GitConflictChooseOurs<CR>", merge({ desc = "Choose ours" }, otps))
map({ "n", "v" }, "<leader>gt", ":GitConflictChooseTheirs<CR>", merge({ desc = "Choose theirs" }, otps))
map({ "n", "v" }, "<leader>gb", ":GitConflictChooseBoth<CR>", merge({ desc = "Choose both" }, otps))
map({ "n", "v" }, "<leader>g0", ":GitConflictChooseNone<CR>", merge({ desc = "Choose both" }, otps))
map({ "n", "v" }, "<leader>nc", ":GitConflictNextConflict<CR>", merge({ desc = "Go to next conflict" }, otps))
map({ "n", "v" }, "<leader>pc", ":GitConflictPrevConflict<CR>", merge({ desc = "Go to previous conflict" }, otps))
map({ "n", "v" }, "<leader>gcq", ":GitConflictListQf<CR>", merge({ desc = "Get all conflicts to quickfix list" }, otps))

-- auto session
map("n", "sr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
map("n", "ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

--harpoon

map("n", "<leader>m", function()
	require("harpoon"):list():add()
end, merge({ desc = "Add marks file to harpoon" }, otps))

map("n", "th", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, merge({ desc = "Harpoon Quick Menu" }, otps))

map("n", "<leader>1", function()
	require("harpoon"):list():select(1)
end)

map("n", "<leader>2", function()
	require("harpoon"):list():select(2)
end)

map("n", "<leader>3", function()
	require("harpoon"):list():select(3)
end)

map("n", "<leader>4", function()
	require("harpoon"):list():select(4)
end)

map("n", "<leader>5", function()
	require("harpoon"):list():select(5)
end)

map("n", "<leader>6", function()
	require("harpoon"):list():select(6)
end)

map("n", "<leader>7", function()
	require("harpoon"):list():select(7)
end)

map("n", "<leader>8", function()
	require("harpoon"):list():select(8)
end)

map("n", "<leader>9", function()
	require("harpoon"):list():select(9)
end)

map("n", "<S-h>", function()
	require("harpoon"):list():prev()
end)

map("n", "<S-l>", function()
	require("harpoon"):list():next()
end)
