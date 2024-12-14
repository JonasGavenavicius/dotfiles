local M = {
    "SebastienLeonce/nvim-codeowners",
    build = "npm install",
}

M.config = {
    function ()
        require("codeowners").setup({
            codeownersFile = "CODEOWNERS",
            pattern =  "(@[%S]+)",
        })
    end
}

return M
