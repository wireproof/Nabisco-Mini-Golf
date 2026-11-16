-- Script
global helpFlag
global helpspr
global closeButtonTimer
global ballState
global frameQueue
global catchsnd
global closeButton
global gMouseDownOnMe
global g_cardCloseBtnSpr
global g_helpCloseBtnSpr

on mouseEnter me
  if sprite(me.spriteNum).memberNum = closeButton then
    sprite(me.spriteNum).memberNum = closeButton + 1
  end if
  pass()
end
on mouseLeave me
  if sprite(me.spriteNum).memberNum = closeButton + 1 then
    sprite(me.spriteNum).memberNum = closeButton
  end if
  pass()
end
on mouseDown
  gMouseDownOnMe = the clickOn
end
on mouseUp me
  if gMouseDownOnMe then
    gMouseDownOnMe = 0
    if ballState[1] = #holeLoading then
      exit
    end if
    sprite(me.spriteNum).memberNum = closeButton
    playSound(catchsnd, 255, 2, 0)
    if me.spriteNum > helpspr then
      closeButtonTimer = 10
    else
      closeButtonTimer = 110
    end if
  end if
end