function! wassy_utils#exists_colorscheme(name) abort
	let path = a:name.'.vim'
	return !empty(findfile(path, $HOME."/.config/nvim/**"))
endfunction

function! wassy_utils#exists_plugin(name) abort
	return !empty(finddir(a:name, $HOME."/.config/nvim/**"))
endfunction
