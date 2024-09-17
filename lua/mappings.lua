require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>fr", function()
  require("telescope.builtin").lsp_references()
end, { desc = "Telescope Find references" })

-- Alternative: use native LSP references with 'gr'
map("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
map("n", "<leader>fic", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Telescope Find incoming call" })
map("n", "<leader>foc", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "Telescope Find outgoing call" })
map("n", "<leader>fsd", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Telescope Find document symbols" })
map("n", "<leader>fsw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Telescope Find workspace symbols" })
map(
  "n",
  "<leader>fsdw",
  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
  { desc = "Telescope Find dynamic workspace symbols" }
)
map("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Telescope Find implementations" })
map("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Telescope Find definitions" })
map("n", "<leader>ftd", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Telescope Find type definitions" })

map("n", "<leader>dd", "<cmd>Telescope diagnostics<cr>", { desc = "Telescope Diagnostics" })
map("n", "<leader>do", vim.diagnostic.open_float, { desc = "Diagnostic Open float" })
map(
  "n",
  "<leader>dD",
  "<cmd>Telescope diagnostics sort_by=severity<cr>",
  { desc = "Diagnostics Telescope by severity" }
)
map("n", "<leader>cz", vim.lsp.buf.code_action, { desc = "LSP Code action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP Code Rename" })
map(
  "n",
  "<leader>cd",
  ':lua print(vim.fn.expand("%:p:h"))<CR>',
  { noremap = true, silent = true, desc = "Print current file path" }
)

map("n", "<leader>r", function()
  local ok = pcall(vim.cmd, "Telescope flutter commands")
  if not ok then
    vim.notify("Telescope flutter extension is not available", vim.log.levels.WARN)
  end
end, { desc = "Open Flutter Telescope commands" })
map("n", "<leader>br", function()
  vim.cmd "20new"
  vim.cmd "te fvm flutter packages pub run build_runner build --delete-conflicting-outputs"
  vim.cmd "2sleep | normal G"
end, { desc = "Run build_runner" })
-- '<Cmd>20new | te fvm flutter pub get && fvm flutter packages pub run build_runner build --delete-conflicting-outputs<CR> | $')
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
