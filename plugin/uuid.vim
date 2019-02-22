" uuid.vim - find and highlight uuid
" Author: sQ`
" Version: 0.1
" Repo: https://github.com/prsquee/vim-highlight-uuid
" Inspired by this: http://vim.wikia.com/wiki/Talk:Highlight_multiple_words


if exists("g:loaded_highlightUUID") || &cp || v:version < 720
  finish
endif

let g:loaded_highlightUUID = 1

function! DoHighlight(hlnum, search_term)
  if a:hlnum > 0
    call UndoHighlight(a:hlnum)
    " let l:search_term = matchstr(getline('.'), '\v\x{8}(-\x{4}){3}-\x{12}')
    " let id = matchadd('uuid'.a:hlnum, l:search_term, -1)
    let id = matchadd('uuid'.a:hlnum, a:search_term, -1)
  endif
endfunction

function! UndoHighlight(hlnum)
  silent! call matchdelete(GetId(a:hlnum))
endfunction

function! GetId(hlnum)
  for m in getmatches()
    if m['group'] == 'uuid'.a:hlnum
      return m['id']
    endif
  endfor
  return 0
endfunction

function! AddHighlight(hlnum, fgcolor)
  if len(a:fgcolor) > 0
    exec "highlight uuid".a:hlnum." ctermfg=".a:fgcolor." ctermbg=DarkGray guifg=".a:fgcolor." guibg=DarkGray"
  endif
endfunction

" range through 1-9 and setup highlights called uuidN with the color from fgcolor list
" then create leader + N mapping to call DoHightlight(N)
let fgcolors = [ 'no', 'Blue', 'DarkRed', 'LightGreen', 'LightGray', 'Cyan', 'Yellow', 'LightMagenta', 'White', 'Brown' ]
for n in range(1,9)
  call AddHighlight(n, fgcolors[n])
  exec 'nnoremap <silent> <leader>' . n . ' :call DoHighlight('. n . ', expand("<cWORD>"))<CR>'
  " The idea here is to match an UUID under the cursor for now using <cWORD> would do the job.
  " Using getline + regex in DoHighLight() will only find the first UUID
  " I need to came up with a regex around \%#
endfor
nnoremap <silent> <leader>` :<C-u>call clearmatches()<CR>
