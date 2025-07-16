return {
  "yetone/avante.nvim",
  build = "make",  -- this builds avante_templates
  lazy = false,
  config = function()
    require("avante").setup({
      provider = "openai",
      openai = {
        api_key = os.getenv("AVANTE_OPENAI_API_KEY"),
        model = "gpt-4o",  -- or gpt-4-turbo / gpt-3.5-turbo
      },
      ui = {
        layout = "vertical",  -- or "horizontal", "float"
        width = 0.5,
      },
      system_prompt = "You are a brilliant programming assistant.",
      show_prompt = true,
      show_model = true,
    })
  end, 
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  }
}
