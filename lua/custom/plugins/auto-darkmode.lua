return {

  'f-person/auto-dark-mode.nvim',
  config = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.cmd('colorscheme kanagawa')
      vim.o.background = 'dark'
    end,
    set_light_mode = function()
      vim.cmd('colorscheme dayfox')
      vim.o.background = 'light'
    end,
  },
}
