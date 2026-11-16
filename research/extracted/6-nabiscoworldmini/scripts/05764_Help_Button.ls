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
  if sprite(me.spriteNum).memberNum = member("help ro").memberNum then
    if loading = 0 then
      if helpBtnflash <= 0 then
        helpBtnflash = btncnt
        playSound(clickinsnd, 255, effectsChannel)
      end if
      dontPassEvent()
    end if
  end if
  pass()
end
on mouseEnter me
  if sprite(me.spriteNum).memberNum = member("help btn").memberNum then
    sprite(me.spriteNum).memberNum = member("help ro").memberNum
  end if
  pass()
end
on mouseLeave me
  if sprite(me.spriteNum).memberNum = member("help ro").memberNum then
    sprite(me.spriteNum).memberNum = member("help btn").memberNum
  end if
  pass()
end