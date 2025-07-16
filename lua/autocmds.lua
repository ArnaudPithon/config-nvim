local autocmd = vim.api.nvim_create_autocmd

-- Aller à la dernière position du curseur à l'ouverture
autocmd("BufReadPost", {
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd("normal! g`\"")
        end
    end
})

-- Mettre en valeur la fenêtre ayant le focus
autocmd("WinEnter", { callback = function() vim.opt_local.cursorline = true end })
autocmd("WinLeave", { callback = function() vim.opt_local.cursorline = false end })

-- Charger un template à la création d'un nouveau fichier
autocmd("BufNewFile", {
    pattern = "*",
    command = "silent! 0r ~/.config/nvim/templates/skeleton.%:e"
})

-- Appeler une fonction avant d'écrire un fichier (ex: LastModified)
-- À adapter en Lua si besoin
