#InstallKeybdHook

; vim_mouse_2.ahk
; vim (and now also WASD!) bindings to control the mouse with the keyboard
; 
; Astrid Fesz-Nguyen
; 2019-04-14
;
; Last updated 2019-04-20

global INSERT_MODE := false
global INSERT_QUICK := false
global NORMAL_MODE := false
global NORMAL_QUICK := false
global WASD := false

; Drag takes care of this now
;global MAX_VELOCITY := 72

; mouse speed variables
global FORCE := 2
global RESISTANCE := 0.965

global VELOCITY_X := 0
global VELOCITY_Y := 0

EnterNormalMode()

Accelerate() {
  LEFT := 0
  DOWN := 0
  UP := 0
  RIGHT := 0
  
  LEFT := LEFT - GetKeyState("h", "P")
  DOWN := DOWN + GetKeyState("j", "P")
  UP := UP - GetKeyState("k", "P")
  RIGHT := RIGHT + GetKeyState("l", "P")
  
  if (WASD) {
    UP := UP -  GetKeyState("w", "P")
    LEFT := LEFT - GetKeyState("a", "P")
    DOWN := DOWN + GetKeyState("s", "P")
    RIGHT := RIGHT + GetKeyState("d", "P")
  }
  
  alt_down := GetKeyState("Alt", "P")
  lwin_down := GetKeyState("LWin", "P")
  rwin_down := GetKeyState("LWin", "P")
  
  If (NORMAL_QUICK) {
    IF (WASD && alt_down == 0 && rwin_down == 0) {
      EnterInsertMode()
    } Else If (alt_down == 0 && lwin_down == 0) {
      EnterInsertMode()
    }
  }
  
  If (NORMAL_MODE == false) {
    VELOCITY_X := 0
    VELOCITY_Y := 0
    SetTimer,, Off
  }
  
  If (LEFT == 0 && RIGHT == 0) {
    VELOCITY_X := 0
  }
  Else If (LEFT + RIGHT == 0) {
    VELOCITY_X := VELOCITY_X * 0.666
  }
  Else {
    VELOCITY_X := VELOCITY_X * RESISTANCE + FORCE * (LEFT + RIGHT)
  }
  
  If (UP == 0 && DOWN == 0) {
    VELOCITY_Y := 0
  }
  Else If (UP + DOWN == 0) {
    VELOCITY_Y := VELOCITY_Y * 0.666
  }
  Else {
    VELOCITY_Y := VELOCITY_Y * RESISTANCE + FORCE * (UP + DOWN)
  }
  ;MsgBox, %_MODE%
  ;msg1 := "h " . LEFT . " j  " . DOWN . " k " . UP . " l " . RIGHT
  ;MsgBox, %msg1%
  ;msg2 := "Moving " . VELOCITY_X . " " . VELOCITY_Y
  ;MsgBox, %msg2%
  MouseMove, %VELOCITY_X%, %VELOCITY_Y%, 0, R
}

EnterNormalMode(quick:=false) {
  ;MsgBox, "Welcome to Normal Mode"
  NORMAL_QUICK := quick

  If (NORMAL_MODE) {
    Return
  }
  msg := "NORMAL"
  If (WASD) {
    msg := msg . " (WASD)"
  }
  If (quick) {
    msg := msg . " (QUICK)"
  }
  ShowModePopup(msg)
  NORMAL_MODE := true
  INSERT_MODE := false
  INSERT_QUICK := false

  SetTimer, Accelerate, 16
}

EnterWASDMode(quick:=false) {
  msg := "NORMAL (WASD)"
  If (quick) {
    msg := msg . " (QUICK)"
  }
  ShowModePopup(msg)
  WASD := true
  EnterNormalMode(quick)
}

ExitWASDMode() {
  ShowModePopup("NORMAL")
  WASD := false
}

EnterInsertMode(quick:=false) {
  ;MsgBox, "Welcome to Insert Mode"
  msg := "INSERT"
  If (quick) {
    msg := msg . " (QUICK)"
  }
  ShowModePopup(msg)
  INSERT_MODE := true
  INSERT_QUICK := quick
  NORMAL_MODE := false
  NORMAL_QUICK := false
}

ClickInsert() {
  Click
  EnterInsertMode(true)
}

DoubleClickInsert() {
  Click
  Sleep, 50
  Click
  EnterInsertMode(true)
}

