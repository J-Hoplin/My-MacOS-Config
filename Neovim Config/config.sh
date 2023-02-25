#!/bin/zsh

# Install neovim with brew
brew install neovim
# Install node.js
brew install node
brew install yarn
brew install universal-ctags
brew install llvm

echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc

# Require pip3
# For Coc-Python
pip3 install python-language-server==0.20.0
pip3 install --user pynvim
pip3 install pylint

# Install VIM-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim
# mkdir ~/.config/nvim
cat >> ~/.config/nvim/init.vim<<EOF
call plug#begin('~/.vim/plugged')

" tree explorer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" tag displayer
Plug 'preservim/tagbar'

Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim'

" Rainbow Bracket
Plug 'frazrepo/vim-rainbow'

call plug#end()

set encoding=utf-8

" Keymap
nmap <F4> :qa!
nmap <F5> gg=G
nmap <F6> :edit
nmap <F7> :e
nmap <F8> :TagbarToggle
nmap <F9> :NERDTreeToggle
nmap <F10> :terminal

let g:rainbow_active = 1
EOF

nvim -c ':PlugInstall' -c ':CocConfig'  -c ':q!' -c ':q!'

cat >> ~/.config/nvim/coc-settings.json<<EOF
{
  "languageserver": {
      "golang": {
            "command": "gopls",
            "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
            "filetypes": ["go"]
          },
      "ccls": {
            "command": "ccls",
            "filetypes": ["c", "cpp", "objc", "objcpp"],
            "rootPatterns": [".ccls", "compile_commands.json", ".vim/", ".git/", ".hg/"],
            "initializationOptions": {
                     "cache": {
                                "directory": "/tmp/ccls"
                              }
                   }
           },
      "python": {
         "command": "python",
         "args": [
              "-mpyls",
              "-vv",
              "--log-file",
              "/tmp/lsp_python.log"
            ],
         "trace.server": "verbose",
         "filetypes": [
              "python"
            ],
         "settings": {
              "pyls": {
                     "enable": true,
                     "trace": {
                              "server": "verbose"
                            },
                     "commandPath": "",
                     "configurationSources": [
                              "pycodestyle"
                            ],
                     "plugins": {
                              "jedi_completion": {
                                         "enabled": true
                                       },
                              "jedi_hover": {
                                         "enabled": true
                                       },
                              "jedi_references": {
                                         "enabled": true
                                       },
                              "jedi_signature_help": {
                                         "enabled": true
                                       },
                              "jedi_symbols": {
                                         "enabled": true,
                                         "all_scopes": true
                                       },
                              "mccabe": {
                                         "enabled": true,
                                         "threshold": 15
                                       },
                              "preload": {
                                         "enabled": true
                                       },
                              "pycodestyle": {
                                         "enabled": true
                                       },
                              "pydocstyle": {
                                         "enabled": false,
                                         "match": "(?!test_).*\\.py",
                                         "matchDir": "[^\\.].*"
                                       },
                              "pyflakes": {
                                         "enabled": true
                                       },
                              "rope_completion": {
                                         "enabled": true
                                       },
                              "yapf": {
                                         "enabled": true
                                      }
                           }
                  }
           }
      }
    }
}
EOF

cd ~/.vim/plugged/coc.nvim/
yarn install

nvim -c ':CocInstall -sync coc-pyright coc-tsserver coc-python coc-clangd coc-tabnine coc-json' -c ":q!" -c ":q!"