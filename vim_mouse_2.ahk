#InstallKeybdHook

; vim_mouse_2.ahk
; vim bindings to control the mouse with the keyboard
; 
; Astrid Fesz-Nguyen
; 2019-04-14

global INSERT_MODE := true
global INSERT_QUICK := true
global NORMAL_MODE := false
global NORMAL_QUICK := false
global NORMAL_WASD := false

global LEFT := 0
global DOWN := 0
global UP := 0
global RIGHT := 0

global MAX_VELOCITY := 27

Accelerate() {

  velocityX := 0
  velocityY := 0

  Loop {
    LEFT := 0
    DOWN := 0
    UP := 0
    RIGHT := 0

    LEFT := LEFT - 1 * GetKeyState("h", "P")
    DOWN := DOWN + GetKeyState("j", "P")
    UP := UP - 1 * GetKeyState("k", "P")
    RIGHT := RIGHT + GetKeyState("l", "P")

    if (NORMAL_WASD) {
      UP := UP - 1 * GetKeyState("w", "P")
      LEFT := LEFT - 1 * GetKeyState("a", "P")
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
      Break
    }

    If (LEFT == 0 && RIGHT == 0) {
      velocityX := 0
    }
    Else If (LEFT + RIGHT == 0) {
      velocityX := velocityX * 0.66
    }
    Else If (LEFT + RIGHT < 0) {
      velocityX := Max(velocityX + 0.9 * LEFT + 0.9 * RIGHT, -1 * MAX_VELOCITY)
    }
    Else If (LEFT + RIGHT > 0) {
      velocityX := Min(velocityX + 0.9 * LEFT + 0.9 * RIGHT, MAX_VELOCITY)
    }

    If (UP == 0 && DOWN == 0) {
      velocityY := 0
    }
    Else If (UP + DOWN == 0) {
      velocityY := velocityY * 0.66
    }
    Else If (UP + DOWN < 0) {
      velocityY := Max(velocityY + 0.7 * UP + 0.7 * DOWN, -1 * MAX_VELOCITY)
    }
    Else If (UP + DOWN > 0) {
      velocityY := Min(velocityY + 0.7 * UP + 0.7 * DOWN, MAX_VELOCITY)
    }
    ;MsgBox, %_MODE%
    ;msg1 := "h " . LEFT . " j  " . DOWN . " k " . UP . " l " . RIGHT
    ;MsgBox, %msg1%
    ;msg2 := "Moving " . velocityX . " " . velocityY
    ;MsgBox, %msg2%
    MouseMove, %velocityX%, %velocityY%, 0, R
    Sleep 15.6
  }
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

  Accelerate()
}

EnterWASDMode() {
  NORMAL_WASD := true
  EnterNormalMode()
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
  ^q:: EnterInsertMode(true)
  <#<!r:: EnterWASDMode()
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
  y:: ScrollUp()
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
  h:: Return
  j:: Return
  k:: Return
  l:: Return
  e:: ScrollDown()
  d:: ScrollDown4()
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
  ^q:: EnterNormalMode()
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
  <#<!x:: EnterInsertMode()
  w:: Return
  a:: Return
  s:: Return
  d:: Return
  e:: ScrollDown()
  q:: ScrollUp()
  Space:: ScrollDown4()
  r:: MouseLeft()
  t:: MouseRight()
  h:: JumpLeftEdge()
  j:: JumpBottomEdge()
  k:: JumpTopEdge()
  l:: JumpRightEdge()
  m:: JumpMiddle()
#If

; FUTURE CONSIDERATIONS
; AwaitKey function for vimesque multi keystroke commands (gg, yy, 2M, etc)
; Better interop with Vimium for Chrome
; "Marks" for remembering and restoring specific windows (needs AwaitKey)
; Whatever you can think of! Github issues and pull requests welcome
