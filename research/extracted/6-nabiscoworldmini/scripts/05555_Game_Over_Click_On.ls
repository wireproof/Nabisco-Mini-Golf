-- Script
global g_gameOverClickOn
global g_showGameOver
global loadingspr

on mouseDown
  g_gameOverClickOn = 1
end
on mouseUp
  if g_gameOverClickOn = 1 then
    g_gameOverClickOn = 0
    if member(sprite(loadingspr + 1).memberNum).text contains "Game Over" then
      g_showGameOver = 0
    end if
  end if
end