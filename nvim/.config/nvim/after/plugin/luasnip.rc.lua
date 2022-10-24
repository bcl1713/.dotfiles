local status, ls = pcall(require, "luasnip")
if (not status) then
  print "luasnip not installed"
  return
end

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local l = require("luasnip.extras").lambda

local function get_prop_names(id_node)
	local object_type_node = id_node:child(2)
	if object_type_node:type() ~= "object_type" then
		return {}
	end

	local prop_names = {}

	for prop_signature in object_type_node:iter_children() do
		if prop_signature:type() == "property_signature" then
			local prop_iden = prop_signature:child(0)
			local prop_name = vim.treesitter.query.get_node_text(prop_iden, 0)
			prop_names[#prop_names + 1] = prop_name
		end
	end

	return prop_names
end

ls.add_snippets("typescriptreact", {
	s(
		"us",
		{
			t("const ["),
			i(1, "value"),
			t(", set"),
			l(l._1:sub(1,1):upper() .. l._1:sub(2,-1), {1}),
			t("] = useState("),
			i(2, "initialValue"),
			t(")"),
		}
	),
	s(
		"rfc",
		fmt(
			[[
{}interface {}Props {{
  {}
}}
{}function {}({{{}}}: {}Props) {{
  return (
		{}
	)
}}
]],
			{
				i(1, "export "),

                                -- Initialize component name to file name 
				d(2, function(_, snip)
					return sn(nil, {
						i(1, vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")),
					})
				end, { 1 }),
				i(3, "// props"),
				rep(1),
				rep(2),
				f(function(_, snip, _)
					local pos_begin = snip.nodes[6].mark:pos_begin()
					local pos_end = snip.nodes[6].mark:pos_end()
					local parser = vim.treesitter.get_parser(0, "tsx")
					local tstree = parser:parse()

					local node = tstree[1]
						:root()
						:named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

					while node ~= nil and node:type() ~= "interface_declaration" do
						node = node:parent()
					end

					if node == nil then
						return ""
					end

					-- `node` is now surely of type "interface_declaration"
					local prop_names = get_prop_names(node)

					-- Does this lua->vimscript->lua thing cause a slow down? Dunno.
					return vim.fn.join(prop_names, ", ")
				end, { 3 }),
				rep(2),
				i(0, "{/* TODO - Implementation */}")
			}
		)
	),
})

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<TAB>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<TAB>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<s-TAB>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<s-TAB>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.rc.lua<CR>", {})
