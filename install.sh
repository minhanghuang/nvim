#!/bin/bash

echo "install git plug"


clangd_mac=clangd-mac-15.0.6.zip
clangd_linux=clangd-linux-15.0.6.zip
clangd_mac_download_url=https://github.com/clangd/clangd/releases/download/15.0.6/$clangd_mac
clangd_linux_download_url=https://github.com/clangd/clangd/releases/download/15.0.6/$clangd_linux
clangd_install_path=~/.config/coc/extensions/coc-clangd-data/install/15.0.6
clangd_download_path=~/.config/coc/extensions/coc-clangd-data/download/

function directory_or_file_exists() {
  path=$1
  if [ -e $path ]
  then
    return
  else
    return 1
  fi
  return 1
}

function system_type() {
  local os_type=`uname  -a`
  if [[ $os_type =~ 'Darwin' ]];then
    echo "Mac"
  elif [[ $os_type =~ 'Linux' ]];then
    echo "Linux"
  else
    echo "other"
  fi
}

function install_plugin() {
  echo "install vim plugin."
  # ## plug 管理工具 
  git clone git@github.com:rktjmp/lush.nvim.git ~/.config/nvim/plugged
  # ## 主题
  git clone git@github.com:ellisonleao/gruvbox.nvim.git ~/.config/nvim/plugged/gruvbox.nvim
  git clone git@github.com:kyazdani42/nvim-web-devicons.git ~/.config/nvim/plugged/nvim-web-devicons
  # ## 文件树
  git clone git@github.com:nvim-tree/nvim-tree.lua.git ~/.config/nvim/plugged/nvim-tree.lua
  # ## 窗口tag
  git clone git@github.com:akinsho/bufferline.nvim.git ~/.config/nvim/plugged/bufferline.nvim
  git clone git@github.com:famiu/bufdelete.nvim.git ~/.config/nvim/plugged/bufdelete.nvim
  cd ~/.config/nvim/plugged/bufdelete.nvim && git checkout 46255e4a76c4fb450a94885527f5e58a7d96983c
  git clone git@github.com:windwp/windline.nvim.git ~/.config/nvim/plugged/windline.nvim
  git clone git@github.com:lewis6991/gitsigns.nvim.git ~/.config/nvim/plugged/gitsigns.nvim
  # ## 跳转
  git clone git@github.com:neoclide/coc.nvim.git ~/.config/nvim/plugged/coc.nvim
  # ## cd ~/.config/nvim/plugged/coc.nvim && git checkout v0.0.81
  cd ~/.config/nvim/plugged/coc.nvim && git checkout release
  # ## 彩虹括号 
  git clone git@github.com:luochen1990/rainbow.git ~/.config/nvim/plugged/rainbow
  git clone git@github.com:jiangmiao/auto-pairs.git ~/.config/nvim/plugged/auto-pairs
  git clone git@github.com:junegunn/fzf.git  ~/.fzf
  cd ~/.fzf && ./install --all
  git clone git@github.com:nvim-telescope/telescope.nvim.git ~/.config/nvim/plugged/telescope.nvim
  git clone git@github.com:nvim-lua/plenary.nvim.git ~/.config/nvim/plugged/plenary.nvim
  git clone git@github.com:BurntSushi/ripgrep.git ~/.config/nvim/plugged/ripgrep
  git clone git@github.com:sharkdp/fd.git ~/.config/nvim/plugged/fd
  git clone git@github.com:kevinhwang91/nvim-hlslens.git ~/.config/nvim/plugged/nvim-hlslens
  cd ~/.config/nvim/plugged/coc.nvim && git checkout 1b629c0c28c4c5aa7923043e00a9e388b0ad937a
  # ## 最近打开文件
  git clone git@github.com:mhinz/vim-startify.git ~/.config/nvim/plugged/vim-startify
  # ## terminal
  git clone git@github.com:voldikss/vim-floaterm.git ~/.config/nvim/plugged/vim-floaterm
  # ## markdown
  git clone git@github.com:iamcco/markdown-preview.nvim.git ~/.config/nvim/plugged/markdown-preview.nvim
  cd ~/.config/nvim/plugged/markdown-preview.nvim/app && yarn install
  # ## 代码块(引擎+代码块集合)
  git clone git@github.com:honza/vim-snippets.git ~/.config/nvim/plugged/vim-snippets
  git clone git@github.com:SirVer/ultisnips.git ~/.config/nvim/plugged/ultisnips
  # ## 注释
  git clone git@github.com:tpope/vim-commentary.git ~/.config/nvim/plugged/vim-commentary
  # ## preservim/tagbar
  git clone git@github.com:preservim/tagbar.git ~/.config/nvim/plugged/tagbar
  # ## 显示tab缩进 
  git clone git@github.com:lukas-reineke/indent-blankline.nvim.git ~/.config/nvim/plugged/indent-blankline.nvim
  # ## 缓存当前光标信息
  git clone git@github.com:ethanholz/nvim-lastplace.git ~/.config/nvim/plugged/nvim-lastplace
  # ## 语法高亮 
  git clone git@github.com:nvim-treesitter/nvim-treesitter.git ~/.config/nvim/plugged/nvim-treesitter
  # ## 括号
  git clone git@github.com:haringsrob/nvim_context_vt.git ~/.config/nvim/plugged/nvim_context_vt
  # ## debugger
  git clone git@github.com:mfussenegger/nvim-dap.git ~/.config/nvim/plugged/nvim-dap
  cd ~/.config/nvim/plugged/nvim-dap && git checkout f4a3be57f61893cffa1e22aa5e1e7bded495fcf2
  git clone git@github.com:theHamsta/nvim-dap-virtual-text.git ~/.config/nvim/plugged/nvim-dap-virtual-text
  cd ~/.config/nvim/plugged/nvim-dap-virtual-text && git checkout a36982259216afd710f55bcdc220477c74b5bc35
  git clone git@github.com:rcarriga/nvim-dap-ui.git ~/.config/nvim/plugged/nvim-dap-ui
  # cd ~/.config/nvim/plugged/nvim-dap-ui && git checkout b0bc932ce6ca57bdec5536d773ab643e5b2f57ad
  # ## NeoVim 加速
  git clone git@github.com:nathom/filetype.nvim.git ~/.config/nvim/plugged/filetype.nvim
  git clone git@github.com:folke/which-key.nvim.git ~/.config/nvim/plugged/which-key.nvim
  git clone git@github.com:nvim-pack/nvim-spectre.git ~/.config/nvim/plugged/nvim-spectre
  git clone git@github.com:folke/todo-comments.nvim.git ~/.config/nvim/plugged/todo-comments.nvim
  git clone git@github.com:MattesGroeger/vim-bookmarks.git ~/.config/nvim/plugged/vim-bookmarks
  git clone git@github.com:sindrets/diffview.nvim.git ~/.config/nvim/plugged/diffview.nvim
  git clone git@github.com:Pocco81/auto-save.nvim.git ~/.config/nvim/plugged/auto-save.nvim
  # ## 断点持久化
  git clone git@github.com:Weissle/persistent-breakpoints.nvim.git ~/.config/nvim/plugged/persistent-breakpoints.nvim
  # ## sudo file
  git clone git@github.com:lambdalisue/suda.vim.git ~/.config/nvim/plugged/suda.vim
  # ## ssh copy
  git clone git@github.com:ojroques/vim-oscyank.git ~/.config/nvim/plugged/vim-oscyank
  git clone git@github.com:danymat/neogen.git ~/.config/nvim/plugged/neogen
}

