-- Script
global helpFlag
global helpspr

on mouseUp
  helpFlag = 0
  hide(helpspr)
  hide(helpspr + 1)
  dontPassEvent()
end