-- Script
global helpFlag
global helpspr
global catchsnd
global effectsChannel

on mouseUp
  displayHelp(0)
  playSound(catchsnd, 255, effectsChannel)
  dontPassEvent()
end