ShowModePopup(msg) {
  ; clean up any lingering popups
  ClosePopup()
  y := A_ScreenHeight - 50
  Progress, b x15 y%y% zh0,, %msg%,
  SetTimer, ClosePopup, -1600
}

ClosePopup() {
  Progress, Off
}

Drag(quick:=false) {
  Click, Down
}

Yank(quick:=false) {
  width := 0
  WinGetPos,,,width,,A
  center := width / 2
  ;MsgBox, Hello %width% %center%
  MouseMove, Center, 10
  Drag(quick)
}

RightDrag(quick:=false) {
  Click, Right, Down
}

MouseLeft() {
  Click
}

MouseRight() {
  Click, Right
}

MouseMiddle() {
  Click, Middle
}

; TODO: When we have more monitors, set up H and L to use current screen as basis
; hard to test when I only have the one

JumpMiddle() {
  CoordMode, Mouse, Screen
  MouseMove, (A_ScreenWidth // 2), (A_ScreenHeight // 2)
}

JumpMiddle2() {
  CoordMode, Mouse, Screen
  MouseMove, (A_ScreenWidth + A_ScreenWidth // 2), (A_ScreenHeight // 2)
}

JumpMiddle3() {
  CoordMode, Mouse, Screen
  MouseMove, (A_ScreenWidth * 2 + A_ScreenWidth // 2), (A_ScreenHeight // 2)
}

JumpLeftEdge() {
  y := 0
  CoordMode, Mouse, Screen
  MouseGetPos,, y
  MouseMove, 2, y
}

JumpBottomEdge() {
  x := 0
  CoordMode, Mouse, Screen
  MouseGetPos, x
  MouseMove, x, (A_ScreenHeight - 0)
}

JumpTopEdge() {
  x := 0
  CoordMode, Mouse, Screen
  MouseGetPos, x
  MouseMove, x, 0
}

JumpRightEdge() {
  y := 0
  CoordMode, Mouse, Screen
  MouseGetPos,, y
  MouseMove, (A_ScreenWidth - 2), y
}

MouseBack() {
  Click, X1
}

MouseForward() {
  Click, X2
}

ScrollUp() {
  Click, WheelUp
}

ScrollDown() {
  Click, WheelDown
}

ScrollUpMore() {
  Click, WheelUp
  Click, WheelUp
  Click, WheelUp
  Click, WheelUp
  Return
}

ScrollDownMore() {
  Click, WheelDown
  Click, WheelDown
  Click, WheelDown
  Click, WheelDown
  Return
}


; BINDINGS
#If (NORMAL_MODE)
  ; I hate not being able to press Escape
  ; Esc EnterInsertMode()
  ; I think this is the winner
  <#<!Enter:: EnterInsertMode()
  <#<!Space:: EnterInsertMode()
  ; well, ^q isn't hurting anyone
  ^q:: EnterInsertMode()
  ; another option I tried that I'll just leave in
  `:: EnterInsertMode()
  ; what the hell, have another
  Insert:: EnterInsertMode()
  ; these don't work super well (hence omission from README) but are nice when they do
  <#<!+I:: ClickInsert()
  <#<!^i:: DoubleClickInsert()
  ; passthru for Vimium hotlinks 
  ~f:: EnterInsertMode(true)
  ; passthru to common "search" hotkey
  ~^f:: EnterInsertMode(true)
  ; passthru for quick edits
  ~Delete:: EnterInsertMode(true)
  ~Backspace:: EnterInsertMode(true)
  ; do not pass thru
  +;:: EnterInsertMode(true)
  +F:: EnterInsertMode(true)
  c:: EnterInsertMode(true)
  ; intercept movement keys
  h:: Return
  j:: Return
  k:: Return
  l:: Return
  ; bind these in case win alt is still held down
  <#<!h:: Return
  <#<!j:: Return
  <#<!k:: Return
  <#<!l:: Return
  +H:: JumpLeftEdge()
  +J:: JumpBottomEdge()
  +K:: JumpTopEdge()
  +L:: JumpRightEdge()
  ; commands
  i:: MouseLeft()
  ^i:: MouseLeft()
  +I:: MouseLeft()
  !i:: MouseLeft()
  o:: MouseRight()
  p:: MouseMiddle()
  ; do not conflict with y as in "scroll up"
  +Y:: Yank()
  v:: Drag()
  +V:: RightDrag()
  +M:: JumpMiddle()
  ^H:: JumpMiddle3()
  ^L:: JumpMiddle2()
  n:: MouseForward()
  b:: MouseBack()
  ; allow for modifier keys (or more importantly a lack of them) by lifting ctrl requirement for these hotkeys
  u:: ScrollUpMore()
  0:: ScrollDown()
  9:: ScrollUp()
  ]:: ScrollDown()
  [:: ScrollUp()
  +]:: ScrollDownMore()
  +[:: ScrollUpMore()

  ; rebind everything (except i) in case you don't release win alt upon entering normal mode
  <#<!i:: MouseLeft()
  <#<!o:: MouseRight()
  <#<!p:: MouseMiddle()
  <#<!n:: MouseForward()
  <#<!b:: MouseBack()
  <#<!+m:: JumpMiddle()
  <#<!^h:: JumpLeftEdge()
  <#<!^j:: JumpBottomEdge()
  <#<!^k:: JumpTopEdge()
  <#<!^l:: JumpRightEdge()
  <#<!v:: Drag()
  <#<!+V:: RightDrag()
  <#<!e:: ScrollDown()
  <#<!y:: ScrollUp()
  <#<!d:: ScrollDownMore()
  <#<!u:: ScrollUpMore()
  <#<!0:: ScrollDown()
  <#<!9:: ScrollUp()
; Intersecting hotkeys
#If (NORMAL_MODE && WASD == false)
  <#<!r:: EnterWASDMode()
  e:: ScrollDown()
  y:: ScrollUp()
  d:: ScrollDownMore()
  ; Normal (Quick/WASD) Mode
  !>#w:: EnterWASDMode(true)
  !>#a:: EnterWASDMode(true)
  !>#s:: EnterWASDMode(true)
  !>#d:: EnterWASDMode(true)
  ; for windows explorer
#If (NORMAL_MODE && WinActive("ahk_class CabinetWClass"))
  ^h:: Send {Left}
  ^j:: Send {Down}
  ^k:: Send {Up}
  ^l:: Send {Right}
#If (INSERT_MODE)
  ; we'll see which one we like, or probably just leave both
  <#<!Enter:: EnterNormalMode()
  <#<!Space:: EnterNormalMode()
  Home:: EnterNormalMode()
  ; Normal (Quick) Mode
  <#<!h:: EnterNormalMode(true)
  <#<!j:: EnterNormalMode(true)
  <#<!k:: EnterNormalMode(true)
  <#<!l:: EnterNormalMode(true)
  ; Normal (Quick/WASD) Mode
  !>#w:: EnterWASDMode(true)
  !>#a:: EnterWASDMode(true)
  !>#s:: EnterWASDMode(true)
  !>#d:: EnterWASDMode(true)
  ; Immediately issue commands
  <#<!+M:: JumpMiddle()
  <#<!+H:: JumpLeftEdge()
  <#<!+J:: JumpBottomEdge()
  <#<!+K:: JumpTopEdge()
  <#<!+L:: JumpRightEdge()
  <#<!i:: MouseLeft()
  <#<!o:: MouseRight()
  <#<!p:: MouseMiddle()
  <#<!n:: MouseForward()
  <#<!b:: MouseBack()
  <#<!v:: Drag()
  <#<!+V:: RightDrag()
  <#<!+Y:: Yank()
  <#<!e:: ScrollDown()
  <#<!y:: ScrollUp()
  <#<!d:: ScrollDownMore()
  <#<!u:: ScrollUpMore()
  <#<!0:: ScrollDown()
  <#<!9:: ScrollUp()
#If (INSERT_MODE && INSERT_QUICK)
  ^f:: EnterNormalMode()
  ~Enter:: EnterNormalMode()
  ~^c:: EnterNormalMode()
#If (NORMAL_MODE && WASD)
  <#<!r:: ExitWASDMode()
  ; Intercept movement keys
  w:: Return
  a:: Return
  s:: Return
  d:: Return
  ; Intercept WASD/Quick movement keys
  !>#w:: Return
  !>#a:: Return
  !>#s:: Return
  !>#d:: Return
  e:: ScrollDown()
  +E:: ScrollDownMore()
  Space:: ScrollDownMore()
  q:: ScrollUp()
  +Q:: ScrollUpMore()
  r:: MouseLeft()
  t:: MouseRight()
  y:: MouseMiddle()
  m:: JumpMiddle()
#If

; FUTURE CONSIDERATIONS
; AwaitKey function for vimesque multi keystroke commands (gg, yy, 2M, etc)
; "Marks" for remembering and restoring mouse positions (needs AwaitKey)
; Whatever you can think of! Github issues and pull requests welcome
