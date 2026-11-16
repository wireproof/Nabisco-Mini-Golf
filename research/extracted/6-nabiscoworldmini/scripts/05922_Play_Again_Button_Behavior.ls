-- Script
global frameQueue
global catchsnd
global g_MouseDownOnMe
global g_playAgainBtnMem
global againBtnflash
global btncnt
global loading

on mouseEnter me
  if sprite(me.spriteNum).memberNum = g_playAgainBtnMem then
    sprite(me.spriteNum).memberNum = g_playAgainBtnMem + 1
  end if
  pass()
end
on mouseLeave me
  if sprite(me.spriteNum).memberNum = g_playAgainBtnMem + 1 then
    sprite(me.spriteNum).memberNum = g_playAgainBtnMem
  end if
  pass()
end
on mouseDown me
  g_MouseDownOnMe = me.spriteNum
end
on mouseUp me
  if g_MouseDownOnMe then
    g_MouseDownOnMe = 0
    sprite(me.spriteNum).memberNum = g_playAgainBtnMem
    playSound(catchsnd, 255, 2, 0)
    if not loading then
      if againBtnflash = 0 then
        againBtnflash = btncnt
      end if
      dontPassEvent()
    end if
  end if
end