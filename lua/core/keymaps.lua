local vim = vim

-- Neotree
vim.keymap.set("n", "nn", ":Neotree toggle<cr>", { noremap = true, silent = true, desc = "Neotree Toggle" })
vim.keymap.set(
    "n",
    "no",
    ":Neotree reveal<cr>:Neotree ~/dotfiles/nvim/<cr>",
    { noremap = true, silent = true, desc = "Neotree reveal" }
)


-- tab to terminal
vim.keymap.set('n', '<leader>t', ':botright 15split | terminal<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })


vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
