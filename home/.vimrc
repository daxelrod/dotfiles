" Vundle and bundles configuration:
source ~/.bundles.vim

" Rest of config:

syntax on " Not sure why this is needed in my custom built vim 7.3 only

if (&t_Co == 256)
	colorscheme xoria256

	" vim-indent-guides
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_auto_colors = 0
	"hi IndentGuidesOdd ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a "StatusLineNC from xoria256
	hi IndentGuidesEven ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212 cterm=bold gui=bold "NonText from xoria256
endif

set backspace=indent,eol,start " backspace past everything in insert mode

" indentation:
set ts=4
set sw=4
set expandtab

set title
set ruler " Line and column at bottom
set number " Line numbers

" Always keep gutter visible so that it doesn't suddenly appear when there are diffs
" http://superuser.com/questions/558876/how-can-i-make-the-sign-column-show-up-all-the-time-even-if-no-signs-have-been-a#comment685355_558885
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Signify settings
let g:signify_vcs_list = [ 'git', 'perforce', 'hg' ] " Restrict list of VCSes

"highlight whitespace at the ends of lines
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

" I know it's blasphemous and I don't care :)
set mouse=a
set ttymouse=xterm2

" Keep swap files isolated to their own directory
:let homeswapdir=$HOME.'/.vim/swp'
if !isdirectory(homeswapdir)
	call mkdir(homeswapdir)
endif
execute "set directory=".homeswapdir

" Run goimports instead of gofmt on save of go files
let g:go_fmt_command = "goimports"
