-- Script
global frameQueue
global catchsnd
global g_MouseDownOnMe
global g_BackToMenuBtnMem
global backBtnflash
global btncnt
global loading

on mouseEnter me
  if sprite(me.spriteNum).memberNum = g_BackToMenuBtnMem then
    sprite(me.spriteNum).memberNum = g_BackToMenuBtnMem + 1
  end if
  pass()
end
on mouseLeave me
  if sprite(me.spriteNum).memberNum = g_BackToMenuBtnMem + 1 then
    sprite(me.spriteNum).memberNum = g_BackToMenuBtnMem
  end if
  pass()
end
on mouseDown me
  g_MouseDownOnMe = me.spriteNum
end
on mouseUp me
  if g_MouseDownOnMe then
    g_MouseDownOnMe = 0
    sprite(me.spriteNum).memberNum = g_BackToMenuBtnMem
    playSound(catchsnd, 255, 2, 0)
    if not loading then
      if backBtnflash = 0 then
        backBtnflash = btncnt
      end if
      dontPassEvent()
    end if
  end if
end