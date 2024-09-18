local M = {}

M.insert = function()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  return cmp.mapping.preset.insert {
    ["<C-e>"] = cmp.mapping.abort(),
    ["<M-j>"] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end),
    ["<M-k>"] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end),

    -- Scroll the documentation window [b]ack / [f]orward
    ["<M-u>"] = cmp.mapping(function(fallback)
      if cmp.visible_docs() then
        cmp.mapping.scroll_docs(-4)
      else
        fallback()
      end
    end),
    ["<M-d>"] = cmp.mapping(function(fallback)
      if cmp.visible_docs() then
        cmp.mapping.scroll_docs(4)
      else
        fallback()
      end
    end),
    ["<M-i>"] = cmp.mapping.confirm { select = true },
    -- Manually trigger a completion from nvim-cmp.
    --  Generally you don't need this, because nvim-cmp will display
    --  completions whenever it has completion options available.
    ["<M-c>"] = cmp.mapping.complete {},

    -- Think of <M-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <M-l> will move you to the right of each of the expansion locations.
    -- <M-h> is similar, except moving you backwards.
    ["<M-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<M-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  }
end

M.cmdline = function()
  return require("cmp").mapping.preset.cmdline {}
end

return M
