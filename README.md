# vim\_mouse\_2.ahk
AutoHotkey script with Vim (and now also WASD!) bindings to control the mouse with the keyboard

## Modes of Input
Like Vim, vim\_mouse has Modes of input, with "Insert Mode" acting like a regular keyboard
and "Normal Mode" intercepting keys to move and control the mouse instead.

To switch between modes use either `Win Alt Enter` or `Win Alt Space`

### Normal Mode

- `hjkl` move the mouse
- `HJKL` jump to edges of the screen
- `M` jump to center of the screen
- `i` left click
- `o` right click
- `p` middle click
- `v` hold down left click
- `V` hold down right click (???)
- `e,0,]` scroll down
- `y,9,[` scroll up
- `d,}` scroll down faster
- `u,{` scroll up faster
- `Y` "yank" a window (reposition it) (press i to release)
- `b` "back" mouse button
- `n` "forward" mouse button
- `^q,``` another way to enter Insert mode

### Normal "Quick" Mode

There also exists a "quick" mode which allows you to issue mouse commands then immediately
return to Insert Mode. This is entered with `Win Alt hjkl` from Insert Mode and exits when
the Win and Alt keys are released

You can basically do the same commands as in Normal Mode, though you'll need to hold down
Win Alt to stay in Normal Quick mode

### Normal "WASD" Mode

You can also use the WASD keys if they're more natural to you than vim movement keys. Switch into
and out of WASD mode with `Win Alt r`

- `wasd` move the mouse
- `r` left click
- `t` right click
- `y` middle click
- `e` scroll down
- `q` scroll up
- `E` scroll down faster
- `Q` scroll up faster
- `Space` scroll down faster

Note that this necessarily unbinds `d` `e` and `y` from their non WASD bindings

Otherwise, it is just a variant of Normal mode and the rest of the commands are available.

Normal "Quick" "WASD" mode is entered from Insert mode with `_Right_ Win Alt wasd`

### Insert mode

Most commands from Normal mode are also available in Insert mode, but like Normal Quick mode
`Win Alt` must be held down to use them.

Again, `Win Alt Space` and `Win Alt Enter` switch you back into Normal mode

### Insert "Quick" Mode
To quickly edit some text then return to Normal mode, a "quick" mode is also available for Insert.
Great for typing into an address bar or a form field. `Enter` exits Insert "Quick" Mode and also sends
the Enter keypress. `Ctrl F` exits without sending additional keys.

From normal mode,
`f` - Type f then enter Insert mode (for Vimium hotlink mode)
`^f` - Type ctrl f then enter quick Insert mode (ctrl f is a common "search" keybind)
`F` - Enter quick Insert mode without sending any keys
`Delete` - Type Delete and enter quick Insert mode (for quick finxes)
`Backspace` - Type Backspace and enter quick Insert mode (same idea)

## Last Remarks

#### For Vim Purists
_"Why doesn't `i` take me into Insert mode and `Escape` put me in Normal mode! >:U"_

I tried to leave some variant of `i` as an alternative to enter Insert mode but it was impossible
for me to keep straight when it would switch modes and when it was left click, so now it's just
consistently left click which is less likely to make me upset.

`Escape` is too useful a key to bind to anything.  It was infuriating to hit Escape and not have
the expected effect so I took it out.

~ Sorry, nerds :^)

_"How come I can't make my own keybindings >:I"_

I like these ones. You can fork the repo or make a pull request if you want to set up an ini file :^)

#### The mouse moves too fast! (or too slow)

At the top of the file, mouse speed is controlled by two global variables, FORCE and RESISTANCE.
FORCE controls acceleration and RESISTANCE causes diminishing returns and implicitly creates a
terminal velocity.

## Contact

Bug reports, questions, feature requests, and pull requests are all welcome.
Just open an issue on Github.
