" プラグイン
call plug#begin()

Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" 行数表示
set number

" tab
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:»\ ,extends:>

" エンコーディング
set fileencoding=utf-8
set encoding=utf-8

" バックアップファイルを出力しない
set nobackup

" undoファイルを出力しない
set noundofile

" Leaderキーの割当
let mapleader="\<Space>"

" nerdtree
let NERDTreeShowHidden=1
nmap <Leader>e :NERDTree<CR>
nmap <Leader>E :NERDTreeClose<CR>
nmap <leader>g :<C-u>exe('Gtags '.expand("<cword>"))<CR>
nmap <leader>r :<C-u>exe('Gtags -r '.expand("<cword>"))<CR>
nmap <leader>f :Gtags -f %<CR>
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>
