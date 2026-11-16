-- Script
global scoreBtnflash
global helpBtnflash
global quitBtnflash
global menuBtnflash
global sendBtnflash
global btncnt
global loading
global clickinsnd
global effectsChannel

on mouseUp me
  if sprite(me.spriteNum).memberNum = member("quit ro").memberNum then
    if loading = 0 then
      if quitBtnflash <= 0 then
        quitBtnflash = btncnt
        playSound(clickinsnd, 255, effectsChannel)
      end if
    end if
  end if
  pass()
end
on mouseEnter me
  if sprite(me.spriteNum).memberNum = member("quit btn").memberNum then
    sprite(me.spriteNum).memberNum = member("quit ro").memberNum
  end if
  pass()
end
on mouseLeave me
  if sprite(me.spriteNum).memberNum = member("quit ro").memberNum then
    sprite(me.spriteNum).memberNum = member("quit btn").memberNum
  end if
  pass()
end