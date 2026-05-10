-- Usamos vim.uv (libuv) para vigilar cambios en el sistema de archivos de forma nativa.
-- Esto detecta cambios externos sin importar quién escribió el archivo.

local function setup_watcher()
    local path = vim.fn.getcwd() .. "/compile_commands.json"
    local timer = vim.uv.new_timer()
    local watcher = vim.uv.new_fs_event()

    if not watcher then return end

    watcher:start(path, {}, vim.schedule_wrap(function(err, filename, events)
        if err then return end
        
        -- Evitamos reinicios múltiples en milisegundos (debouncing)
        if timer then
            timer:start(500, 0, vim.schedule_wrap(function()
                vim.notify("compile_commands.json cambió externamente. Reiniciando LSP...", vim.log.levels.INFO)
                vim.cmd("LspRestart")
            end))
        end
    end))
end

-- Solo inicializar si el archivo existe
if vim.fn.filereadable("compile_commands.json") == 1 then
    setup_watcher()
end
