return {
  { 'echasnovski/mini.nvim', version = false,
  config = function ()
  require('mini.comment').setup()
  require('mini.surround').setup()
  require('mini.bufremove').setup()
  
 
  end},
  {
  "echasnovski/mini.comment",
  opts = {
  mappings = {
  comment = "gj",
  comment_line = "gl",
  textobject = "gj",
  },
  },
  },
}
