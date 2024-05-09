local M = {}

-- telescope
---@param builtin string
---@param opts telescope.opts
M.telescope = function(builtin, opts)
  require("telescope.builtin")[builtin](opts)
end

-- format
M.format_code = function()
  local file_type = vim.api.nvim_buf_get_option(0, 'filetype')
  -- 如果是下面这些文件, 使用第三方插件进行格式化
  if 'python' == file_type or 'vue' == file_type then
    -- vim.cmd('Neoformat') -- sbdchd/neoformat
    vim.cmd("FormatWrite") -- mhartington/formatter.nvim
  else
    -- 否则使用 LSP 的格式化
    vim.lsp.buf.format { async = true }
  end
end

-- Python
--- 获取当前环境的Python路径
M.get_python_path = function()
  local py_path = nil
  local venv_path = os.getenv('VIRTUAL_ENV')
  if venv_path ~= nil then
    py_path = venv_path .. "/bin/python3"
  else
    py_path = vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
  end
  return py_path
end

--- 获取Python版本
M.get_python_version = function()
  local python_version = vim.fn.system('python3 --version | awk \'{print $2}\' | cut -d "." -f 1-2')
  return string.gsub(python_version, "\n", "")
end

--- 获取Python虚拟环境名
M.get_python_venv_name = function()
  local virtualenv_path = os.getenv("VIRTUAL_ENV")
  -- 判断是否在虚拟环境中
  if virtualenv_path then
    -- 使用字符串处理函数提取环境名
    local _, _, virtualenv_name = string.find(virtualenv_path, "/([^/]+)$")

    if virtualenv_name then
      return virtualenv_name
    end
  end
  return ""
end

--- 获取所有Python版本的dist-packages site-packages路径
---@param root_path: Python安装路径
---@return dist-packages和site-packages绝对路径(/usr/local/lib/python2.7/dist-packages)
M.get_all_python_package_paths = function(root_path)
  local python_versions = vim.fn.systemlist('ls ' .. root_path .. ' | grep "^python"')

  local all_paths = {}

  for _, version in ipairs(python_versions) do
    local python_root = root_path .. '/' .. version
    local dist_packages = python_root .. '/dist-packages'
    local site_packages = python_root .. '/site-packages'

    -- 添加存在dist-packages
    if vim.fn.isdirectory(dist_packages) == 1 then
      table.insert(all_paths, dist_packages)
    end

    -- 添加存在site-packages
    if vim.fn.isdirectory(site_packages) == 1 then
      table.insert(all_paths, site_packages)
    end
  end

  return all_paths
end

--- 获取当前终端Python路径
---@return [path1, path2]
M.get_current_python_package_paths = function()
  -- 无法获取虚拟环境路径
  -- local current_python_path = vim.fn.getenv("PYTHONPATH")
  -- local split_paths = vim.fn.split(current_python_path, ":")

  local current_python_path = vim.fn.system('python3 -c "import sys; print(\':\'.join(sys.path))"')
  local split_paths = vim.fn.split(current_python_path, ':')


  -- 用冒号分割字符串
  local paths = {}
  for _, path in ipairs(split_paths) do
    if not vim.tbl_contains(paths, path) and '' ~= path then
      table.insert(paths, path)
    end
  end

  -- print(vim.inspect(paths))

  return paths
end

--- 定位文件所在位置
M.nvim_tree_find_file = function()
  local current_file = vim.fn.expand('%:p')
  if current_file:find(vim.fn.getcwd(), 1, true) == 1 then
    vim.cmd('NvimTreeFindFile')
    -- print('Current file is inside the project root directory.')
  else
    vim.cmd('NvimTreeFindFile!')
    -- print('Current file is outside the project root directory.')
  end
end

--- 跳转workspace
M.nvim_tree_goto_root = function()
  local api = require("nvim-tree.api")
  api.tree.change_root(vim.fn.getcwd())
end

return M
