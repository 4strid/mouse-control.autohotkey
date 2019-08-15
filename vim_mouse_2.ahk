#InstallKeybdHook

; vim_mouse_2.ahk
; vim (and now also WASD!) bindings to control the mouse with the keyboard
; 
; Astrid Fesz-Nguyen
; 2019-04-14
;
; Last updated 2019-06-24

global INSERT_MODE := false
global INSERT_QUICK := false
global NORMAL_MODE := false
global NORMAL_QUICK := false
global WASD := true

; Drag takes care of this now
;global MAX_VELOCITY := 72

; mouse speed variables
global FORCE := 1.8
global RESISTANCE := 0.982

global VELOCITY_X := 0
global VELOCITY_Y := 0

global POP_UP := false

; Insert Mode by default
EnterInsertMode()

Accelerate(velocity, pos, neg) {
  If (pos == 0 && neg == 0) {
    Return 0
  }
  ; smooth deceleration :)
  Else If (pos + neg == 0) {
    Return velocity * 0.666
  }
  ; physicszzzzz
  Else {
    Return velocity * RESISTANCE + FORCE * (pos + neg)
  }
}

MoveCursor() {
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
  
  If (NORMAL_QUICK) {
    caps_down := GetKeyState("Capslock", "P")
    IF (caps_down == 0) {
      EnterInsertMode()
    }
  }
  
  If (NORMAL_MODE == false) {
    VELOCITY_X := 0
    VELOCITY_Y := 0
    SetTimer,, Off
  }
  
  VELOCITY_X := Accelerate(VELOCITY_X, LEFT, RIGHT)
  VELOCITY_Y := Accelerate(VELOCITY_Y, UP, DOWN)

  MouseMove, %VELOCITY_X%, %VELOCITY_Y%, 0, R

  ;(humble beginnings)
  ;MsgBox, %NORMAL_MODE%
  ;msg1 := "h " . LEFT . " j  " . DOWN . " k " . UP . " l " . RIGHT
  ;MsgBox, %msg1%
  ;msg2 := "Moving " . VELOCITY_X . " " . VELOCITY_Y
  ;MsgBox, %msg2%
}

EnterNormalMode(quick:=false) {
  ;MsgBox, "Welcome to Normal Mode"
  NORMAL_QUICK := quick

  msg := "NORMAL"
  If (WASD == false) {
    msg := msg . " (VIM)"
  }
  If (quick) {
    msg := msg . " (QUICK)"
  }
  ShowModePopup(msg)

  If (NORMAL_MODE) {
    Return
  }
  NORMAL_MODE := true
  INSERT_MODE := false
  INSERT_QUICK := false

  SetTimer, MoveCursor, 16
}

EnterWASDMode(quick:=false) {
  msg := "NORMAL"
  If (quick) {
    msg := msg . " (QUICK)"
  }
  ShowModePopup(msg)
  WASD := true
  EnterNormalMode(quick)
}

