# vim\_mouse\_2.ahk
AutoHotkey script with Vim (and now also WASD!) bindings to control the mouse with the keyboard

## Why use a mouse control script?
This is my implementation of a hardware mouse, in software. As of 2023 I believe it has full
feature parity with an actual mouse, and has been optimized by daily use for several years.
Whatever your reasons for trying to drive the mouse with the keys, this is my very best attempt
at creating a program to do so, and I hope you find it as pleasant and convenient to use as I do.

## Installation
Download the script and binary by cloning this repository from GitHub.  The command to run is
`git clone git@github.com:cutejs/vim_mouse_2.ahk.git`

If that sentence makes no sense to you at all, no worries! Simply download the repository
as a zip file, unzip it, and run the included executable mouse-control.exe :>

The benefit to using git is you can keep up to date with `git pull`. I'm still (periodically)
pushing little updates here and there to make it better and easier to use.

### Precompiled Binary
As of the latest release, a precompiled version is shipped with the source code so you
don't have to install anything at all. Just double click the .exe and you're gucci golden!
(It's the one with a cute little mouse icon) (Well, I think it's cute; I'm not much of an
artist, admittedly)

### Running from Source
You should run this script from source; never trust binaries you just find lying around
on the Internet, even if it's from a trustworthy source like yours truly :^)

To run it you'll need to install AutoHotkey first. Then you should be able to double click
the .ahk file to run the script. Pretty easy right?

#### AS OF (WHENEVER IT WAS) AHK has updated to "Version 2.0"
Luckily it turns out, you can install either version 1.1 or 2.0, as when
you try to run mouse-control.ahk in Version 2, it will happily download the old version
and run it appropriately. 

## Modes of Input
This program has modes of input, allowing the keys to *sometimes* drive the mouse, and
sometimes drive the keyboard (inspired by the text editor Vim). There's "Insert mode"
where the keys behave normally and "Normal mode" intercepting keys to move and control
the mouse instead. (These names are lifted from Vim. I'm aware, "Normal" mode isn't
very normal at all)

`Home` or `Win Alt n` enters Normal mode
`Insert` or `Win Alt i` enters Insert mode

### Normal mode

- `hjkl` move the mouse
- `HJKL` jump to edges of the screen
- `M` jump to center of the screen
- `i` left click
- `o` right click
- `p` middle click
- `v` hold down left click (hit `v` or any mouse button again to release)
- `z` hold down right click (hit `z` or any mouse button again to release)
- `c` hold down middle click (hit `c` or any mouse button again to release)
- `e,0,]` scroll down
- `y,9,[` scroll up
- `d,}` scroll down faster
- `u,{` scroll up faster
- `Y` "yank" a window (reposition it) (press i to release)
- `b` "back" mouse button
- `n` "forward" mouse button
- `Insert,Win+Alt+i` enter Insert mode

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

`Home` and `Win Alt n` put you in Normal mode.

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

##### Exiting
From quick Insert mode:
- `^c` exit to Normal mode
- `Enter` send Enter then exit to Normal mode
- `Capslock` toggle between Quick Insert and Normal mode

`Home` enters Normal mode
`Insert` enters regular (persistent) Insert mode

## Last Remarks

## Alternative to Numpad Mouse I am aware of the Numpad Mouse feature included in Windows, and consider this a Massive improvement
over the builtin functionality. I'll say that again, for search optimization, This is an alternative
to Numpad Mouse with considerably better usability, and additional functionality. It is a faster, easier
to use alternative to Numpad Mouse. 

#### For Vim Purists
_"Why doesn't `i` take me into Insert mode and `Escape` put me in Normal mode! >:U"_

I made `i` left click. You've got `Win Alt i` which is a nice and unintrusive variant of `i`.
We didn't even used to have that when Win Alt was part of Quick modes so there you go.

`Escape` is too useful a key to bind to anything.  It was infuriating to hit Escape and not have
the expected effect so I took it out.

~ Sorry, nerds :^)

_"How come I can't make my own keybindings >:I"_

I like these ones. You can fork the repo to make your own, or make a pull request if you want to set up managing an ini file :^)

#### The mouse moves too fast! (or too slow)

At the top of the file, mouse speed is controlled by two global variables, FORCE and RESISTANCE.
FORCE controls acceleration and RESISTANCE causes diminishing returns and implicitly creates a
terminal velocity.

Use the uncompiled .ahk script and you can change these to taste.

## Contact

Bug reports, questions, feature requests, and pull requests are all welcome.
Just open an issue on Github. (Or email me ! Don't be shy I'm really nice)
