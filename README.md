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
- ``^q,`,Insert`` other ways to enter Insert mode

### Normal "Quick" Mode

There also exists a "quick" mode which allows you to issue mouse commands then immediately
return to Insert Mode. This is entered with `Win Alt hjkl` from Insert Mode and exits when
the Win and Alt keys are released.

You can basically do the same commands as in Normal Mode, though you'll need to hold down
Win Alt to stay in Normal Quick mode.

### Normal "WASD" Mode

You can also use the WASD keys if they're more natural to you than vim movement keys. Switch into
and out of WASD mode with `Win Alt r`

WASD mode persists through changes into and out of Insert mode.

- `wasd` move the mouse
- `r` left click
- `t` right click
- `y` middle click
- `e` scroll down
- `q` scroll up
- `E` scroll down faster
- `Q` scroll up faster
- `Space` scroll down faster

Note that this necessarily unbinds `d` `e` and `y` from their non WASD bindings.

Otherwise, it is just a variant of Normal mode and the rest of the hotkeys remain unchanged.

Normal "Quick" "WASD" mode is entered from Insert mode with `Right(!) Win Alt <wasd>` Note that
it's Right Win instead of the usual Left Win.

### Insert mode

Most commands from Normal mode are also available in Insert mode, but like Normal Quick mode
`Win Alt` must be held down to use them.

`Win Alt Space` `Win Alt Enter` and `Home` put you back in Normal mode.

### Insert "Quick" Mode
To quickly edit some text then return to Normal mode, a "quick" mode is also available for Insert.
Great for typing into an address bar or a form field. `Capslock` toggles between Normal and quick
Insert mode.

##### Entering
From Normal mode:
- `:` enter
- `Capslock` toggle
- `f` send f then enter (for Vimium hotlinks)
- `^f` send ctrl f then enter (commonly "search")
- `^t` send ctrl t then enter (new tab in the browser)
- `Delete` send Delete then enter (for quick fixes)
- `Backspace` send Backspace then enter (for quick fixes)

##### Exiting
From quick Insert mode:
- `^c` exit to Normal Mode
- `Enter` send Enter then exit to Normal mode
- `Capslock` toggle

##### Hotkeys
"Quick" mode is just a variant of Insert mode so the same hotkeys are available behind
Win Alt.

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
