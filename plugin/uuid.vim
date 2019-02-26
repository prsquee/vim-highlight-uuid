" uuid.vim - find and highlight uuid
" Author: sQ`
" Version: 0.1
" Repo: https://github.com/prsquee/vim-highlight-uuid

" Heavily inspired by this tip: http://vim.wikia.com/wiki/Talk:Highlight_multiple_words

if exists("g:loaded_highlightUUID") || &cp || v:version < 720
  finish
endif

let g:loaded_highlightUUID = 1

function! DoHighlight(hlnum)
  if a:hlnum > 0
    call UndoHighlight(a:hlnum)
    if !exists('g:uuid_regex')
      let g:uuid_regex = '\v<\x{8}(-\x{4}){3}-\x{12}>'
    endif
    let l:search_term = matchstr(expand("<cWORD>"), g:uuid_regex)
    let id = matchadd('uuid'.a:hlnum, l:search_term, -1)
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

function! s:AddHighlight(hlnum, fgcolor)
  if !exists('g:uuid_guibg')
    let g:uuid_guibg = 'DarkGray'
  endif
  if !exists('g:uuid_ctermbg')
    let g:uuid_ctermbg = 'Gray'
  endif
  if a:hlnum > 0 && a:hlnum < 10
    exec "highlight uuid".a:hlnum." ctermfg=".a:fgcolor." ctermbg=".g:uuid_ctermbg." guifg=".a:fgcolor." guibg=".g:uuid_guibg
  endif
endfunction

" range through 1-9 and setup highlights called uuidN with the color from fgcolor list
" then create leader + N mapping to call DoHightlight(N)
function! UUIDHighlightsInit()
  if !exists('g:uuid_fgcolors')
    let g:uuid_fgcolors = [ 'Blue', 'DarkRed', 'LightGreen', 'LightGray', 'Cyan', 'Yellow', 'LightMagenta', 'White', 'Brown' ]
  endif
  for n in range(0, len(g:uuid_fgcolors))
    if n > 8
      break
    endif
    let l:n1 = n + 1
    call s:AddHighlight(l:n1, g:uuid_fgcolors[n])
    exec 'nnoremap <silent> <leader>' . l:n1 . ' :call DoHighlight('. l:n1 . ')<CR>'
  endfor
  nnoremap <silent> <leader>` :call clearmatches()<CR>
endfunction

augroup KeepUUIDHightlighsAfterColorSchemeChange
  autocmd!
  autocmd ColorScheme * call UUIDHighlightsInit()
augroup END

call UUIDHighlightsInit()
