-- Script
global btn1flash
global btn2flash
global btn3flash
global btn4flash
global btncnt
global loading

on mouseDown
  if voidp(btn2flash) then
    btn2flash = 0
  end if
  if loading = 0 then
    if btn2flash = 0 then
      btn2flash = btncnt
    end if
    dontPassEvent()
  end if
end
on enterFrame
  spr = the currentSpriteNum
  baseButton = the memberNum of sprite spr - 2
  offButton = baseButton
  if rollover(spr) then
    offButton = baseButton + 1
    set the memberNum of sprite spr to offButton
  end if
  if btn2flash > 0 then
    if btn2flash mod 4 < 2 then
      set the memberNum of sprite spr to baseButton + 2
      exit
    else
      set the memberNum of sprite spr to baseButton + 1
      exit
    end if
  else
    set the memberNum of sprite spr to offButton
  end if
end