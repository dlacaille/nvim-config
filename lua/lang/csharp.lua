local Terminal = require('toggleterm.terminal').Terminal
local Path = require('utils.path')
local lsp_util = require('lspconfig.util')
local lsp_zero = require('lsp-zero')

local function find_csharp_sln(root_dir, project)
    local find_command = {
        -- Utility used for searching
        'rg',
        -- List files only
        '-l',
        -- No colors
        '--color',
        'never',
        -- Search only *.sln files
        '-g',
        '*.sln',
        -- Search only the root directory
        '--max-depth',
        '1',
    }

    if project ~= nil then
        local project_tail = Path.split(project).tail
        -- Find solutions containing the project name
        table.insert(find_command, '-e')
        table.insert(find_command, project_tail)
    end

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

    local sln = coroutine.yield()
    if Path.is_file(sln) then
        return sln
    end
end

local function find_csharp_project(start_path)
    local found = vim.fn.glob(lsp_util.path.join(start_path, '*.csproj'))
    if lsp_util.path.is_file(found) then
        return found
    end
    local guard = 100
    for path in Path.iterate_parents(start_path) do
        -- Prevent infinite recursion if our algorithm breaks
        guard = guard - 1
        if guard == 0 then
            print('ERROR: infinite recursion')
            return
        end

        found = vim.fn.glob(lsp_util.path.join(path, '*.csproj'))
        if lsp_util.path.is_file(found) then
            return found
        end
    end
end

local csharp_sln_by_root = {}
local function get_csharp_sln(root_dir, project)
    -- Check if we already loaded a solution for this root dir
    if csharp_sln_by_root[root_dir] ~= nil then
        return csharp_sln_by_root[root_dir]
    end

    -- Find the solution and update the table
    local sln = find_csharp_sln(root_dir, project)
    csharp_sln_by_root[root_dir] = sln

    return lsp_util.path.join(root_dir, sln)
end

-- Set up csharp_ls
lsp_zero.use('csharp_ls', {
    root_dir = lsp_util.root_pattern('*.sln'),
    on_new_config = function(config, root_dir)
        config.project = find_csharp_project(vim.fn.expand('%:p:h'))
        config.solution = get_csharp_sln(root_dir, config.project)
        if config.solution ~= nil then
            config.cmd = { 'csharp-ls', '-s', config.solution }
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
            '-p:generateFullPaths=true', -- Prints the full path in errors
        }
        vim.api.nvim_buf_create_user_command(bufnr, 'MSReload', function()
            client.stop()
            vim.lsp.start(client.config)
        end, {})
        if client.config.solution ~= nil then
            vim.api.nvim_buf_create_user_command(bufnr, 'MSCleanSolution', function()
                Terminal
                    :new(vim.tbl_extend('force', opts, {
                        cmd = table.concat(cmd, ' ') .. '-t:Clean ' .. client.config.solution,
                    }))
                    :open()
            end, {})
            vim.keymap.set('n', '<leader>bC', vim.cmd.MSCleanSolution, { desc = 'Clean solution', buffer = bufnr })
            vim.api.nvim_buf_create_user_command(bufnr, 'MSRebuildSolution', function()
                Terminal
                    :new(vim.tbl_extend('force', opts, {
                        cmd = table.concat(cmd, ' ') .. '-t:Rebuild ' .. client.config.solution,
                    }))
                    :open()
            end, {})
            vim.keymap.set('n', '<leader>bR', vim.cmd.MSRebuildSolution, { desc = 'Rebuild solution', buffer = bufnr })
            vim.api.nvim_buf_create_user_command(bufnr, 'MSBuildSolution', function()
                Terminal:new(vim.tbl_extend('force', opts, {
                    cmd = table.concat(cmd, ' ') .. ' ' .. client.config.solution,
                })):open()
            end, {})
            vim.keymap.set('n', '<leader>bs', vim.cmd.MSBuildSolution, { desc = 'Build solution', buffer = bufnr })
        end
        if client.config.project ~= nil then
            vim.api.nvim_buf_create_user_command(bufnr, 'MSCleanProject', function()
                Terminal
                    :new(vim.tbl_extend('force', opts, {
                        cmd = table.concat(cmd, ' ') .. '-t:Clean ' .. client.config.project,
                    }))
                    :open()
            end, {})
            vim.keymap.set('n', '<leader>bc', vim.cmd.MSCleanProject, { desc = 'Clean project', buffer = bufnr })
            vim.api.nvim_buf_create_user_command(bufnr, 'MSRebuildProject', function()
                Terminal
                    :new(vim.tbl_extend('force', opts, {
                        cmd = table.concat(cmd, ' ') .. '-t:Rebuild ' .. client.config.project,
                    }))
                    :open()
            end, {})
            vim.keymap.set('n', '<leader>br', vim.cmd.MSRebuildProject, { desc = 'Rebuild project', buffer = bufnr })
            vim.api.nvim_buf_create_user_command(bufnr, 'MSBuildProject', function()
                Terminal:new(vim.tbl_extend('force', opts, {
                    cmd = table.concat(cmd, ' ') .. ' ' .. client.config.project,
                })):open()
            end, {})
            vim.keymap.set('n', '<leader>bp', vim.cmd.MSBuildProject, { desc = 'Build project', buffer = bufnr })
        end
    end,
    handlers = {
        ['textDocument/definition'] = require('csharpls_extended').handler,
    },
})
