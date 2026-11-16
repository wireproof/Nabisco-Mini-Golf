-- Behavior
on makeClaw spr
  if voidp(spr) then
    spr = 25
  end if
  cnt = 3
  frm = 110
  repeat while frm <= 130
    if frm = 110 then
      str = "*" & "**  "
    else
      str = str & "," & numToChar(194) & "*" & "**"
      put str
      str = "*" & "**  "
    end if
    com = ","
    repeat with w = 1 to cnt
      puppetOff()
      go(frm)
      updateStage()
      pt = the loc of sprite spr
      if w = cnt then
        com = EMPTY
      end if
      str = str & string(pt) & com
      frm = frm + 1
    end repeat
    cnter = cnter + 1
  end repeat
  str = str & numToChar(93) & "*" & "**"
  put str
end
on makeMonkey
  startFrame = label("Monkey Start")
  endFrame = label("Monkey End")
  puppetOff()
  go(startFrame)
  updateStage()
  membase = the memberNum of sprite 1
  repeat with frm = startFrame to endFrame
    goFrame(frm)
    updateStage()
    repeat with spr = 4 to 129
      mem = the memberNum of sprite spr
      if mem = 0 then
        next repeat
      end if
      xval = the locH of sprite spr
      yval = the locV of sprite spr
      str = "**" & "*"
      str = str & string(frm - startFrame) & ","
      str = str & string(spr) & ","
      str = str & string(mem - membase) & ","
      str = str & string(xval) & ","
      str = str & string(yval) & ","
      str = str & numToChar(194) & "**" & "*"
      put str
    end repeat
  end repeat
end