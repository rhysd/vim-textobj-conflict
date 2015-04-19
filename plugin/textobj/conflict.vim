if (exists('g:loaded_textobj_conflict') && g:loaded_textobj_conflict) || &cp
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('conflict', {
    \ '_' : {
    \       'select-i' : 'i=', '*select-i-function*' : 'textobj#conflict#select_i',
    \       'select-a' : 'a=', '*select-a-function*' : 'textobj#conflict#select_a',
    \   }
    \ })

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_textobj_conflict = 1
