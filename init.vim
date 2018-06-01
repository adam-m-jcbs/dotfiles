" This file should work for both nvim and vim.  For nvim, install as
"    ~/.config/nvim/init.vim
" For vim, I prefer to install as a softlink to init.vim:
"    ln -s ~/.config/nvim/init.vim ~/.vimrc

" Maintainer: Adam Jacobs
" Sections:
"   + Initialization and Installation
"   + UI, Options Configuration, Themes, and Colors
"   + Browsing, Buffers, Panes, and Tabs
"   + Language and Filetype Settings 
"   + Mappings, Functions, and Other Custom Definitions

" Testing this and other .vim files:
" (http://vim.wikia.com/wiki/Vim_as_a_system_interpreter_for_vimscript)
" You can use vim like a system interpreter to test this file and other
" vimscripts (usually .vim files) from the commandline with:
" $ vim -i NONE -u NORC -U NONE -V1 -nNesS file.vim -c'echo""|qall!' -- args...
"   -i NONE --> Don't bother with viminfo file
"   -u NORC --> No rc file, don't initialize with vimrc. Implied with -s, kept
"               here for completeness.  NONE would also suppress loading of
"               plugins. see :help initialization 
"   -U NONE --> No initialization from gvimrc.  Also implied by -s, I believe.
"               see :help gui-init .
"   -V1     --> Set verbosity to level 1, makes it possible to see prints and
"               such that you often want to see when debugging/testing.
"   -nNesS file.vim
"       -n  --> Don't bother with a swap file
"       -N  --> Don't start in vi-compatible mode (this is commandline version
"               of `set nocompatible`
"       -e  --> Run vim in "ex" mode, where input is interpreted as ex commands
"               and vimscript.  See also -E (for some extras that you don't
"               usually need when testing a single script).
"       -s  --> When in ex mode, this makes vim behave more like an interpreter.
"               It means an editor window won't be opened, all standard output
"               is suppressed (which is why we want -V1 above), rc
"               initialization is suppressed (hence some of the above being
"               redundant), and causes exit code from vim to reflect if the
"               given commands run without error.
"       -S file.vim 
"           --> Source input from file.vim.
"   -c'echo""|qall!'
"           --> Add a newline after the script output and exit vim.
"   -- args...
"           --> These are args that can be passed to the script.
" 
" So more concisely, we can do
" $ vim -i NONE -V1 -nNesS file.vim -c'echo""|qall!'

" vim namespace conventions:
"   g: - Global.
"   l: - Local to a function.
"   s: - Local to a script file.
"   a: - Function argument (only inside a function).
"   v: - Global, predefined by Vim.
"   b: - Local to the current buffer.
"   w: - Local to the current window.
"   t: - Local to the current tab page.

" WARNING: This vimrc caused vim 7.2 to break (random ABRT signals).

"==============================================================================
" Initialization and Installation
"==============================================================================

if !has('nvim')
    " If we're not in neovim (i.e. we're in vim), we need to set this early.
    set nocompatible 
endif

" Define location of vim-plug installations
" TODO: As of now I hardcode the default known XDG_CONFIG_HOME and
" XDG_DATA_HOME values:
"   XDG_CONFIG_HOME --> ~/.config/
"   XDG_DATA_HOME   --> ~/.local/share,
" would be better to use environment variables when available.  Some key files
" and directories I use for nvim are:
"   $XDG_CONFIG_HOME/nvim/init.vim
"   $XDG_CONFIG_HOME/nvim/autoload/plug.vim
"   $XDG_DATA_HOME/nvim/plugged
"
let s:nvim_plug_script='~/.config/nvim/autoload/plug.vim'
let s:vim_plug_script='~/.vim/autoload/plug.vim'
let s:nvim_plugin_dir='~/.local/share/nvim/plugged'
let s:fresh_install=0

" Make sure vim-plug is installed, if not install it.
if empty(glob(s:nvim_plug_script))
    " Install vim-plug
    let s:plug_install_cmd='silent !curl -fLo ' . s:nvim_plug_script
        \. ' --create-dirs '
        \. 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute s:plug_install_cmd
   
    " Make needed directory
    let s:mkdir_cmd = 'silent !mkdir -p ' . s:nvim_plugin_dir
    execute s:mkdir_cmd
    
    let s:fresh_install=1
    " If we just installed vim-plug, then create an automatic command that
    " executes vim-plug's PlugInstall on start (VimEnter).  This will install
    " all requested plugins in the plug#begin--plug#end section AFTER the full
    " vimrc has been processed.
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    " We source $MYVIMRC after install because (I think...) it's possible some
    " vimrc config will rely upon plugins being installed.
endif

" I always install to the neovim location and then softlink to this for vim. 
if empty(glob(s:vim_plug_script))
    let s:mkdir_cmd = 'silent !mkdir -p ' . fnamemodify(s:vim_plug_script, ':h')
    execute s:mkdir_cmd
    let s:plug_ln_cmd='silent !ln -s ' . s:nvim_plug_script . ' '
        \. s:vim_plug_script
    execute s:plug_ln_cmd
    let s:fresh_install=1
    " TODO: It is possible that there is an existing installation of vim-plug
    " for vim.  The user will not be warned about this.  Would be nice to try
    " to check for this and warn user.
