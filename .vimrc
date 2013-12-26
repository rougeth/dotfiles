"
" Maintainer:
" Marco Rougeth
" http://rougeth.com - marco@rougeth.com
"
" Version:
" 1.0 - 11/12/13
"
 
" -----------------------------------------------------------------------------
" => Important
" -----------------------------------------------------------------------------
 
" Disable Vi compatibility
set nocompatible
 
" Enable pathogen
" execute pathogen#infect()
 
" -----------------------------------------------------------------------------
" => Moving around, searching and patterns
" -----------------------------------------------------------------------------
 
" Ignore case when using a search pattern
set ignorecase
 
" Override 'ignorecase' when pattern has upper case characters
set smartcase
 
" -----------------------------------------------------------------------------
" => Displaying text
" -----------------------------------------------------------------------------
 
" Number of lines used for the command-line
set cmdheight=2
 
" Width of the diplay
set columns=80
 
" Show the line number for each line
set number
 
" -----------------------------------------------------------------------------
" => Syntax, highlighting and spelling
" -----------------------------------------------------------------------------

" Enable 256 colors
set t_Co=256

" The background color brightness
set background=dark
 
" Set color scheme
colorscheme molokai
 
" Type of file; triggers the FileType event when set
filetype plugin on
filetype indent on
 
" Highlight the screen line of the cursor
set cursorline
 
" Columns to highlight
set colorcolumn=80
 
" -----------------------------------------------------------------------------
" => GUI
" -----------------------------------------------------------------------------
 
" List of flags that specify how the GUI works
set guioptions-=T
set guioptions+=e
 
" -----------------------------------------------------------------------------
" => Messages and info
" -----------------------------------------------------------------------------
 
" Show cursor position below each window
set ruler
 
" Disable the bell for error messages
set noerrorbells
 
" Disable the visual bell
set novisualbell
 
" -----------------------------------------------------------------------------
" => Editing text
" -----------------------------------------------------------------------------
 
" Maximum number of changes that can be undone
set undolevels=1000
 
" Specifies what <BS>, CTROL-W, etc. can do in Insert mode
set backspace=indent,eol,start
 
" When inserting a bracket, briefly jump to its match
set showmatch
 
" -----------------------------------------------------------------------------
" => Tabs and indenting
" -----------------------------------------------------------------------------
 
" Number of spaces a <Tab> in the text stands for
set tabstop=4
 
" Number of spaces used for each step of (auto)indent
set shiftwidth=4
 
" A <Tab> in an indent inserts 'shiftwidth' spaces
set smarttab
 
" Expand <Tab> to spaces in Insert mode
set expandtab
 
" Automatically set the indent of a new line
set autoindent
 
" Do clever autoindenting
set smartindent
 
" -----------------------------------------------------------------------------
" => Reading and writing files
" -----------------------------------------------------------------------------
 
" Automatically read a file when it was modified outside of Vim
set autoread
 
" -----------------------------------------------------------------------------
" => Command line editing
" -----------------------------------------------------------------------------
 
" How many command lines are remembered
set history=100
 
" List of patterns to ignore files for file name completion
set wildignore=*.o,*~.,*.pyc
 
" Command-line completion shows a list of matches
set wildmenu
 
 
 
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP
