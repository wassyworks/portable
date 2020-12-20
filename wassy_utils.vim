function! wassy_utils#exists_colorscheme(name) abort
	let path = a:name.".vim"
	return !exists(findfile(path, $HOME."/.config/nvim/**"))
endfunction


