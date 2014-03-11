
" kill vi compatibility
set nocompatible               " be iMproved
filetype off                   " required!


" =====================================================
" ========== COLORSCHEME ==============================
" =====================================================
" option name default optional
let g:solarized_termcolors= 16
let g:solarized_termtrans = 16
" let g:solarized_degrade = 1 
let g:solarized_bold = 1
let g:solarized_underline = 1 
let g:solarized_italic = 1
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"
" ==============================================================

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" ==============================================================
" =========================pathogen=============================
execute pathogen#infect()

syntax enable
set background=dark
colorscheme solarized

" ========== let Vundle manage Vundle ===========================
" ========== required! ========================================== 
Bundle 'gmarik/vundle'

" ===============Prayag's Bundles here===========================
" ===============original repos on github========================
Bundle "loki-nkl/vim-mysql-mode"
Bundle 'phleet/vim-mercenary'
Bundle 'bling/vim-airline'

" ===============================================================
" =========== snipmate ==========================================
" ===============================================================
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"

" Bundle "msanders/snipmate.vim"
Bundle "garbas/vim-snipmate"
" ===============================================================



" ===============================================================
" =================== git =======================================
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" ===============================================================
" ===============Scala/Play======================================
" ===============================================================
Bundle 'derekwyatt/vim-scala'

Bundle 'tomtom/tcomment_vim'
Bundle 'tmhedberg/matchit'
Bundle 'rdolgushin/play.vim'
" ========================================================

" ========================================================
" ============ groovy/grails =============================
" ========================================================
Bundle "hoffoo/vim-grails-console"
Bundle "NathanNeff/grails-vim"

" ========================================================
" =================== ANDROID ============================
Bundle 'bpowell/vim-android'
"Bundle 'hsanson/vim-android' " :help vim-android-commands
Bundle 'jalcine/android.vim'
" ========================================================

" 'vim-mercenary'
" mysql vim mode - https://github.com/iPrayag/vim-mysql-mode

" =========================================================
" =========== non github repos ============================
Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...


 filetype plugin on
 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..


" ===============================================================================
" =============================== netRW =========================================
" Toggle Vexplore with Ctrl-E
" http://stackoverflow.com/a/5636941/432903
" http://modal.us/blog/2013/07/27/back-to-vim-with-nerdtree-nope-netrw/
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" Change directory to the current buffer when opening files.
set autochdir

" ==================================================================================



set laststatus=2

" =============================================================
set foldmethod=syntax
set foldlevelstart=1

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
" =============================================================


" :let g:snips_trigger_key = '<tab>'
" :imap <C-J> <Plug>snipMateNextOrTrigger
" :smap <C-J> <Plug>snipMateNextOrTrigger
