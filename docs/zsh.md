## Navigation
`Ctrl+A` - start of line; `Ctrl+E` - end of line

## Editing
`Ctrl+U` - delete line; `Ctrl+K` - delete to end
`Ctrl+W` - delete previous word; `Alt+D` - delete next word
`Ctrl+Y` - yank deleted text; `Alt+T` - transpose words
`Ctrl+Q` - push line

## Globbing
`*.txt` - wildcard; `**/*.txt` - recursive
`file?.txt` - single character; `{a,b}` - alternation
Example: `mv *.{md,txt} docs/`

## History
`Alt+.` / `Esc+_` - last word; repeat for older history
`!!:s/x/y` - substitute; `^foo^bar` - replace and run
`fc` - edit history; `r` - repeat last command

## Custom
`Ctrl+G` - edit current command in `$EDITOR`
`Ctrl+Shift+/` - show this cheatsheet
