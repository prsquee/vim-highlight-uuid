" multiple hightlights

if exists('g:loaded_multiple_highlight') || &cp || v:version < 720
  finish
endif

let g:loaded_multiple_highlight = 1

function! DoHighlight(hlnum)
  if a:hlnum > 0
    call UndoHighlight(a:hlnum)
    let l:search_term = matchstr(expand("<cWORD>"), g:mh_regex)
    let id = matchadd('multiple_highlights_'.a:hlnum, l:search_term, -1)
  endif
endfunction

function! UndoHighlight(hlnum)
  silent! call matchdelete(GetId(a:hlnum))
endfunction

function! GetId(hlnum)
  for m in getmatches()
    if m['group'] == 'multiple_highlights_'.a:hlnum
      return m['id']
    endif
  endfor
  return 0
endfunction

function! s:AddHighlight(hlnum, fgcolor)
  if !exists('g:mh_guibg')
    let g:mh_guibg = 'DarkGray'
  endif
  if !exists('g:mh_ctermbg')
    let g:mh_ctermbg = 'Gray'
  endif
  if a:hlnum > 0 && a:hlnum < 10
    exec "highlight multiple_highlights_".a:hlnum." ctermfg=".a:fgcolor." ctermbg=".g:mh_ctermbg." guifg=".a:fgcolor." guibg=".g:mh_guibg
  endif
endfunction

function! SetMultipleHighlight(regex)
  if (a:regex != '' && (exists('g:mh_regex') && g:mh_regex !=# a:regex)) || !exists('g:mh_regex')
    let g:mh_regex = a:regex
  endif
  call MultipleHighlightsUpdate()
  echomsg 'all set!'
endfunction

function! MultipleHighlightsUpdate()
  if !exists('g:mh_fgcolors')
    let g:mh_fgcolors = [ 'Blue', 'DarkRed', 'LightGreen', 'LightGray', 'Cyan', 'Yellow', 'LightMagenta', 'White', 'Brown' ]
  endif
  if exists('g:mh_regex')
    for n in range(0, len(g:mh_fgcolors))
      if n > 8
        break
      endif
      let l:n1 = n + 1
      call s:AddHighlight(l:n1, g:mh_fgcolors[n])
      exec 'nnoremap <silent> <leader>' . l:n1 . ' :call DoHighlight('. l:n1 . ')<CR>'
    endfor
    nnoremap <silent> <leader>` :call clearmatches()<CR>
  endif
endfunction

augroup KeepHightlighsAfterColorSchemeChange
  autocmd!
  autocmd ColorScheme * call MultipleHighlightsUpdate()
augroup END

call MultipleHighlightsUpdate()
