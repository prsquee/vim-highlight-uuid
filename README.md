# vim-highlight-uuid

A simple plugin to highlight an UUIDs under the cursor with different colors.

## Install with [pathogen.vim](https://github.com/tpope/vim-pathogen#readme)

    cd ~/.vim/bundle
    git clone https://github.com/prsquee/vim-highlight-uuid


## Usage 

 * `<leader>` + `1-9` to highlight the UUID under the cursor. It will hightlight the same UUID on the rest of the file. Pressing the same number will override the previous match.

 * `<leader>` + \` to clear all matches.

## Custom colors

To change the background color:

    let g:uuid_guibg = 'Green'     " When running in GUI mode
    let g:uuid_ctermbg = 'White    " When running in terminal

To change the foreground color:

Up to 9 colors:

    let g:uuid_fgcolors = [ 'Red', 'White', 'Blue', 'Green','Black','DarkGray']

Each color gets mapped to `<leader>` + number.

## Custom regex

You can define [any regex](http://vimregex.com) to highligh something else than UUID:

    let g:uuid_regex = '<new regex>'

I guess this plugin should really be called `vim-multiple-highlights`.

## How does it work?

Very simple. It uses [`expand("<cWORD>")`](http://vimdoc.sourceforge.net/htmldoc/cmdline.html#:%3CcWORD%3E) to lookup the "word" under the cursor. Then [`matchstr()`](http://vimdoc.sourceforge.net/htmldoc/eval.html#match()) is applied against this "word" with a regex to extract the uuid. This uuid is then added with [`matchadd()`](http://vimdoc.sourceforge.net/htmldoc/eval.html#matchadd()) to a list of highlights with the colors already defined during start up.  

## Demo

![](https://media.giphy.com/media/bqXMay1XnE4WqCFdt8/giphy.gif)

## ToDo

  * let user configure key mappings.
