# vim\_mouse\_2.ahk
AutoHotkey script with Vim (and now also WASD!) bindings to control the mouse with the keyboard

## Installation
Download the script and binary by cloning this repository from GitHub. (You'll need to install
Git if you don't have it.) The command to run is

`git clone https://github.com/cutejs/vim_mouse_2.ahk.git`

(Or if you're fancy, clone it with SSH)

You can of course also just download it as a zip file, but cloning is recommended as you
can keep up to date with `git pull`. I'm still regularly pushing little updates here and there
to make it better and easier to use, so you might want to check periodically.

### Running from Source
You should run this script from source; never trust binaries you just find lying around
on the Internet, even if it's from a trustworthy source like yours truly :^)

To run it you'll need to install AutoHotkey first. Then you should be able to double click
the .ahk file to run the script. Pretty easy right?

### Precompiled Binary
As of the latest release, a precompiled version is shipped with the source code so you
don't have to install anything at all. Just double click the .exe and you're gucci golden!

If you do it this way, imagine me frowning a bit and seeming mildly disappointed. Just kidding, 
no judgment here! We're not all programmers after all!

## Modes of Input
Like Vim, vim\_mouse has modes of input, with "Insert mode" acting like a regular keyboard
and "Normal mode" intercepting keys to move and control the mouse instead.

`Home` enters Normal mode
`Insert` enters Insert mode (clever right?)

You can also switch between modes use either `Win Alt Enter` or `Win Alt Space`

You can access normal Home and Insert behavior with `Shift Home/Insert`

### Normal mode

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

### Normal "WASD" mode

You can also use the WASD keys if they're more natural to you than vim movement keys. Switch into
and out of WASD mode with `Win Alt r`

WASD mode is now the default for Normal mode.

- `wasd` move the mouse
- `WASD` jump to edges of the screen
- `C` jump to center the screen
- `r` left click
- `t` right click
- `y` middle click
- `e` scroll down
- `q` scroll up

Note that this necessarily unbinds `d` `e` and `y` from their Vim bindings.

Otherwise, it is just a variant of Normal mode and the rest of the hotkeys remain unchanged.

### Insert mode

Acts like a normal keyboard.

`Home` `Win Alt Space` and `Win Alt Enter` put you in Normal mode.

### Normal "Quick" mode
If you're in persistent Insert mode and just need the mouse keys for a second, you can hold
down Capslock to enter Normal "Quick" mode, which has all the same hotkeys as Normal mode and
ends when Capslock is released.

### Insert "Quick" mode
To quickly edit some text then return to Normal mode, a "quick" mode is also available for Insert.
Great for typing into an address bar or a form field. `Capslock` toggles between Normal and quick
Insert mode.

##### Entering
From Normal mode
- `:` enter QI (Quick Insert mode)
- `Capslock` toggle between QI and Normal mode
- `f` send f then enter QI (for Vimium hotlinks)
- `^f` send ctrl f then enter QI (commonly "search")
- `^t` send ctrl t then enter QI (new tab in the browser)
- `Delete` send Delete then enter QI (for quick fixes)
- `Backspace` send Backspace then enter QI (same idea)

##### Exiting
From quick Insert mode:
- `^c` exit to Normal mode
- `Enter` send Enter then exit to Normal mode
- `Capslock` toggle between Quick Insert and Normal mode

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

Use the uncompiled .ahk script and you can change these to taste.

## Contact

Bug reports, questions, feature requests, and pull requests are all welcome.
Just open an issue on Github.
