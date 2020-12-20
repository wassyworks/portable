function! wassy_utils#exists_colorscheme(name) abort
	let path = a:name.".vim"
	return !empty(findfile(path, $HOME."/.config/nvim/**"))
endfunction


