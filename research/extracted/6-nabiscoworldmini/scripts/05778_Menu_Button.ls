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
  if sprite(me.spriteNum).memberNum = member("menu ro").memberNum then
    if loading = 0 then
      if menuBtnflash <= 0 then
        menuBtnflash = btncnt
        playSound(clickinsnd, 255, effectsChannel)
      end if
    end if
  end if
  pass()
end
on mouseEnter me
  if sprite(me.spriteNum).memberNum = member("menu btn").memberNum then
    sprite(me.spriteNum).memberNum = member("menu ro").memberNum
  end if
  pass()
end
on mouseLeave me
  if sprite(me.spriteNum).memberNum = member("menu ro").memberNum then
    sprite(me.spriteNum).memberNum = member("menu btn").memberNum
  end if
  pass()
end