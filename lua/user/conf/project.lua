local has_project, project = pcall(require, "project_nvim")
if not has_project then
  vim.notify("project_nvim not found!")
  return
end

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  vim.notify("telescope not found!")
  return
end

project.setup(
  {
    manual_mode = false,                                    -- 如果为true, 打开新的项目后, 不会显示项目的root
    patterns = { ".git", ".svn", "package.json", "build" }, -- 鉴别是否是project根目录, 录包含其中任何一个文件或目录，就会被识别为项目
    show_hidden = false,                                    -- 使用 Telescope 插件时是否显示隐藏文件
  }
)

telescope.load_extension('projects')