endif

" Setup vim-plug for managing packages/plugins
if filereadable(expand(s:nvim_plug_script))
    call plug#begin(s:nvim_plugin_dir)
 
    " Make sure you use single quotes with `Plug` commands (not sure why)
 
    " Git integration, wrapping in vim
    "    TODO: Practice using this
    Plug 'tpope/vim-fugitive'
 
    " TODO: A linter that works with non-trivial fortran would be nice
    "    -Couldn't get syntastic working w/ neovim
    "    -Neomake can't readily handle non-trivial Fortran (if it can, it's not
    "    documented well imo).
    "Plug 'neomake/neomake'
 
    " Nice statusline.  Note: powerline doesn't seem to integrate into neovim
    " yet, so I use vim-airline, which is a bit simpler anyway
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
 
    " A mega-collection of colorschemes
    Plug 'flazz/vim-colorschemes'
 
    " File, buffer, tag browser.  Very popular among vimmers.
    Plug 'ctrlpvim/ctrlp.vim'

    " Adds ability to toggle right sidebar with tags displayed
    Plug 'majutsushi/tagbar'

    "TODO consider these plugins
    "Plugin 'NLKNguyen/papercolor-theme'
    "taglist
    "vim-LaTeX
 
    " Example templates from docs:
    " Git shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    "Plug 'junegunn/vim-easy-align'
    " Any valid git URL is allowed
    "Plug 'https://github.com/junegunn/vim-github-dashboard.git'
    " Group dependencies, vim-snippets depends on ultisnips
    "Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    " On-demand loading
    "Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    "Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    " Using a non-master branch
    "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
    "Plug 'fatih/vim-go', { 'tag': '*' }
    " Plugin options
    "Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
    " Plugin outside ~/.vim/plugged with post-update hook
    "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Unmanaged plugin (manually installed and updated)
    "Plug '~/my-prototype-plugin'
 
    " Add plugins to &runtimepath
    call plug#end()
endif

if !has('nvim')
    " If we're not in neovim, use the same defaults as neovim.  Some options may
    " be set again later.  This just makes sure that after this point there
    " should be consistency between using this vimrc in vim and neovim.
    set backspace=indent,eol,start   " allow backspacing over everything
                                     " in insert mode
    set history=10000 " keep 10000 lines of command line history (maximum)
    set ruler         " show the cursor position all the time
    set showcmd       " display incomplete commands
    set incsearch     " do incremental searching
    if has('mouse')
       set mouse=a    " allow use of mouse when available
    endif
    set autoindent    " automatically insert indentation
    set laststatus=2  " keeps a persistent status bar at bottom of screen
    set smarttab      " keep things lined up when pressing tab
    set autoread      " auto reload a file when changed externally
    set formatoptions=tcqj " we'll customize this later for nvim and vim
    set hlsearch      " highlight search matches
    set tabpagemax=50 " max tabs that can be open with `vim -p ...`
    set tags=./tags;,tags " list of tags files to search, see :help tags-option
    set wildmenu      " enhanced command-line completion

    " esoteric settings I never needed in my vimrc, set for nvim/vim consistency
    set nolangremap   
    set listchars=tab:>\ ,trail:-,nbsp:+
    set nrformats=bin,hex
    set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
    set ttyfast
endif

" If this is a fresh vim-plug install, then install plugins before continuing.
if s:fresh_install
    execute "PlugInstall --sync"

    " TODO: After sufficient testing, clean up.
    " NOTE: I'm using this if-block to force an install before reading the rest
    " of the vimrc.  Otherwise, things like setting the colorscheme won't work
    " because the colorscheme hasn't been installed yet.  If you have problems
    " with doing the automatic install here, try reverting to the commented out
    " line above:
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"==============================================================================
" UI, Options Configuration, Themes, and Colors
"==============================================================================

" TODO add comment out macro
" TODO make macro/function/whatev to toggle relativenumbers In insert mode use
"   absolute numbers, when you go back to normal change to relative
"autocmd InsertEnter * :set norelativenumber
"autocmd InsertLeave * :set relativenumber
" TODO: Configure reasonable backups/ohshitsaves
" TODO: Configure tag browsing/viz

"" UI, options configuration
set formatoptions=tcqrjl
" This is a sequence of letters which describes how
" automatic formatting is to be done.
"
" letter    meaning when present in 'formatoptions'
" ------    ---------------------------------------
" t         Auto-wrap text using textwidth.
" c         Auto-wrap comments using textwidth, inserting
"           the current comment leader automatically.
" q         Allow formatting of comments with "gq".
" r         Automatically insert the current comment leader
"           after hitting <Enter> in Insert mode. 
" j	        Where it makes sense, remove a comment leader when joining lines.
" l         Long lines are not broken in insert mode: When a line was longer
"           than 'textwidth' when the insert command started, Vim does not
"           automatically format it.
set nowrap        " don't visually wrap lines
set spell         " activate spell-checking
set number        " show line numbers
set textwidth=80  " width at which to wrap
                  " TODO: customize python to wrap at 79, 72 for
                  "     docstring/comments
