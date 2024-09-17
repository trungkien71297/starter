require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local builtin = require "telescope.builtin"
map("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope Find references" })
map("n", "<leader>fic", builtin.lsp_incoming_calls, { desc = "Telescope Find incoming call" })
map("n", "<leader>foc", builtin.lsp_outgoing_calls, { desc = "Telescope Find outgoing call" })
map("n", "<leader>fsd", builtin.lsp_document_symbols, { desc = "Telescope Find document symbols" })
map("n", "<leader>fsw", builtin.lsp_workspace_symbols, { desc = "Telescope Find workspace symbols" })
map("n", "<leader>fsdw", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope Find dynamic workspace symbols" })
map("n", "<leader>fi", builtin.lsp_implementations, { desc = "Telescope Find implementations" })
map("n", "<leader>fd", builtin.lsp_definitions, { desc = "Telescope Find definitations" })
map("n", "<leader>ftd", builtin.lsp_type_definitions, { desc = "Telescope Find type definitations" })

map("n", "<leader>dd", builtin.diagnostics, { desc = "Diagnostics Telescope Diagnostics" })
map("n", "<leader>d[", vim.diagnostic.goto_prev, { desc = "Diagnostic Go to prev" })
map("n", "<leader>d]", vim.diagnostic.goto_next, { desc = "Diagnostic Go to next" })
map("n", "<leader>do", vim.diagnostic.open_float, { desc = "Diagnostic Open float" })
map("n", "<leader>dd", builtin.diagnostics, { desc = "Diagnostics Telescope Diagnostics" })
map("n", "<leader>dD", function()
  builtin.diagnostics {
    sort_by = "severity",
  }
end, { desc = "Diagnostics Telescope Diagnostics severity" })
map("n", "<leader>cz", vim.lsp.buf.code_action, { desc = "LSP Code action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP Code Rename" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
