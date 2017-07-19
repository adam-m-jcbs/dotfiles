" This file should work for both nvim and vim.  For nvim, install as
"    ~/.config/nvim/init.vim
" For vim, install as
"    ~/.vimrc

" Make sure vim-plug is installed, if not install it
if has('nvim')
   if empty(glob('~/.config/nvim/autoload/plug.vim'))
     silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
   endif
else
   " If no nvim, assume vim
   if empty(glob('~/.vim/autoload/plug.vim'))
     silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
   endif
endif

" Setup vim-plug for managing packages/plugins
let plugscript=''
if has('nvim')
   let plugscript='~/.config/nvim/autoload/plug.vim'
else
   let plugscript='~/.vim/autoload/plug.vim'
endif

if filereadable(expand(plugscript))
   call plug#begin('~/.vim/plugged')

   " Make sure you use single quotes

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

" Various single-line tweaks
set nowrap        " don't visually wrap lines
set ruler         " always show cursor position
set showcmd       " show some command info, esp useful for visual selection
set spell         " activate spell-checking
set number        " show line numbers
set laststatus=2  " Keeps a persistent status bar at bottom of screen
set textwidth=80  " width at which to wrap, default 78 in nvim but not for all filetypes it seems

" In insert mode use absolute numbers, when you go back to normal change to relative
"autocmd InsertEnter * :set norelativenumber
"autocmd InsertLeave * :set relativenumber

" TODO: Configure reasonable backups/ohshitsaves

" TODO: Configure tag browsing/viz

" Configure global theme
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
let g:airline_powerline_fonts = 1 " Note: you need patched fonts installed for this to work.
                                  " Many distros have a powerline package including them, otherwise you need to see powerline docs
let g:airline_theme='raven'       " See :help airline-themes-list for full list of themes, some of my favorites are commented out below
"let g:airline_theme='luna'
"let g:airline_theme='papercolor'
"let g:airline_theme='bubblegum'
"let g:airline_theme='wombat'
"let g:airline_theme='base16color'

" Tab/space configuration
set tabstop=3     " How many spaces a <Tab> counts as
set shiftwidth=3  " Preferred tab length/indent length
set expandtab     " Expand tabs into spaces, who the hell wants an actual <Tab>?

" Ignore case unless upper case letters are intentionally used.
set ignorecase
set smartcase

" Configure vim's built-in directory browser, netrw
let g:netrw_liststyle=3       " Default to a tree list view
let g:netrw_banner=0          " Get rid of the banner
let g:netrw_browse_split = 4  " Open files in the previous window
let g:netrw_winsize = 15      " Set the width of the netrw window to 15% of the screen width


" Automatically reload this file when it changes.
augroup init_reload
    au!
    au BufWritePost init.vim so $MYVIMRC
augroup END

""" nvim-only settings
if has('nvim')
   " Configure terminal emulator buffers
   augroup term_em
      au!
      autocmd BufWinEnter,WinEnter term://* startinsert   " Always start in insert mode when moving to a terminal buffer
      autocmd TermOpen             *        set nospell   " Turn off spell checking in terminal buffer
   augroup END
   
   " Setup some maps for easy terminal navigation, from :help terminal-emulator
   " 
   " This configuration allows using `Alt+{h,j,k,l}` to navigate between windows no
   " matter if they are displaying a normal buffer or a terminal buffer in terminal
   " mode.
   :tnoremap <A-h> <C-\><C-n><C-w>h
   :tnoremap <A-j> <C-\><C-n><C-w>j
   :tnoremap <A-k> <C-\><C-n><C-w>k
   :tnoremap <A-l> <C-\><C-n><C-w>l
   :nnoremap <A-h> <C-w>h
   :nnoremap <A-j> <C-w>j
   :nnoremap <A-k> <C-w>k
   :nnoremap <A-l> <C-w>l
   
   " Leader shortcuts
   let mapleader=","
   "" ,t --> open a new terminal 10 lines high below the current window
   nnoremap <leader>t :bel 10sp +te<CR>
   "" ,f --> browse files with CtrlP
   nnoremap <leader>f :CtrlP<CR>
   "" ,r --> browse recently used files with CtrlP
   nnoremap <leader>r :CtrlPMRUFiles<CR>
   "" ,b --> browse open buffers with CtrlP
   nnoremap <leader>b :CtrlPBuffer<CR>
   "" ,n --> open up netrw in a vertical split, browsing the cwd
   nnoremap <leader>n :Lexplore .<CR>
endif
