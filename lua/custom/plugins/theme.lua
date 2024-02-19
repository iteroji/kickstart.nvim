return {
   {
      'iteroji/itero-nvim',
      config = function ()
         vim.cmd('colorscheme itero')
             vim.api.nvim_set_hl(0, 'MatchParen', {fg='#e6c764', bg='#4e432f'})

      end
   }
}

