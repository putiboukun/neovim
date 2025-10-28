local vim = vim

-- Neotree
vim.keymap.set("n", "nn", ":Neotree toggle<cr>", { noremap = true, silent = true, desc = "Neotree Toggle" })
vim.keymap.set(
    "n",
    "no",
    ":Neotree reveal<cr>:Neotree ~/dotfiles/nvim/<cr>",
    { noremap = true, silent = true, desc = "Neotree reveal" }
)



vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })


vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })


--ここからターミナルの幅の話
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('botright 12split')
  local win   = vim.api.nvim_get_current_win()
  local start_height = 12
  vim.api.nvim_win_set_option(win, 'winfixheight', true)
  vim.cmd('terminal')
  vim.api.nvim_win_set_height(win, start_height)

  local bufnr = vim.api.nvim_get_current_buf()
  local group = vim.api.nvim_create_augroup('Term12_' .. bufnr, { clear = true })

  local function enforce()
    local w = vim.fn.bufwinid(bufnr)
    if w ~= -1 then
      pcall(vim.api.nvim_win_set_option, w, 'winfixheight', true)
      if vim.api.nvim_win_get_height(w) ~= start_height then
        pcall(vim.api.nvim_win_set_height, w, start_height)
      end
    end
  end

  vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'VimResized', 'WinScrolled' }, {
    group = group,
    buffer = bufnr,
    callback = enforce,
  })

  vim.api.nvim_create_autocmd({ 'BufWipeout', 'TermClose' }, {
    group = group,
    buffer = bufnr,
    callback = function()
      pcall(vim.api.nvim_del_augroup_by_id, group)
    end,
  })
end, { noremap = true, silent = true })
--ここまで
