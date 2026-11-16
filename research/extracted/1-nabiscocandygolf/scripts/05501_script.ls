-- Script
global btn1flash
global btn2flash
global btn3flash
global btn4flash
global btncnt
global loading

on mouseDown
  if voidp(btn1flash) then
    btn1flash = 0
  end if
  if loading = 0 then
    if btn1flash = 0 then
      btn1flash = btncnt
    end if
    dontPassEvent()
  end if
end