function install_python_libs() {
  echo "install python library."
  python3 -m pip install debugpy autopep8 cmakelang neovim
}

function install_coc_clangd() {
  echo "install coc.nvim clangd."
  type=$(system_type)
  case $type in
    "Mac")
      # 判断文件是否存在
      $(directory_or_file_exists $clangd_download_path$clangd_mac)
      if [ $? == 0 ]
      then
        echo "$clangd_mac : 文件存在"
      else
        echo "$clangd_mac : 文件不存在"
        wget $clangd_mac_download_url -P $clangd_download_path
      fi
      # 判断clangd是否存在
      $(directory_or_file_exists $clangd_install_path)
      if [ $? == 0 ]
      then
        echo "$clangd_install_path : 路径存在, 删除"
        rm -rf $clangd_install_path
      else
        echo "$clangd_install_path: 文件不存在, 创建"
        mkdir -p $clangd_install_path
      fi
      echo "解压: $clangd_download_path$clangd_mac ->>>> $clangd_install_path"
      unzip -d $clangd_install_path $clangd_download_path$clangd_mac
      ;;
    "Linux")
      # 判断文件是否存在
      $(directory_or_file_exists $clangd_download_path$clangd_linux)
      if [ $? == 0 ]
      then
        echo "$clangd_linux : 文件存在"
      else
        echo "$clangd_linux : 文件不存在"
        wget $clangd_linux_download_url -P $clangd_download_path
      fi
      # 判断clangd是否存在
      $(directory_or_file_exists $clangd_install_path)
      if [ $? == 0 ]
      then
        echo "$clangd_install_path : 路径存在, 删除"
        rm -rf $clangd_install_path
      else
        echo "$clangd_install_path: 文件不存在, 创建"
        mkdir -p $clangd_install_path
      fi
      echo "解压: $clangd_download_path$clangd_linux ->>>> $clangd_install_path"
      unzip -d $clangd_install_path $clangd_download_path$clangd_linux
      ;;
    "other")
      echo "other"
      ;;
    *)
      echo "error"
      exit 8
    esac
}

