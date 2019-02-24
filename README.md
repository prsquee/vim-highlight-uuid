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

## Demo

![](https://media.giphy.com/media/bqXMay1XnE4WqCFdt8/giphy.gif)

## ToDo

  * let user configure key mappings.
