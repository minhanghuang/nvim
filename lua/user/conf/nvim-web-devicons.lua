local ok, web_devicons = pcall(require, "nvim-web-devicons")
if not ok then
  vim.notify("nvim-tree/nvim-web-devicons not found!")
  return
end

local my_icons = {
  ["inl"] = {
    icon = "",
    color = "#a074c4",
    cterm_color = "140",
    name = "Hpp"
  },
  ["urdf"] = {
    icon = "󰗀",
    color = "#e37933",
    cterm_color = "173",
    name = "Xml",
  },
  ["xodr"] = {
    icon = "󰗀",
    color = "#e37933",
    cterm_color = "173",
    name = "Xml",
  },
  ["launch"] = {
    icon = "󰗀",
    color = "#e37933",
    cterm_color = "173",
    name = "Xml",
  },
  ["rviz"] = {
    icon = "",
    color = "#6d8086",
    cterm_color = "66",
    name = "Yaml",
  },
}

if web_devicons.has_loaded then
  web_devicons.set_icon(my_icons)
else
  web_devicons.setup({ override = my_icons, default = true })
end
