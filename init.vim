" プラグイン
call plug#begin()

" nerdtree
Plug 'scrooloose/nerdtree'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" color
Plug 'dracula/vim'
Plug 'guns/xterm-color-table.vim'

" cpp highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" ale
" 問題があるので一旦のコメントアウト
" Plug 'dense-analysis/ale'

" チートシート
Plug 'reireias/vim-cheatsheet'

" windows リサイズ
Plug 'simeji/winresizer'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" text objects 操作系の拡張
Plug 'wellle/targets.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

call plug#end()

" 行数表示
set number

" シェル
set sh=zsh

" カレントディレクトリを自動で移動する
set autochdir

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


" coc関連
set hidden
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
" エラーが見づらいので背景カラーを変更
hi CocFloating ctermbg=18
hi CocErrorSign ctermfg=196

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silient><expr> <TAB>
	\ pumviviblee() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

" 補完トリガーキー
inoremap <silent><expr> <C-l> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"   

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" terminal
tnoremap <ESC> <C-\><C-n>

" nerdtree
let NERDTreeShowHidden=1
nmap <Leader>e :NERDTree<CR>
nmap <Leader>E :NERDTreeClose<CR>
nmap <leader>g :<C-u>exe('Gtags '.expand("<cword>"))<CR>
nmap <leader>r :<C-u>exe('Gtags -r '.expand("<cword>"))<CR>
nmap <leader><c-g> :Gtags -f %<CR>
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>

" fzf mapping
nmap <leader>f :Files<CR>
nmap <leader><c-f> :Files ~<CR>
nmap <leader>b :Buffers<CR>
nmap <leader><c-s> :BLines<CR>
nmap <leader><c-w> :Windows<CR>

" cpp highlight
" let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
" dracula theme
let g:dracula_italic = 0
autocmd ColorScheme * highlight Comment ctermfg=110
autocmd ColorScheme * highlight LineNr ctermfg=33


if wassy_utils#exists_colorscheme('dracula')
	colorscheme dracula
endif

if wassy_utils#exists_plugin('nvim-treesitter')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "clojure", "c_sharp", "graphql", "verilog", "ocamllex", "kotlin", "erlang", "fennel", "swift", "julia", "ocaml", "scala", "toml", "teal", "java", "dart", "nix", "tsx", "rst", "elm", "lua", "go", "ql",  "rust", "ruby", "vue" },  -- list of language that will be disabled
  },
}
EOF
endif
