# vim\_mouse\_2.ahk
AutoHotkey script with Vim (and now also WASD!) bindings to control the mouse with the keyboard

## Modes of Input
Like Vim, vim\_mouse has Modes of input, with "Insert Mode" acting like a regular keyboard
and "Normal Mode" intercepting keys to move and control the mouse instead.

To switch between modes use either `Win Alt Enter` or `Win Alt Space`

`Insert` in Normal mode takes you to Insert mode and `Home` in Insert mode takes you to
Normal mode. Useful when you know what mode you *want* to be in, but not which one you're in.
You can access normal Home and Insert behavior with `Shift Home/Insert` when they're otherwise a hotkey.

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
- ``^q,Insert`` other ways to enter Insert mode

### Normal "WASD" Mode

You can also use the WASD keys if they're more natural to you than vim movement keys. Switch into
and out of WASD mode with `Win Alt r`

WASD mode is now the default for Normal Mode.

- `wasd` move the mouse
- `WASD` jump to edges of the screen
- `C` jump to center the screen
- `r` left click
- `t` right click
- `y` middle click
- `e` scroll down
- `q` scroll up

Note that this necessarily unbinds `d` `e` and `y` from their non WASD bindings.

Otherwise, it is just a variant of Normal mode and the rest of the hotkeys remain unchanged.

### Insert mode

`Win Alt Space` `Win Alt Enter` and `Home` put you back in Normal mode.

### Normal "Quick" Mode
If you're in persistent Insert Mode and just need the mouse keys for a second, you can hold
down Capslock to enter Normal "Quick" Mode, which has all the same hotkeys as Normal mode and
ends when Capslock is released.

### Insert "Quick" Mode
To quickly edit some text then return to Normal mode, a "quick" mode is also available for Insert.
Great for typing into an address bar or a form field. `Capslock` toggles between Normal and quick
Insert mode.

##### Entering
From Normal mode:
- `:` enter q.i.
- `Capslock` toggle q.i.
- `f` send f then enter q.i. (for Vimium hotlinks)
- `^f` send ctrl f then enter q.i. (commonly "search")
- `^t` send ctrl t then enter q.i. (new tab in the browser)
- `Delete` send Delete then enter q.i. (for quick fixes)
- `Backspace` send Backspace then enter q.i. (same idea)

##### Exiting
From quick Insert mode:
- `^c` exit to Normal Mode
- `Enter` send Enter then exit to Normal mode
- `Capslock` toggle

`Home` enters Normal mode
`Insert` enters regular (persistent) Insert mode

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

I like these ones. You can fork the repo or make a pull request if you want to set up managing an ini file :^)

#### The mouse moves too fast! (or too slow)

At the top of the file, mouse speed is controlled by two global variables, FORCE and RESISTANCE.
FORCE controls acceleration and RESISTANCE causes diminishing returns and implicitly creates a
terminal velocity.

## Contact

Bug reports, questions, feature requests, and pull requests are all welcome.
Just open an issue on Github.
