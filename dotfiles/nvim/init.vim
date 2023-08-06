"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> You Complete Me
"    -> ALE
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" Setup python
let g:python3_host_prog='python3'

call plug#begin()

" Conquer of completion LSP server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lean mean status/tabline
Plug 'bling/vim-airline'

" Rainbow colored parantheses
Plug 'kien/rainbow_parentheses.vim'

" Full path fuzzy
Plug 'ctrlpvim/ctrlp.vim'

" commenting tool
Plug 'scrooloose/nerdcommenter'

" lineup comments
Plug 'godlygeek/tabular'

" surroundings
Plug 'tpope/vim-surround'

" CMake syntax highligthing
Plug 'vim-scripts/cmake.vim-syntax'
Plug 'jansenm/vim-cmake'

" syntax highlighting for everything
Plug 'scrooloose/syntastic'

" Rename files with :rename
Plug 'qpkorr/vim-renamer'

" editorconfig for vim
Plug 'editorconfig/editorconfig-vim'

" tagbar, display tags of the current file by scope
Plug 'preservim/tagbar'
Plug 'tenfyzhong/tagbar-ext.vim'

" GLSL syntax
Plug 'tikhomirov/vim-glsl'

" Ag search
Plug 'rking/ag.vim'

"color schemes
"Plug 'evgenyzinoviev/vim-vendetta' " vendetta
Plug 'tomasr/molokai' " molokai
Plug 'scheakur/vim-scheakur'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Git wrapper
Plug 'tpope/vim-fugitive'

" Git Gutter
Plug 'airblade/vim-gitgutter'

" ultisnips
Plug 'SirVer/ultisnips'

" extension of % matchit
Plug 'tmhedberg/matchit'

" Snippets
Plug 'honza/vim-snippets'

" Emojis
Plug 'junegunn/vim-emoji'

" rust
Plug 'rust-lang/rust.vim'

" clang-format
Plug 'rhysd/vim-clang-format'

" nerdtree
Plug 'scrooloose/nerdtree'

" hex color previewer
Plug 'ap/vim-css-color'

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" show line numbers and highlight current row
set number
set cursorline

" Avoid garbled characters in Chinese language windows OS
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
	set wildignore+=.git\*,.hg\*,.svn\*
endif

" CTRLP ignores
let g:ctrlp_custom_ignore = {
	\   'dir' : '\.git$\|build$\|bower_components\|node_modules\|dist\|target\|HeadersAndLibs\|external' ,
	\ 	'file' : '\v\.(exe|dll|lib)\|tags$'
	\ }
let g:ctrlp_extensions = ['tag']

if executable('ag')
	"Use Ag over Grep
	set grepprg=ag\ --nogroup\ --nocolor

	"Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

	"ag is fast enough that CtrlP doesn't need to cache - not fast enough....
	"let g:ctrlp_use_caching = 0

	if !exists(":Ag")
		command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
		nnoremap \ :Ag<SPACE>
	endif
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
set t_Co=256
try
	colorscheme molokai
	"colorscheme vendetta
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
	set guitablabel=%M\ %t
	set guiFont=Droid Sans Mono Dotted for Powerline:h15
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Highlight anything above 80 chars
highlight OverLength ctermbg=052 ctermfg=white guibg=#592929

match OverLength /\%81v.\+/

let g:rbpt_colorpairs = [
		\ ['brown',       'RoyalBlue3'],
		\ ['darkgray',    'DarkOrchid3'],
		\ ['darkgreen',   'firebrick3'],
		\ ['darkcyan',    'RoyalBlue3'],
		\ ['darkred',     'SeaGreen3'],
		\ ['darkmagenta', 'DarkOrchid3'],
		\ ['brown',       'firebrick3'],
		\ ['gray',        'RoyalBlue3'],
		\ ['darkmagenta', 'DarkOrchid3'],
		\ ['darkgreen',   'RoyalBlue3'],
		\ ['darkcyan',    'SeaGreen3'],
		\ ['darkred',     'DarkOrchid3'],
		\ ['red',         'firebrick3'],
		\ ]
"enable rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

" Use emojis for git
let g:gitgutter_sign_added = emoji#for('white_medium_small_square')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set noexpandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=100

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tk :tabp<cr>
map <leader>tj :tabn<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
 "set switchbuf=useopen,usetab,newtab
 "set stal=2
catch
endtry

"Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
" Remember info about open buffers on close
set viminfo^=%

" no more arrow keys!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>


""""""""""""""""""""""""""""""
" => Conquer of completion
""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


hi CocMenuSel ctermfg=15 ctermbg=246


" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
""""""""""""""""""""""""""""""
" => Ultisnip settings
""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:snips_author="eriks"

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
 nmap <D-j> <M-j>
 nmap <D-k> <M-k>
 vmap <D-j> <M-j>
 vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
 exe "normal mz"
 %s/\s\+$//ge
 exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Live substition
set inccommand=nosplit

" preview markdown
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
map <leader>g :Ag

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

map <C-g> :%s//

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Switch tabwidth
map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>

" switch between relative numbers
map <leader>r :set relativenumber!<cr>

" split line
nnoremap S i<CR><Esc>

" vim rails commands
map <leader>rc :Econtroller<cr>
map <leader>rv :Eview<cr>
map <leader>rm :Emodel<cr>

" generate doxy comment block
map <leader>77 :Dox<cr>

noremap <MiddleMouse> <Nop>
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

let g:rustfmt_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
		exe "menu Foo.Bar :" . a:str
		emenu Foo.Bar
		unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
		let l:saved_reg = @"
		execute "normal! vgvy"

		let l:pattern = escape(@", '\\/.*$^~[]')
		let l:pattern = substitute(l:pattern, "\n$", "", "")

		if a:direction == 'b'
				execute "normal ?" . l:pattern . "^M"
		elseif a:direction == 'gv'
				call CmdLine("Ag \"" . l:pattern . "\" " )
		elseif a:direction == 'replace'
				call CmdLine("%s" . '/'. l:pattern . '/')
		elseif a:direction == 'f'
				execute "normal /" . l:pattern . "^M"
		endif

		let @/ = l:pattern
		let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
		if &paste
				return 'PASTE MODE  '
		endif
		return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	 let l:currentBufNum = bufnr("%")
	 let l:alternateBufNum = bufnr("#")

	 if buflisted(l:alternateBufNum)
		 buffer #
	 else
		 bnext
	 endif

	 if bufnr("%") == l:currentBufNum
		 new
	 endif

	 if buflisted(l:currentBufNum)
		 execute("bdelete! ".l:currentBufNum)
	 endif
endfunction

function! LightMode()
	set t_Co=256
	set background=light
	colorscheme scheakur
endfunction

function! DarkMode()
	set t_Co=256
	set background=dark
	colorscheme molokai
endfunction

function! Present()
	Guifont consolas:h16
endfunction

function! PresentStop()
	Guifont consolas:h11
endfunction

function! Commands()
	echom "LightMode() - set light mode theme"
	echom "DarkMode() - set dark mode theme"
	echom "Present() - Increase font for presentation"
	echom "PresentStop() - stop presentation"
endfunction

let g:rustfmt_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make overlength work in splits as well
autocmd VimEnter,WinEnter * match OverLength /\%>100v.\+/

"remove trailing empty rows and white spaces
"au BufWritePre *.* :mark a | $put _ | $;?\(^\s*$\)\@!?+1,$d | :'a
"au BufWritePre * :%s/\s\+$//e