set tabstop=4     " How many spaces a <Tab> counts as (4 chosen for PEP-8)
set shiftwidth=4  " Preferred tab length/indent length
set expandtab     " Expand tabs into spaces, who the hell wants an actual <Tab>?
" Ignore case unless upper case letters are intentionally used.
set ignorecase
set smartcase
" Automatically reload this file when it changes.
augroup init_reload
    au!
    au BufWritePost init.vim so $MYVIMRC
    au BufWritePost .vimrc so $MYVIMRC
    " TODO/NOTE: This may break if in vim and .vimrc isn't linked to init.vim
augroup END
syntax on " Enable syntax highlighting
" In the past I've needed this:
"set t_Co=256
"if &t_Co > 2 || has("gui_running")
"   syntax on
"endif

"" Configure global theme
colorscheme elda
" Some of my favorites:
"colorscheme bubblegum-256-dark
"colorscheme lapis256
"colorscheme lilypink
"colorscheme muon
"colorscheme sourcerer
"colorscheme up
"colorscheme wolfpack
"colorscheme lucius "needs `set background=dark`

" Configure airline
"let g:airline_powerline_fonts = 1 " Note: you need patched fonts or fontconfig
                                  " files installed for this to work.
                                  " Many distros have a powerline package
                                  " including them, otherwise you need to see
                                  " powerline docs.  To make this as portable to
                                  " as many machines as possible (especially
                                  " those the user doesn't have root access to),
                                  " I've decided to go with the less pretty,
                                  " more readily available airline defaults.

let g:airline_symbols_ascii = 1
"let g:airline_theme='raven'       " See :help airline-themes-list for full list
"let g:airline_theme='luna'
"let g:airline_theme='papercolor'
"let g:airline_theme='bubblegum'
"let g:airline_theme='wombat'
"let g:airline_theme='base16color'
let g:airline_theme='tomorrow'

" Don't display file encoding if it's the expected 'utf-8[unix]'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Here we explicitly set airline symbols, usually to the default, allowing for
" easy customization.
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"
"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
""let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = ''
"let g:airline_symbols.notexists = '*'
"let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''

" Airline uses this symbol to indicate you have gives in the git branch that
" aren't committed/pushed.  The default is ugly, and * is also used by git's
" shell prompt, so use it.
"let g:airline_symbols.notexists = '*'

" By default, airline warns about trailing spaces.  I don't care.  So define the
" whitespace checks and remove 'trailing'
let g:airline#extensions#whitespace#checks = [ 'indent', 'long', 
                                             \'mixed-indent-file' ]

"==============================================================================
" Browsing, Buffers, Panes, and Tabs
"==============================================================================
" Configure vim's built-in directory browser, netrw
" TODO: use nerdtree
" TODO: default session with file/tag browsing?
let g:netrw_liststyle=3       " Default to a tree list view
let g:netrw_banner=0          " Get rid of the banner
let g:netrw_browse_split = 4  " Open files in the previous window
let g:netrw_winsize = 15      " Set the width of the netrw window
                              " to 15% of the screen width

if has('nvim')
   " Configure terminal emulator buffers
   augroup term_em
      au!
      " Always start in insert mode when moving to a terminal buffer
      autocmd BufWinEnter,WinEnter term://* startinsert
      " Turn off spell checking in terminal buffer
      autocmd TermOpen             *        set nospell   
   augroup END
endif 

"==============================================================================
" Language and Filetype Settings 
"==============================================================================


"==============================================================================
" Mappings, Functions, and Other Custom Definitions
"==============================================================================
" Leader character used in custom mappings
let mapleader=","
if has('nvim')
   " Setup some maps for easy terminal navigation, from :help terminal-emulator
   " 
   " This configuration allows using `Alt+{h,j,k,l}` to navigate between windows
   " no matter if they are displaying a normal buffer or a terminal buffer in
   " terminal mode.
   :tnoremap <A-h> <C-\><C-n><C-w>h
   :tnoremap <A-j> <C-\><C-n><C-w>j
   :tnoremap <A-k> <C-\><C-n><C-w>k
   :tnoremap <A-l> <C-\><C-n><C-w>l
   :nnoremap <A-h> <C-w>h
   :nnoremap <A-j> <C-w>j
   :nnoremap <A-k> <C-w>k
   :nnoremap <A-l> <C-w>l
   
   " ,t --> open a new terminal 10 lines high below the current window
   nnoremap <leader>t :bel 10sp +te<CR>
endif
" ,f --> browse files with CtrlP
nnoremap <leader>f :CtrlP<CR>
" ,r --> browse recently used files with CtrlP
nnoremap <leader>r :CtrlPMRUFiles<CR>
" ,b --> browse open buffers with CtrlP
nnoremap <leader>b :CtrlPBuffer<CR>
" ,n --> open up netrw in a vertical split, browsing the cwd
nnoremap <leader>n :Lexplore .<CR>
