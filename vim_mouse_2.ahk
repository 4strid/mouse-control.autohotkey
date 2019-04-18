#InstallKeybdHook

; vim_mouse_2.ahk
; vim bindings to control the mouse with the keyboard
; 
; Astrid Fesz-Nguyen
; 2019-04-14
;
; NOTE THE README IS WAY OUT OF DATE, THIS FILE IS WHERE TO LOOK TO SEE WHAT DO

global INSERT_MODE := true
global INSERT_QUICK := true
global NORMAL_MODE := false
global NORMAL_QUICK := false
global NORMAL_WASD := false

; Drag takes care of this now
;global MAX_VELOCITY := 72
global FORCE := 2.2
global RESISTANCE := 0.96

global VELOCITY_X := 0
global VELOCITY_Y := 0

Accelerate() {
  LEFT := 0
  DOWN := 0
  UP := 0
  RIGHT := 0
  
  LEFT := LEFT - GetKeyState("h", "P")
  DOWN := DOWN + GetKeyState("j", "P")
  UP := UP - GetKeyState("k", "P")
  RIGHT := RIGHT + GetKeyState("l", "P")
  
  if (NORMAL_WASD) {
    UP := UP -  GetKeyState("w", "P")
    LEFT := LEFT - GetKeyState("a", "P")
    DOWN := DOWN + GetKeyState("s", "P")
    RIGHT := RIGHT + GetKeyState("d", "P")
  }
  
  alt_down := GetKeyState("Alt", "P")
  win_down := GetKeyState("LWin", "P")
  
  If (NORMAL_QUICK) {
    If (alt_down == 0 && win_down == 0) {
      EnterInsertMode()
    }
  }
  
  If (INSERT_MODE) {
    VELOCITY_X := 0
    VELOCITY_Y := 0
    SetTimer,, Off
  }
  
  If (LEFT == 0 && RIGHT == 0) {
    VELOCITY_X := 0
  }
  Else If (LEFT + RIGHT == 0) {
    VELOCITY_X := Round(VELOCITY_X ** 0.92 - 1)
  }
  Else {
    VELOCITY_X := VELOCITY_X * RESISTANCE + FORCE * (LEFT + RIGHT)
  }
  
  If (UP == 0 && DOWN == 0) {
    VELOCITY_Y := 0
  }
  Else If (UP + DOWN == 0) {
    VELOCITY_Y := Round(VELOCITY_Y ** 0.92 - 1)
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
  If (NORMAL_MODE) {
    Return
  }
  msg := "NORMAL"
  If (NORMAL_WASD) {
    msg := msg . " (WASD)"
  }
  If (quick) {
    msg := msg . " (QUICK)"
  }
  ShowModePopup(msg)
  NORMAL_MODE := true
  NORMAL_QUICK := quick
  INSERT_MODE := false
  INSERT_QUICK := false

  SetTimer, Accelerate, 16
}

EnterWASDMode() {
  ShowModePopup("NORMAL (WASD)")
  NORMAL_WASD := true
  EnterNormalMode()
}

ExitWASDMode() {
  ShowModePopup("NORMAL")
  NORMAL_WASD := false
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
  NORMAL_WASD := false
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
  EnterNormalMode(quick)
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
  EnterNormalMode(quick)
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

JumpMiddle(quick:=false) {
  EnterNormalMode(quick)
  CoordMode, Mouse, Screen
  MouseMove, (A_ScreenWidth // 2), (A_ScreenHeight // 2)
}

JumpMiddle2(quick:=false) {
  EnterNormalMode(quick)
  CoordMode, Mouse, Screen
  MouseMove, (A_ScreenWidth + A_ScreenWidth // 2), (A_ScreenHeight // 2)
}

JumpMiddle3(quick:=false) {
  EnterNormalMode(quick)
  CoordMode, Mouse, Screen
  MouseMove, (A_ScreenWidth * 2 + A_ScreenWidth // 2), (A_ScreenHeight // 2)
}

JumpLeftEdge(quick:=false) {
  EnterNormalMode(quick)
  y := 0
  CoordMode, Mouse, Screen
  MouseGetPos,, y
  MouseMove, 2, y
}

JumpBottomEdge(quick:=false) {
  EnterNormalMode(quick)
  x := 0
  CoordMode, Mouse, Screen
  MouseGetPos, x
  MouseMove, x, (A_ScreenHeight - 0)
}

JumpTopEdge(quick:=false) {
  EnterNormalMode(quick)
  x := 0
  CoordMode, Mouse, Screen
  MouseGetPos, x
  MouseMove, x, 0
}

JumpRightEdge(quick:=false) {
  EnterNormalMode(quick)
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

ScrollUp4() {
  Click, WheelUp
  Click, WheelUp
  Click, WheelUp
  Click, WheelUp
  Return
}

ScrollDown4() {
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
  ^q:: EnterInsertMode()
  ; for Vimium hotlinks
  ^f:: EnterInsertMode(true)
  ~f:: EnterInsertMode(true)
  ; bind these in case win alt is still held down
  h:: Return
  j:: Return
  k:: Return
  l:: Return
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
  <#<!i:: MouseLeft()
  o:: MouseRight()
  <#<!o:: MouseRight()
  p:: MouseMiddle()
  <#<!p:: MouseMiddle()
  ; do not conflict with y as in "scroll up"
  +Y:: Yank()
  v:: Drag()
  +V:: RightDrag()
  +M:: JumpMiddle()
  ^H:: JumpMiddle3()
  ^L:: JumpMiddle2()
  n:: MouseForward()
  <#<!n:: MouseForward()
  b:: MouseBack()
  <#<!b:: MouseBack()
  ; allow for modifier keys (or more importantly a lack of them) by lifting ctrl requirement for these hotkeys
  u:: ScrollUp4()
  0:: ScrollDown()
  9:: ScrollUp()
  ]:: ScrollDown()
  [:: ScrollUp()
  +]:: ScrollDown4()
  +[:: ScrollUp4()
; Intersecting hotkeys
#If (NORMAL_MODE && NORMAL_WASD == false)
  q:: EnterInsertMode()
  e:: ScrollDown()
  y:: ScrollUp()
  d:: ScrollDown4()
  ^r:: EnterWASDMode()
  <#<!r:: EnterWASDMode()
  ; for windows explorer
#If (NORMAL_MODE && WinActive("ahk_class CabinetWClass"))
  ^h:: Send {Left}
  ^j:: Send {Down}
  ^k:: Send {Up}
  ^l:: Send {Right}
#If (INSERT_MODE)
  <#<!i:: EnterNormalMode()
  <#<!r:: EnterWASDMode()
  ; Normal (Quick) Mode
  <#<!h:: EnterNormalMode(true)
  <#<!j:: EnterNormalMode(true)
  <#<!k:: EnterNormalMode(true)
  <#<!l:: EnterNormalMode(true)
  <#<!+M:: JumpMiddle(true)
  <#<!+H:: JumpLeftEdge(true)
  <#<!+J:: JumpBottomEdge(true)
  <#<!+K:: JumpTopEdge(true)
  <#<!+L:: JumpRightEdge(true)
  ; Immediately issue commands
  <#<!o:: MouseRight()
  <#<!p:: MouseMiddle()
  <#<!v:: Drag()
  <#<!+V:: RightDrag()
  <#<!+Y:: Yank()
  <#<!n:: MouseForward()
  <#<!b:: MouseBack()
  <#<!e:: ScrollDown()
  <#<!y:: ScrollUp()
  <#<!d:: ScrollDown4()
  <#<!u:: ScrollUp4()
#If (INSERT_MODE && INSERT_QUICK)
  ^f:: EnterNormalMode()
  ^q:: EnterInsertMode()
#If (NORMAL_QUICK)
  ; Intercept movement keys
  <#<!h:: Return
  <#<!j:: Return
  <#<!k:: Return
  <#<!l:: Return
  ; commands
  <#<!i:: MouseLeft()
  <#<!o:: MouseRight()
  <#<!p:: MouseRight()
  <#<!+m:: JumpMiddle(true)
  ; FIXME: why are these a little glitchy?
  <#<!+H:: JumpLeftEdge(true)
  <#<!+J:: JumpBottomEdge(true)
  <#<!+K:: JumpTopEdge(true)
  <#<!+L:: JumpRightEdge(true)
  <#<!v:: Drag(true)
  <#<!+V:: RightDrag(true)
  <#<!y:: Yank(true)
  <#<!n:: MouseForward()
  <#<!b:: MouseBack()
  ; weird interactions with modifier keys, just go into insert mode if you want to scroll
  ;<#<!^e ScrollDown()
  ;<#<!^y ScrollUp()
  ;<#<!^d ScrollDown4()
  ;<#<!^u ScrollUp4()
#If (NORMAL_WASD)
  ^r:: ExitWASDMode()
  <#<!r:: ExitWASDMode()
  w:: Return
  a:: Return
  s:: Return
  d:: Return
  e:: ScrollDown()
  +E:: ScrollDown4()
  Space:: ScrollDown4()
  q:: ScrollUp()
  +Q:: ScrollUp4()
  r:: MouseLeft()
  t:: MouseRight()
  y:: MouseMiddle()
  m:: JumpMiddle()
#If

; FUTURE CONSIDERATIONS
; AwaitKey function for vimesque multi keystroke commands (gg, yy, 2M, etc)
; Better interop with Vimium for Chrome
; "Marks" for remembering and restoring specific windows (needs AwaitKey)
; Whatever you can think of! Github issues and pull requests welcome
