function! wassy_utils#exists_colorscheme(name) abort
	let path = 'color/'.a:name.'.vim'
	return !empty(globpath(&rtp, path))
endfunction
