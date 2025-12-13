local module = {}

--- Python LSP toggle
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

local function setup_keymaps()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
      end

      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gr", vim.lsp.buf.references)
      map("n", "K", vim.lsp.buf.hover)
      map("n", "<leader>rn", vim.lsp.buf.rename)
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
      map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
    end,
  })
end

local function prefer_ruff_formatting_for_python()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then return end

      -- Only apply this policy for Python buffers
      local ft = vim.bo[args.buf].filetype
      if ft ~= "python" then return end

      -- Disable formatting from *non-ruff* Python servers to avoid conflicts
      if client.name ~= "ruff" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end,
  })
end

local function configure_servers(capabilities)
  -- Default for all servers
  vim.lsp.config("*", { capabilities = capabilities })

  -- Ruff (lint + code actions; formatting depends on Ruff config)
  vim.lsp.config("ruff", {
    capabilities = capabilities,
    init_options = {
      settings = {
        configurationPreference = "filesystemFirst",
      },
    },
  })

  -- Python type-checkers / language servers (configure all; enable via table)
  vim.lsp.config("pyright", {
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  })

  vim.lsp.config("basedpyright", {
    capabilities = capabilities,
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
    capabilities = capabilities,
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
    capabilities = capabilities,
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
    capabilities = capabilities,
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
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas({ validate = { enable = true } }),
        validate = { enable = true },
      },
    },
  })

  -- YAML + CloudFormation
  vim.lsp.config("yamlls", {
    capabilities = capabilities,
    settings = {
      yaml = {
        schemaStore = { enable = false, url = "" }, -- use schemastore.nvim instead
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
  -- Always enable ruff
  vim.lsp.enable("ruff", true)

  -- Enable exactly the python servers wanted
  for name, enabled in pairs(python_lsps) do
    vim.lsp.enable(name, enabled)
  end

  vim.lsp.enable("yamlls", true)
  vim.lsp.enable("jsonls", true)
  vim.lsp.enable("ts_ls", true)
end

function module.setup()
  setup_keymaps()
  prefer_ruff_formatting_for_python()

  local capabilities = get_capabilities()
  configure_servers(capabilities)
  enable_servers()
end

return module
