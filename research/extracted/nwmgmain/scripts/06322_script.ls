-- Script
global btn1flash
global btn2flash
global btn3flash
global btn4flash
global btncnt
global loading

on mouseDown
  if voidp(btn4flash) then
    btn4flash = 0
  end if
  if loading = 0 then
    if btn4flash = 0 then
      btn4flash = btncnt
    end if
    dontPassEvent()
  end if
end