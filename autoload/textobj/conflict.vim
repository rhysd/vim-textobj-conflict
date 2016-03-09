let g:textobj#conflict#begin     = get(g:, 'g:textobj#conflict#begin', '^<<<<<<< \@=')
let g:textobj#conflict#end       = get(g:, 'g:textobj#conflict#end', '^>>>>>>> \@=')
let g:textobj#conflict#separator = get(g:, 'g:textobj#conflict#separator', '^=======$')

function! s:current_conflict_begin()
    let begin = searchpos(g:textobj#conflict#begin, 'bcnW')
    let before_end = searchpos(g:textobj#conflict#end, 'bnW')

    if begin == [0, 0] || (before_end != [0, 0] && before_end[0] > begin[0])
        return [0, 0]
    endif

    return begin
endfunction

function! s:current_conflict_end()
    let after_begin = searchpos(g:textobj#conflict#begin, 'nW')
    let end = searchpos(g:textobj#conflict#end, 'cnW')

    if end == [0, 0] || (after_begin != [0, 0] && end[0] > after_begin[0])
        return [0, 0]
    endif

    return end
endfunction

function! s:current_conflict_separator()
    " when separator is before cursor
    let before_begin = s:current_conflict_begin()
    let before_sep = searchpos(g:textobj#conflict#separator, 'bcnW')
    if before_sep != [0, 0] && before_begin != [0, 0] && before_begin[0] < before_sep[0]
        return before_sep
    endif

    " when separator is after cursor
    let after_end = s:current_conflict_end()
    let after_sep = searchpos(g:textobj#conflict#separator, 'cnW')
    if after_sep != [0, 0] && after_end != [0, 0] && after_sep[0] < after_end[0]
        return after_sep
    endif

    return [0, 0]
endfunction

function! s:valid_conflict(conflict)
    return filter(copy(a:conflict), 'v:val == [0, 0]') == []
endfunction

function! s:next_conflict(accept_cursor)
    let pos = getpos('.')
    return [
            \ searchpos(g:textobj#conflict#begin, (a:accept_cursor ? 'cW' : 'W')),
            \ searchpos(g:textobj#conflict#separator, 'cW'),
            \ searchpos(g:textobj#conflict#end, 'cW'),
            \ ]
endfunction

function! s:current_conflict()
    return [s:current_conflict_begin(), s:current_conflict_separator(), s:current_conflict_end()]
endfunction

function! s:pos(linecol)
    return [bufnr('%'), a:linecol[0], a:linecol[1], 0]
endfunction

function! s:selected_block(begin, end, inner)
    if a:inner && a:begin[0]+1 <= a:end[0]-1
        let [b, e] = [a:begin, a:end]
        let b[0] += 1
        let e[0] -= 1
        return ['V', s:pos(b), s:pos(e)]
    elseif !a:inner && a:begin[0] <= a:end[0]
        return ['V', s:pos(a:begin), s:pos(a:end)]
    else
        return 0
    endif
endfunction

function! s:select(inner)
    let current = s:current_conflict()

    if s:valid_conflict(current)
        let line = line('.')
        if line <= current[1][0]
            return s:selected_block(current[0], current[1], a:inner)
        elseif current[1][0] <= line
            return s:selected_block(current[1], current[2], a:inner)
        else
            return 0
        endif
    endif

    let next = s:next_conflict(0)

    if !s:valid_conflict(next)
        return 0
    endif

    return s:selected_block(next[0], next[1], a:inner)
endfunction


function! textobj#conflict#select_i()
    return s:select(1)
endfunction

function! textobj#conflict#select_a()
    return s:select(0)
endfunction