ExitWASDMode() {
  ShowModePopup("NORMAL (VIM)")
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

ClickInsert(quick:=true) {
  Click
  EnterInsertMode(quick)
}

; FIXME:
; doesn't really work well
DoubleClickInsert(quick:=true) {
  Click
  Sleep, 100
  Click
  EnterInsertMode(quick)
}

ShowModePopup(msg) {
  ; clean up any lingering popups
  ClosePopup()
  center := MonitorLeftEdge() + (A_ScreenWidth // 2)
  popx := center - 150
  popy := (A_ScreenHeight // 2) - 28
  Progress, b x%popx% y%popy% zh0 w300 h56 fm24,, %msg%,,SimSun
  SetTimer, ClosePopup, -1600
  POP_UP := true
}

ClosePopup() {
  Progress, Off
  POP_UP := false
}

Drag() {
  Click, Down
}

Yank() {
  wx := 0
  wy := 0
  width := 0
  WinGetPos,wx,wy,width,,A
  center := wx + width - 180
  y := wy + 12
  ;MsgBox, Hello %width% %center%
  MouseMove, center, y
  Drag()
}

RightDrag() {
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

MonitorLeftEdge() {
  mx := 0
  CoordMode, Mouse, Screen
  MouseGetPos, mx
  monitor := (mx // A_ScreenWidth)

  return monitor * A_ScreenWidth
}

JumpLeftEdge() {
  x := MonitorLeftEdge() + 2
  y := 0
  CoordMode, Mouse, Screen
  MouseGetPos,,y
  MouseMove, x,y
}

JumpBottomEdge() {
  x := 0
  CoordMode, Mouse, Screen
  MouseGetPos, x
  MouseMove, x,(A_ScreenHeight - 0)
}

JumpTopEdge() {
  x := 0
  CoordMode, Mouse, Screen
  MouseGetPos, x
  MouseMove, x,0
}

JumpRightEdge() {
  x := MonitorLeftEdge() + A_ScreenWidth - 2
  y := 0
  CoordMode, Mouse, Screen
  MouseGetPos,,y
  MouseMove, x,y
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


; "FINAL" MODE SWITCH BINDINGS
Home:: EnterNormalMode()
Insert:: EnterInsertMode()
<#<!n:: EnterNormalMode()
<#<!i:: EnterInsertMode()

; escape hatches
+Home:: Send, {Home}
+Insert:: Send, {Insert}
;FIXME
; doesn't turn caplsock off.
^Capslock:: Send, {Capslock}
; meh. good enough.
^+Capslock:: SetCapsLockState, Off


#If (NORMAL_MODE)
  ; focus window and enter Insert
  +`:: ClickInsert(false)
  ; Many paths to Quick Insert
  `:: ClickInsert(true)
  +S:: DoubleClickInsert()
  ; passthru for Vimium hotlinks 
  ~f:: EnterInsertMode(true)
  ; passthru to common "search" hotkey
  ~^f:: EnterInsertMode(true)
  ; passthru for new tab
  ~^t:: EnterInsertMode(true)
  ; passthru for quick edits
  ~Delete:: EnterInsertMode(true)
  ; do not pass thru
  +;:: EnterInsertMode(true)
  ; intercept movement keys
  h:: Return
  j:: Return
  k:: Return
  l:: Return
  +H:: JumpLeftEdge()
  +J:: JumpBottomEdge()
  +K:: JumpTopEdge()
  +L:: JumpRightEdge()
  ; commands
  *i:: MouseLeft()
  *o:: MouseRight()
  *p:: MouseMiddle()
  ; do not conflict with y as in "scroll up"
  +Y:: Yank()
  v:: Drag()
  z:: RightDrag()
  +M:: JumpMiddle()
  +,:: JumpMiddle2()
  +.:: JumpMiddle3()
  ; ahh what the heck, remove shift requirements for jump bindings
  ; maybe take "m" back if we ever make marks
  m:: JumpMiddle()
  ,:: JumpMiddle2()
  .:: JumpMiddle3()
  n:: MouseForward()
  b:: MouseBack()
  ; allow for modifier keys (or more importantly a lack of them) by lifting ctrl requirement for these hotkeys
  u:: ScrollUpMore()
  *0:: ScrollDown()
  *9:: ScrollUp()
  ]:: ScrollDown()
  [:: ScrollUp()
  +]:: ScrollDownMore()
  +[:: ScrollUpMore()
  End:: Click, Up
#If (NORMAL_MODE && NORMAL_QUICK == false)
  Capslock:: EnterInsertMode(true)
  +Capslock:: EnterInsertMode()
; Addl Vim hotkeys that conflict with WASD mode
#If (NORMAL_MODE && WASD == false)
  <#<!r:: EnterWASDMode()
  e:: ScrollDown()
  y:: ScrollUp()
  d:: ScrollDownMore()
; No shift requirements in normal quick mode
#If (NORMAL_MODE && NORMAL_QUICK)
  Capslock:: Return
  m:: JumpMiddle()
  ,:: JumpMiddle2()
  .:: JumpMiddle3()
  y:: Yank()
  ; for windows explorer
#If (NORMAL_MODE && WinActive("ahk_class CabinetWClass"))
  ^h:: Send {Left}
  ^j:: Send {Down}
  ^k:: Send {Up}
  ^l:: Send {Right}
#If (INSERT_MODE)
  ; Normal (Quick) Mode
#If (INSERT_MODE && INSERT_QUICK == false)
  Capslock:: EnterNormalMode(true)
  +Capslock:: EnterNormalMode()
#If (INSERT_MODE && INSERT_QUICK)
  ~Enter:: EnterNormalMode()
  ; Copy and return to Normal Mode
  ~^c:: EnterNormalMode()
  Escape:: EnterNormalMode()
  Capslock:: EnterNormalMode()
#If (NORMAL_MODE && WASD)
  <#<!r:: ExitWASDMode()
  ; Intercept movement keys
  w:: Return
  a:: Return
  s:: Return
  d:: Return
  +C:: JumpMiddle()
  +W:: JumpTopEdge()
  +A:: JumpLeftEdge()
  +S:: JumpBottomEdge()
  +D:: JumpRightEdge()
  *e:: ScrollDown()
  *q:: ScrollUp()
  *r:: MouseLeft()
  t:: MouseRight()
  +T:: MouseRight()
  *y:: MouseMiddle()
#If (POP_UP)
  Escape:: ClosePopup()
#If

; FUTURE CONSIDERATIONS
; AwaitKey function for vimesque multi keystroke commands (gg, yy, 2M, etc)
; "Marks" for remembering and restoring mouse positions (needs AwaitKey)
; v to let go of mouse when mouse is down with v (lemme crop in Paint.exe)
; z for click and release middle mouse? this has historically not worked well
; c guess that leaves c for hold / release right mouse (x is useful in chronmium)
; Whatever you can think of! Github issues and pull requests welcome
