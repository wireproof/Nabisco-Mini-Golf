-- Script
global btn1flash
global btn2flash
global btn3flash
global btn4flash
global btncnt
global loading

on mouseDown
  if voidp(btn3flash) then
    btn3flash = 0
  end if
  if loading = 0 then
    if btn3flash = 0 then
      btn3flash = btncnt
    end if
    dontPassEvent()
  end if
end