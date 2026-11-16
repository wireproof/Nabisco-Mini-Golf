-- Script
global g_selectPlayersCloseButtonTimer
global numPlayers
global g_numPlayers
global catchsnd
global btncnt
global g_selectPlayersSpr
global g_selectPlayersMem
global g_MouseDownOnMe
global g_maxPlayers
global playerType

on mouseEnter me
  spr = me.spriteNum
  num = spr - (g_selectPlayersSpr + 2)
  normState = g_selectPlayersMem + 2 * (num - 1)
  roState = normState + 1
  if sprite(spr).memberNum = normState then
    sprite(spr).memberNum = roState
  end if
  pass()
end
on mouseLeave me
  spr = me.spriteNum
  num = spr - (g_selectPlayersSpr + 2)
  normState = g_selectPlayersMem + 2 * (num - 1)
  roState = normState + 1
  if sprite(spr).memberNum = roState then
    sprite(spr).memberNum = normState
  end if
  pass()
end
on mouseDown me
  g_MouseDownOnMe = me.spriteNum
end
on mouseUp me
  spr = me.spriteNum
  if g_MouseDownOnMe = spr then
    num = spr - (g_selectPlayersSpr + 2)
    normState = g_selectPlayersMem + 2 * (num - 1)
    roState = normState + 1
    sprite(spr).memberNum = roState
    g_selectPlayersCloseButtonTimer = btncnt
    numPlayers = num
    g_numPlayers = num
    playSound(catchsnd, 255, 2, 0)
  end if
end