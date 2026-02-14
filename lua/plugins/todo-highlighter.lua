return {
  'user/todo-highlighter',
  config = function()
    local M = {}

    M.enabled = true
    M.matches = {}

    function M.define_highlights()
      vim.api.nvim_set_hl(0, 'TodoTodo', {
        bg = '#f1fa8c',
        fg = '#181825',
        ctermbg = 226,
        ctermfg = 235,
      })

      vim.api.nvim_set_hl(0, 'TodoFixme', {
        bg = '#fab387',
        fg = '#181825',
        ctermbg = 215,
        ctermfg = 235,
      })

      vim.api.nvim_set_hl(0, 'TodoNote', {
        bg = '#f9e2af',
        fg = '#181825',
        ctermbg = 229,
        ctermfg = 235,
      })
    end

    function M.add_matches()
      if not M.enabled then
        return
      end

      M.clear_matches()

      local patterns = {
        { pattern = '\\C\\%(//\\|#\\|--\\|/\\*\\|\\*/\\|/\\|"\\)\\s*TODO\\(:\\|\\s\\)', highlight = 'TodoTodo', priority = 10 },
        { pattern = '\\C\\%(//\\|#\\|--\\|/\\*\\|\\*/\\|/\\|"\\)\\s*FIXME\\(:\\|\\s\\)', highlight = 'TodoFixme', priority = 10 },
        { pattern = '\\C\\%(//\\|#\\|--\\|/\\*\\|\\*/\\|/\\|"\\)\\s*NOTE\\(:\\|\\s\\)', highlight = 'TodoNote', priority = 10 },
      }

      for _, item in ipairs(patterns) do
        local match_id = vim.fn.matchadd(item.highlight, item.pattern, item.priority)
        table.insert(M.matches, match_id)
      end
    end

    function M.clear_matches()
      for _, match_id in ipairs(M.matches) do
        if match_id ~= nil then
          pcall(vim.fn.matchdelete, match_id)
        end
      end
      M.matches = {}
    end

    function M.toggle()
      M.enabled = not M.enabled
      if M.enabled then
        M.add_matches()
        print('Todo highlighter enabled')
      else
        M.clear_matches()
        print('Todo highlighter disabled')
      end
    end

    function M.setup()
      M.define_highlights()

      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'BufEnter' }, {
        callback = function()
          M.add_matches()
        end,
      })

      vim.api.nvim_create_user_command('TodoHighlightToggle', function()
        M.toggle()
      end, { desc = 'Toggle TODO highlighter' })

      vim.api.nvim_create_user_command('TodoHighlightSetColors', function(opts)
        local args = opts.fargs
        if #args < 3 then
          print('Usage: :TodoHighlightSetColors <todo_color> <fixme_color> <note_color>')
          return
        end

        vim.api.nvim_set_hl(0, 'TodoTodo', { bg = args[1], fg = '#181825', ctermbg = 226, ctermfg = 235 })
        vim.api.nvim_set_hl(0, 'TodoFixme', { bg = args[2], fg = '#181825', ctermbg = 215, ctermfg = 235 })
        vim.api.nvim_set_hl(0, 'TodoNote', { bg = args[3], fg = '#181825', ctermbg = 229, ctermfg = 235 })

        print('Colors updated')
      end, { desc = 'Set custom highlight colors', nargs = '*' })

      vim.api.nvim_create_user_command('TodoHighlightAddKeyword', function(opts)
        local args = opts.fargs
        if #args < 2 then
          print('Usage: :TodoHighlightAddKeyword <keyword> <color>')
          return
        end

        local keyword = args[1]
        local color = args[2]
        local highlight_name = 'TodoCustom' .. keyword

        vim.api.nvim_set_hl(0, highlight_name, { bg = color, fg = '#181825', ctermbg = 226, ctermfg = 235 })
        local pattern = '\\C\\%(//\\|#\\|--\\|/\\*\\|\\*/\\|/\\|"\\)\\s*' .. keyword .. '\\(:\\|\\s\\)'
        local match_id = vim.fn.matchadd(highlight_name, pattern, 10)
        table.insert(M.matches, match_id)

        print('Added keyword: ' .. keyword)
      end, { desc = 'Add custom keyword highlight', nargs = '*' })

      M.add_matches()
    end

    M.setup()
  end,
}
