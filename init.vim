" プラグイン
call plug#begin()

" nerdtree
Plug 'scrooloose/nerdtree'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ale
Plug 'dense-analysis/ale'

" チートシート
Plug 'reireias/vim-cheatsheet'

" windows リサイズ
Plug 'simeji/winresizer'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" text objects 操作系の拡張
Plug 'wellle/targets.vim'

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

" チートシート置き場
let g:cheatsheet#cheat_file = '~/.config/nvim/cheatsheet.md'

" Leaderキーの割当
let mapleader="\<Space>"

" リサイズ設定
let g:winresizer_start_key='<C-e>'
let g:winresizer_gui_enable=1
let g:winresizer_vert_resize=10
let g:winresizer_horiz_resize=3

" airline
" タブライン表示有効化
let g:airline#extensions#tabline#enabled=1

" nerdtree
let NERDTreeShowHidden=1
nmap <Leader>e :NERDTree<CR>
nmap <Leader>E :NERDTreeClose<CR>
nmap <leader>g :<C-u>exe('Gtags '.expand("<cword>"))<CR>
nmap <leader>r :<C-u>exe('Gtags -r '.expand("<cword>"))<CR>
nmap <leader>f :Gtags -f %<CR>
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>
