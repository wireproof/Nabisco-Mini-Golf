-- Script
global numPlayers
global select4

on mouseUp
  hbase = the locH of sprite the clickOn
  vbase = the locV of sprite the clickOn
  y1 = vbase + 61
  x2 = the mouseH
  y2 = the mouseV
  val = 0
  x1 = hbase + 40
  dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
  if dist < 400 then
    val = 1
  end if
  x1 = hbase + 100
  dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
  if dist < 400 then
    val = 2
  end if
  x1 = hbase + 160
  dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
  if dist < 400 then
    val = 3
  end if
  x1 = hbase + 220
  dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
  if dist < 400 then
    val = 4
  end if
  if val > 0 then
    numPlayers = val
    snd = the number of member "Click In.aif"
    playSound(snd, 255, 9)
    hide(select4)
  end if
end