# vim-highlight-uuid

A simple plugin to highlight an UUIDs under the cursor with different colors.

## Usage 

 * `<leader>` + `1-9` to highlight the UUID under the cursor. It will hightlight the same UUID on the rest of the file. Pressing the same number will override the previous match.

 * `<leader>` + \` to clear all matches.


 ## ToDo

  * let user configure key mappings.
  * use a better regex instead of `expand("<cWORD>")` to match UUID under the cursor.





