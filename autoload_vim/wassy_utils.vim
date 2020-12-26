let s:stamp = "coc_installed"
function! wassy_utils#exists_colorscheme(name) abort
	let path = a:name.".vim"
	return !empty(findfile(path, $HOME."/.vim/**"))
endfunction

function! wassy_utils#plug_install() abort
	if empty(finddir('plugged', $HOME."/.vim/**"))
		PlugInstall
	endif
endfunction

function! wassy_utils#exists_coc_extension() abort
	if empty(finddir('coc.nvim', $HOME."/.vim/**"))
		return 1
	else
		return !empty(findfile('coc_installed', $HOME."/.vim"))
	endif
endfunction

function! wassy_utils#make_coc_extension_stamp() abort
	let path = $HOME."/.vim/coc_installed"
	call system("touch ".path)
endfunction


