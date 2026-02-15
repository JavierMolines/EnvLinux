return {
  {
    -- Formatter (conform.nvim)
    "stevearc/conform.nvim",
    ft = { "typescript", "typescriptreact", "json", "jsonc" },
    opts = function(_, opts)
      local util = require("lspconfig.util")
      local conform = require("conform")

      local function get_root()
        return util.root_pattern("biome.json", "package.json", ".git")(vim.fn.getcwd()) or vim.fn.getcwd()
      end

      local function get_biome()
        local root = get_root()
        local biome = root .. "/node_modules/.bin/biome"
        if vim.fn.executable(biome) == 1 then
          return biome
        end
        return nil
      end

      opts.formatters = opts.formatters or {}

      opts.formatters.biome = {
        command = get_biome,
        args = { "format", "--stdin-file-path", "$FILENAME" },
        stdin = true,
      }

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      })

      local group = vim.api.nvim_create_augroup("conform_biome_autofmt", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = group,
        callback = function(args)
          if vim.b.conform_skip_autoformat then
            vim.b.conform_skip_autoformat = false
            return
          end
          conform.format({ bufnr = args.buf, lsp_fallback = true })
        end,
      })

      return opts
    end,
  },
  {
    -- Linter (nvim-lint)
    "mfussenegger/nvim-lint",
    ft = { "typescript", "typescriptreact", "json", "jsonc" },
    config = function()
      local lint = require("lint")
      local util = require("lspconfig.util")

      local function get_root()
        return util.root_pattern("biome.json", "package.json", ".git")(vim.fn.getcwd()) or vim.fn.getcwd()
      end

      local function get_biome()
        local root = get_root()
        local biome = root .. "/node_modules/.bin/biome"
        if vim.fn.executable(biome) == 1 then
          return biome
        end
        return nil
      end

      local function notify_missing()
        LazyVim.notify("Biome no encontrado en node_modules/.bin", {
          title = "nvim-lint",
          level = vim.log.levels.WARN,
        })
      end

      lint.linters.biome = {
        cmd = get_biome,
        stdin = false,
        args = { "lint", "--reporter=json" },
        append_fname = true,
        ignore_exitcode = true,
        parser = function(output)
          if not output or output == "" then
            return {}
          end

          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or type(decoded) ~= "table" then
            return {}
          end

          local diagnostics = {}
          local function message_from_diag(diag)
            if type(diag.description) == "string" then
              return diag.description
            end
            if type(diag.message) == "string" then
              return diag.message
            end
            if type(diag.message) == "table" then
              local parts = {}
              for _, item in ipairs(diag.message) do
                if type(item) == "table" and type(item.content) == "string" then
                  table.insert(parts, item.content)
                end
              end
              if #parts > 0 then
                return table.concat(parts)
              end
            end
            return "Biome diagnostic"
          end

          local function normalize_json(value)
            if value == vim.NIL then
              return nil
            end
            return value
          end

          for _, diag in ipairs(decoded.diagnostics or {}) do
            local location = normalize_json(diag.location) or {}
            local span = normalize_json(location.span)
            if type(span) ~= "table" then
              span = { 0, 0 }
            end
            local start_pos = span[1] or 0
            local end_pos = span[2] or start_pos

            local source_code = normalize_json(location.sourceCode) or ""
            local lines = vim.split(source_code, "\n", { plain = true })
            local start_line = 1
            local start_col = 1
            local end_line = 1
            local end_col = 1

            if #lines > 0 then
              local acc = 0
              for i, line_text in ipairs(lines) do
                local next_acc = acc + #line_text + 1
                if start_pos >= acc and start_pos < next_acc then
                  start_line = i
                  start_col = start_pos - acc + 1
                end
                if end_pos >= acc and end_pos < next_acc then
                  end_line = i
                  end_col = end_pos - acc + 1
                  break
                end
                acc = next_acc
              end
            end

            local severity_map = {
              error = vim.diagnostic.severity.ERROR,
              warning = vim.diagnostic.severity.WARN,
              info = vim.diagnostic.severity.INFO,
              hint = vim.diagnostic.severity.HINT,
            }

            table.insert(diagnostics, {
              lnum = start_line - 1,
              col = start_col - 1,
              end_lnum = end_line - 1,
              end_col = end_col - 1,
              severity = severity_map[diag.severity] or vim.diagnostic.severity.WARN,
              message = message_from_diag(diag),
              code = diag.category,
              source = "biome",
            })
          end

          return diagnostics
        end,
      }

      lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      })

      local lint_timer = nil
      local function schedule_lint(buf)
        if lint_timer then
          vim.fn.timer_stop(lint_timer)
        end
        lint_timer = vim.fn.timer_start(1000, function()
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(buf) then
              return
            end
            local name = vim.api.nvim_buf_get_name(buf)
            if name == "" or vim.fn.filereadable(name) == 0 then
              return
            end
            if vim.bo[buf].modified then
              pcall(vim.api.nvim_buf_set_var, buf, "conform_skip_autoformat", true)
              vim.cmd("silent update")
              pcall(vim.api.nvim_buf_set_var, buf, "conform_skip_autoformat", false)
            end
            lint.try_lint()
          end)
        end)
      end

      vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
        callback = function(args)
          if not get_biome() then
            notify_missing()
            return
          end
          local buf = args.buf
          local name = vim.api.nvim_buf_get_name(buf)
          if name == "" or vim.fn.filereadable(name) == 0 then
            return
          end
          schedule_lint(buf)
        end,
      })
    end,
  },
}
