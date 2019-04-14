# vim\_mouse\_2.ahk
AutoHotkey script with Vim bindings for controlling the mouse with the keyboard

## Modes
Like Vim, vim\_mouse has Modes of input, with "Insert Mode" acting like a regular keyboard
and "Normal Mode" intercepting keys to move the mouse instead.

`Win Alt i` to enter Normal Mode
`Escape` to go back to Insert Mode

Yes I know these are backward from regular Vim.

### Normal Mode

- `hjkl` move the mouse
- `HJKL` jump to edges of the screen
- `M` jump to center of the screen
- `i` left click
- `o` right click
- `v` hold down left click
- `^v`hold down right click (???)
- `e` scroll down
- `y` scroll up
- `d` scroll down faster
- `u` scroll up faster
- `Y` "yank" a window (click down on its title bar so you can reposition it)
- `b` "back" mouse button
- `n` "forward" mouse button
- `q` another way to exit normal mode

### Normal "Quick" Mode

There also exists a "quick" mode which allows you to issue mouse commands then immediately
return to Insert Mode. This is entered with `Win Alt <hjkl>` from Insert Mode and exits when
the Win and Alt keys are released

You can basically do the same commands as in Normal Mode, though you'll need to hold down
Win Alt to stay in Normal Quick mode

### Contact

Bug reports, questions, feature requests, and pull requests are all welcome.
Just open an issue on Github.
