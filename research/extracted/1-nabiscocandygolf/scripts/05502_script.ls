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