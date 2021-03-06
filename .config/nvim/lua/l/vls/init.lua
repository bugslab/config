--- vls layer
-- @module l.vls

local autocmd = require("c.autocmd")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  autocmd.bind("BufRead,BufNewFile *.v", function()
      vim.bo.filetype = "vlang"
    end)

	lsp.register_server(nvim_lsp.vls, {
			cmd = {"vlang-server"},
		}
	)

end

return layer


