let s:stamp = "coc_installed"
function! wassy_utils#exists_colorscheme(name) abort
	let path = a:name.".vim"
	return !empty(findfile(path, $HOME."/.config/nvim/**"))
endfunction

function! wassy_utils#exists_coc_extension() abort
	return !empty(findfile('coc_installed', $HOME."/.config"))
endfunction

function! wassy_utils#make_coc_extension_stamp() abort
	let path = $HOME."/.config/coc_installed"
	 call system("touch ".path)
endfunction


