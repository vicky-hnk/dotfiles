-- lua/lsp/init.lua (Neovim 0.11+)
local module = {}

-- Toggle Python type servers here (Ruff is always enabled below)
local python_lsps = {
  pyright = true,
  basedpyright = false,
  ty = false,
  pyrefly = false,
}

local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  return capabilities
end

-- Run Ruff formatter for the current buffer (non-blocking)
local function ruff_format_buf(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  if file == "" then return end

  -- Prefer local venv / project toolchain if you use one; fallback to PATH
  if vim.fn.executable("ruff") ~= 1 then
    vim.notify("ruff not found in PATH", vim.log.levels.WARN)
    return
  end

  vim.system({ "ruff", "format", file }, { text = true }, function(res)
    if res.code ~= 0 then
      local msg = (res.stderr and res.stderr ~= "") and res.stderr or "ruff format failed"
      vim.schedule(function()
        vim.notify(msg, vim.log.levels.ERROR)
      end)
      return
    end

    -- Reload file if it changed on disk
    vim.schedule(function()
      -- Preserve cursor/view as best as possible
      local view = vim.fn.winsaveview()
      vim.cmd("checktime") -- detect file changes
      vim.cmd("edit!")     -- reload
      vim.fn.winrestview(view)
    end)
  end)
end

local function setup_lsp_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client_id = args.data and args.data.client_id
      if not client_id then return end
      local client = vim.lsp.get_client_by_id(client_id)
      if not client then return end

      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
      end

      -- Core LSP keymaps
      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gr", vim.lsp.buf.references)
      map("n", "K", vim.lsp.buf.hover)
      map("n", "<leader>rn", vim.lsp.buf.rename)
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)

      -- Formatting strategy:
      -- - Python: always use `ruff format` (deterministic; avoids LSP formatter conflicts)
      -- - Other filetypes: use LSP formatting (async)
      map("n", "<leader>f", function()
        if vim.bo[bufnr].filetype == "python" then
          ruff_format_buf(bufnr)
        else
          vim.lsp.buf.format({ async = true })
        end
      end)

      -- Python policy: keep Ruff + type server(s), but avoid formatting conflicts.
      -- Disable LSP formatting for ALL Python clients (we format via Ruff CLI).
      if vim.bo[bufnr].filetype == "python" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end,
  })
end

local function configure_servers(capabilities)
  -- Default for all servers
  vim.lsp.config("*", { capabilities = capabilities })

  -- Ruff: diagnostics + code actions (formatting via CLI in this setup)
  vim.lsp.config("ruff", {
    init_options = {
      settings = {
        configurationPreference = "filesystemFirst",
      },
    },
  })

  -- Pyright: types/intel. Reduce overlap with Ruff if desired.
  vim.lsp.config("pyright", {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          -- Optional: let Ruff handle these to reduce noise
          diagnosticSeverityOverrides = {
            reportUnusedImport = "none",
            reportUnusedVariable = "none",
          },
        },
      },
    },
  })

  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          typeCheckingMode = "off",
          autoImportCompletions = true,
        },
      },
    },
  })

  vim.lsp.config("ty", {
    settings = {
      ty = {
        diagnosticMode = "workspace",
        experimental = {
          rename = true,
          autoImport = true,
        },
      },
    },
  })

  vim.lsp.config("pyrefly", {
    settings = {
      python = {
        pyrefly = {
          displayTypeErrors = "force-on",
        },
        analysis = {
          diagnosticMode = "workspace",
          inlayHints = {
            callArgumentNames = "all",
            variableTypes = true,
            functionReturnTypes = true,
            pytestParameters = true,
          },
        },
      },
    },
  })

  -- TypeScript / JavaScript
  vim.lsp.config("ts_ls", {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  })

  -- JSON schemas via schemastore.nvim
  vim.lsp.config("jsonls", {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas({ validate = { enable = true } }),
        validate = { enable = true },
      },
    },
  })

  -- YAML + CloudFormation
  vim.lsp.config("yamlls", {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" },
        schemas = require("schemastore").yaml.schemas({
          validate = { enable = true },
          extra = {
            {
              name = "CloudFormation",
              description = "CloudFormation Template",
              fileMatch = { "*.template.y*ml", "*-template.y*ml", "template.y*ml" },
              url = "https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json",
            },
          },
        }),
        customTags = {
          "!And scalar",
          "!If scalar",
          "!Not",
          "!Equals scalar",
          "!Or scalar",
          "!FindInMap scalar",
          "!Base64",
          "!Cidr",
          "!Ref",
          "!Sub",
          "!GetAtt sequence",
          "!GetAZs",
          "!ImportValue sequence",
          "!Select sequence",
          "!Split sequence",
          "!Join sequence",
        },
      },
    },
  })
end

local function enable_servers()
  -- Always enable Ruff for Python
  vim.lsp.enable("ruff", true)

  -- Enable exactly the python servers you want (types/intel)
  for name, enabled in pairs(python_lsps) do
    vim.lsp.enable(name, enabled)
  end

  -- Others
  vim.lsp.enable("yamlls", true)
  vim.lsp.enable("jsonls", true)
  vim.lsp.enable("ts_ls", true)
end

function module.setup()
  setup_lsp_attach()

  local capabilities = get_capabilities()
  configure_servers(capabilities)
  enable_servers()
end

return module
