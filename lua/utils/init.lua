local M = {}

function M.require_all(glob)
    local paths = vim.split(vim.fn.glob(vim.fn.stdpath('config') .. '/lua/' .. glob), '\n')
    for i, file in pairs(paths) do
        vim.cmd('source ' .. file)
    end
end

return M
