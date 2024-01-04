local M = {}

function M.split(path)
    local head, tail, ext = string.match(path, '(.-)([^\\/]-%.?([^%.\\/]*))$')
    return {
        head = head,
        tail = tail,
        ext = ext,
    }
end

function M.basedir(path)
    local b = string.match(path, '(.-)[^\\/]-%.?[^%.\\/]*[\\/]?$')
    if b == '' then
        return nil
    end
    return b
end

function M.exists(filename)
    local stat = vim.loop.fs_stat(filename)
    return stat and stat.type or false
end

function M.is_dir(filename)
    return M.exists(filename) == 'directory'
end

function M.is_file(filename)
    return M.exists(filename) == 'file'
end

function M.iterate_parents(path)
    local c = path
    local is_start_dir = M.is_dir(path)
    return function()
        if is_start_dir then
            is_start_dir = false
            return path
        end
        c = M.basedir(c)
        if c ~= nil then
            return c
        end
    end
end

return M
