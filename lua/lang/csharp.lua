local Terminal = require('toggleterm.terminal').Terminal
local util = require('lspconfig.util')
local lsp_zero = require('lsp-zero')

local function find_csharp_sln(root_dir)
    local find_command = { 'rg', '--files', '--color', 'never', '-g', '*.sln', '--max-depth', '1' }
    local obj = vim.system(find_command, { cwd = root_dir }):wait()
    local files = vim.fn.split(obj.stdout, '\n')

    if #files == 1 then
        return files[1]
    end

    local coro = assert(coroutine.running())

    vim.ui.select(files, {
        prompt = 'Multiple solutions were found, please select below',
    }, function(choice)
        coroutine.resume(coro, choice)
    end)

    return coroutine.yield()
end

local function find_csharp_project(start_path)
    local found = vim.fn.glob(util.path.join(start_path, '*.csproj'))
    if util.path.is_file(found) then
        return found
    end
    local guard = 100
    for path in util.path.iterate_parents(start_path) do
        -- Prevent infinite recursion if our algorithm breaks
        guard = guard - 1
        if guard == 0 then
            return
        end

        found = vim.fn.glob(util.path.join(path, '*.csproj'))
        if util.path.is_file(found) then
            return found
        end
    end
end

local csharp_sln_by_root = {}
local function get_csharp_sln(root_dir)
    -- Check if we already loaded a solution for this root dir
    if csharp_sln_by_root[root_dir] ~= nil then
        return csharp_sln_by_root[root_dir]
    end

    -- Find the solution and update the table
    local sln = find_csharp_sln(root_dir)
    csharp_sln_by_root[root_dir] = sln

    return sln
end

-- Set up csharp_ls
lsp_zero.use('csharp_ls', {
    root_dir = util.root_pattern('*.sln'),
    on_new_config = function(config, root_dir)
        local sln = get_csharp_sln(root_dir)
        if sln ~= nil then
            config.cmd = { 'csharp-ls', '-s', sln }
            config.solution = util.path.join(root_dir, sln)
            config.project = find_csharp_project(vim.fn.expand('%:p:h'))
        end
    end,
    on_attach = function(client, bufnr)
        local opts = {
            direction = 'horizontal',
            auto_scroll = true,
            close_on_exit = false,
            on_open = function(term)
                vim.keymap.set('n', 'q', '<cmd>close<CR>', { noremap = true, silent = true, buffer = term.bufnr })
            end,
        }
        local cmd = {
            'msbuild',
            '-m', -- Use multiple parallel processes
            '-restore', -- Restore nuget packages
            '-p:nugetInteractive=true', -- Allows nuget to ask for authentication
            '-p:restorePackagesWithLockFile=true', -- Prevents warning when restoring a project with lockfile
            '-p:generateFullPaths=true', -- Prints the full path in errors
        }
        vim.api.nvim_buf_create_user_command(bufnr, 'CSharpReload', function()
            client.stop()
            vim.lsp.start(client.config)
        end, {})
        if client.config.solution ~= nil then
            vim.api.nvim_buf_create_user_command(bufnr, 'MSBuildSolution', function()
                Terminal:new(vim.tbl_extend('force', opts, {
                    cmd = table.concat(cmd, ' ') .. ' ' .. client.config.solution,
                })):open()
            end, {})
            vim.keymap.set('n', '<leader>bs', vim.cmd.MSBuildSolution, { desc = 'Build solution', buffer = bufnr })
        end
        if client.config.project ~= nil then
            vim.api.nvim_buf_create_user_command(bufnr, 'MSBuildProject', function()
                Terminal:new(vim.tbl_extend('force', opts, {
                    cmd = table.concat(cmd, ' ') .. ' ' .. client.config.project,
                })):open()
            end, {})
            vim.keymap.set('n', '<leader>bb', vim.cmd.MSBuildProject, { desc = 'Build project', buffer = bufnr })
        end
    end,
    handlers = {
        ['textDocument/definition'] = require('csharpls_extended').handler,
    },
})
