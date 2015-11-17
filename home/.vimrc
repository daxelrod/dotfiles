" Vundle and bundles configuration:
source ~/.bundles.vim

" Rest of config:

if (&t_Co == 256)
	colorscheme xoria256

	" vim-indent-guides
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_auto_colors = 0
	"hi IndentGuidesOdd ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a "StatusLineNC from xoria256
	hi IndentGuidesEven ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212 cterm=bold gui=bold "NonText from xoria256
endif

" indentation:
" For now, leave tabs as tabs
set ts=2
set sw=2

set title

"highlight whitespace at the ends of lines
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" I know it's blasphemous and I don't care :)
set mouse=a
set ttymouse=xterm2