function install_depandency() {
  echo "install depandency."
  type=$(system_type)
  case $type in
    "Mac")
      brew tap universal-ctags/universal-ctags
      brew install --HEAD universal-ctags
      brew install ripgrep gnu-sed llvm tig
      ;;
    "Linux")
      sudo dpkg -i ~/.config/nvim/data/ripgrep_0.10.0_amd64.deb
      sudo apt install -y ctags python3-venv llvm tig
      ;;
    "other")
      echo "other"
      ;;
    *)
      echo "error"
      exit 8
    esac
}

function install_dap() {
  echo "download dap."
  type=$(system_type)
  download_url=""
  download_path=~/.config/nvim/data/debug/
  codelldb_tar=~/.config/nvim/data/debug/
  codelldb_path=~/.config/nvim/data/debug/tools/
  case $type in
    "Mac")
      download_url=https://github.com/vadimcn/vscode-lldb/releases/download/v1.7.0/codelldb-x86_64-darwin.vsix
      codelldb_tar+=codelldb-x86_64-darwin.vsix
      ;;
    "Linux")
      download_url=https://github.com/vadimcn/vscode-lldb/releases/download/v1.7.0/codelldb-x86_64-linux.vsix
      codelldb_tar+=codelldb-x86_64-linux.vsix
      ;;
    "other")
      echo "other"
      ;;
    *)
      echo "error"
      exit 8
    esac
  echo $download_url

  # 判断dap压缩包是否已经存在
  if [ -f "$codelldb_tar" ]; then
    echo "$codelldb_tar : exist"
  else
    echo "$codelldb_tar : dose not exist"
    mkdir -p $download_path
    wget $download_url -P $download_path
  fi
  
  # 判断是否已经解压dap
  if [ -d "$codelldb_path" ]; then
    echo "$codelldb_path exist"
    rm -rf $codelldb_path
  else
    echo "$codelldb_path dose not exist"
    mkdir -p $codelldb_path
  fi
  unzip -d $codelldb_path $codelldb_tar # 解压
}

function main() {
  install_plugin
  install_python_libs
  install_depandency
  install_coc_clangd
  install_dap
  return
}

main "$@"

