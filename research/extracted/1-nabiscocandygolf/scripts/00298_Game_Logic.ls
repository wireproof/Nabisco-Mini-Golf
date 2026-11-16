-- Behavior
global Projector
global standAlone
global loading
global nextname
global dest
global preloaded
global holeNumber
global scoreCard
global parList
global holeCompleted
global nextHole
global bestScore
global frameCtr
global frameTimer
global frameInit
global wasFrame
global state
global pause
global userControl
global goflg
global mouseFlag
global pi
global codeVersion
global mouseBasis
global speedConstant
global ballspr
global ballBase
global player
global numPlayers
global timeoutCount
global prioritySound
global musicChannel
global effectsChannel
global sound1shad
global sound2shad
global oldMouseH
global oldmouseV
global ballh
global ballv
global ballY
global ballBounce
global ballwidth
global ballState
global ballGravity
global oldballH
global wallHeight
global effects
global ballMagnitude
global ballAngle
global sinTable
global cosTable
global twopi
global anglePrime
global magprime
global atanTable
global gravamt
global score1spr
global score1mem
global currentSound
global ballshad
global balllow
global ballhigh
global obstaclespr
global shadmem
global obstacleshad
global obstaclemem
global putterAngle
global putterForce
global putterspr
global putterBase
global putterH
global putterV
global targetH
global targetV
global dispH
global dispV
global aboveflg
global belowflg
global ceiling
global wmult
global leftWall
global pmult
global floor
global rightWall
global walls0
global walls1
global walls2
global walls3
global walls4
global walls5
global walls6
global walls7
global walls8
global walls9
global wallv0
global wallv1
global wallv2
global wallv3
global wallv4
global wallv5
global wallv6
global wallv7
global wallv8
global wallv9
global walle0
global walle1
global walle2
global walle3
global walle4
global walle5
global walle6
global walle7
global walle8
global walle9
global plats0
global plats1
global plats2
global plats3
global plats4
global plats5
global plats6
global plats7
global plats8
global plats9
global platv0
global platv1
global platv2
global platv3
global platv4
global platv5
global platv6
global platv7
global platv8
global platv9
global plate0
global plate1
global plate2
global plate3
global plate4
global plate5
global plate6
global plate7
global plate8
global plate9
global insideFlg
global edge
global oldH
global oldV
global collflg
global ahit
global rightP
global L_edge
global R_edge
global wallAngle
global elasticity
global cupsnd
global bumpersnd
global bricksnd
global woodsnd
global catchsnd
global treesnd
global pipe1snd
global pipe2snd
global puttsnd
global swooshsnd
global bubsnd
global buzzsnd
global firesnd
global clanksnd
global holes
global holeCount
global exitPoint
global exitVec
global exitMag
global teePoints
global shelfPoints
global exitVecVal
global exitPointVal
global exitMagVal
global angle
global spdiff
global movingflag
global playerNamespr
global btnspr
global btn1flash
global btn2flash
global btn3flash
global btn4flash
global btncnt
global holeStrokes
global scoreCardFlag
global helpFlag
global cardspr
global blackNums
global redNums
global trailDigit1
global trailDigit2
global trailDigit3
global helpspr
global loadingspr
global loadtextmem
global ballPriority
global pipeTicks
global refract
global select4
global textScoremem
global scorecardmem
global helpbubmem
global helpbubspr
global scorespr
global lastscorespr
global numbase
global numdigits
global textflg
global textpos
global textchar
global textkern
global textseq
global gamePlayMode
global front9Score
global castmems
global loadedList
global loadingNum
global myNetIDList
global castNameList

on idle
end
on keyDown
  timeoutCount = 0
  showVersion()
end
on mouseDownCode
  pause = 0
  timeoutCount = 0
end
on mouseUpCode
end
on testDone
  if the runMode = "PlugIn" then
    if netDone() then
      return 1
    end if
  else
    return 0
  end if
end
on showhideHelp
  spr = helpspr + 1
  if the locH of sprite spr > 2000 then
    sprite(spr).visible = 0
  else
    sprite(spr).visible = 1
  end if
end
on enterFrame
  showhideHelp()
  if scoreCardFlag then
    repeat with spr = 120 to 131
      z = sprite(spr).locZ
      if z > cardspr then
        sprite(spr).locZ = cardspr - 3
      end if
    end repeat
  end if
  if numPlayers < 1 then
    show(select4)
    exit
  end if
  if the frame <> wasFrame then
    wasFrame = the frame
    puppetAll()
  end if
  if not voidp(ballState) then
    if not (getAt(ballState, 1) = #holeLoading or getAt(ballState, 1) = #gameover) then
      hide(loadingspr)
      hide(loadingspr + 1)
    end if
  end if
  hideCursor()
  if frameInit = 0 then
    set the timeoutLength to 20 * 60
    mouseFlag = the mouseDown
    codeInit()
  end if
  frameInit = 1
  clearVersion()
  if prioritySound > 0 then
    if not soundBusy(effectsChannel) then
      prioritySound = 0
      currentSound = 0
    end if
  end if
  flg = the mouseDown
  if mouseFlag <> flg then
    if flg then
      mouseDownCode()
    else
      mouseUpCode()
    end if
  end if
  mouseFlag = flg
  if flg then
  end if
  if btn1flash > 0 then
    btn1flash = btn1flash - 1
    if btn1flash mod 4 < 2 then
      hide(btnspr)
    else
      show(btnspr)
    end if
    if btn1flash <= 0 then
      if not scoreCardFlag then
        unflash()
        show(btnspr)
        helpFlag = 0
        hide(helpspr)
        hide(helpspr + 1)
        scoreCardFlag = 1
        showcard()
        buildCard()
      else
        scoreCardFlag = 0
        hidecard()
      end if
    end if
  else
    show(btnspr)
  end if
  if btn2flash > 0 then
    btn2flash = btn2flash - 1
    if btn2flash mod 4 < 2 then
      hide(btnspr + 1)
    else
      show(btnspr + 1)
    end if
    if btn2flash <= 0 then
      unflash()
      show(btnspr + 3)
      updateStage()
      goMenu()
      exit
    end if
  else
    show(btnspr + 1)
  end if
  if btn3flash > 0 then
    btn3flash = btn3flash - 1
    if btn3flash mod 4 < 2 then
      hide(btnspr + 2)
    else
      show(btnspr + 2)
    end if
    if btn3flash <= 0 then
      if not helpFlag then
        unflash()
        show(btnspr + 1)
        scoreCardFlag = 0
        hidecard()
        helpFlag = 1
        show(helpspr)
        show(helpspr + 1)
      else
        helpFlag = 0
        hide(helpspr)
        hide(helpspr + 1)
      end if
    end if
  else
    show(btnspr + 2)
  end if
  if btn4flash > 0 then
    btn4flash = btn4flash - 1
    if btn4flash mod 4 < 2 then
      hide(btnspr + 3)
    else
      show(btnspr + 3)
    end if
    if btn4flash <= 0 then
      unflash()
      show(btnspr + 2)
      updateStage()
      myExit()
    end if
  else
    show(btnspr + 3)
  end if
  if pause then
    set the volume of sound 1 to 0
    set the volume of sound 2 to 0
  else
    set the volume of sound 1 to sound1shad
    set the volume of sound 2 to sound2shad
  end if
  frameCtr = frameCtr + 1
  frameTimer = frameTimer + 1
  delayTimer = delayTimer + 1
  if logic2() then
    exit
  end if
  showPutter()
  flashPlayer()
end
on exitFrame
  if voidp(ballState) then
    go(the frame)
    exit
  end if
  st = getAt(ballState, 1)
  if st = #loadDone and nextHole > 0 then
    str = "Hole" & string(nextHole)
    frm = label(str)
    holeNumber = inithackv(nextHole)
    setAt(ballState, 1, #initHole)
    nextHole = 0
    goFrame(frm)
  else
    go(the frame)
  end if
end
on goMenu
  sound(#stop, effectsChannel)
  scoreCardFlag = 0
  helpFlag = 0
  ballState = [#initHole, #initHole, #initHole, #initHole]
  putOnShelf(1)
  putOnShelf(2)
  putOnShelf(3)
  putOnShelf(4)
  movingflag = 0
  scoreCard = duplicate(emptyList(18 * 4))
  clear()
  frameTimer = 1
  goFrame(2)
end
on myExit
  ballState = [#quitting, #quitting, #quitting, #quitting]
  case the runMode of
    "Author":
      put reportScore()
    "Plugin":
      if readhackv(bestScore) < 9999 then
        lowtmp = bestScore
        plyr = 1
        MD5 = 0
        exitPoint("nwmg", "ragsdakota", plyr, lowtmp, #lowscore, #nabisco, EMPTY, MD5, "IAMTHEGATEKEEPER")
      else
        gotoNetPage(dest)
      end if
    otherwise:
      quit()

  end case
end
on doPreload hol
  if the runMode contains "Plugin" then
    if not preloaded then
      id = preloadNetThing("Holes")
      preloaded = 1
    end if
  end if
end
on getLoadedList hol
  if hol < 1 or hol > count(loadedList) then
    return 1
  end if
  flg = getAt(loadedList, hol)
  return flg
end
on logic2
  st = getAt(ballState, 1)
  case st of
    #nextHole:
      str = "Loading Hole " & string(nextHole) & "... Please Wait"
      member(loadtextmem).text = str
      setAt(ballState, 1, #testload)
    #testload:
      testLoaded()
      if not getLoadedList(nextHole) then
        doPreload()
        show(loadingspr)
        show(loadingspr + 1)
      end if
      setAt(ballState, 1, #holeLoading)
    #holeLoading:
      testLoaded()
      if getLoadedList(nextHole) then
        hide(loadingspr)
        hide(loadingspr + 1)
        setAt(ballState, 1, #loadDone)
      end if
    #loadDone:
    #gameover:
      str = "Game Over"
      member(loadtextmem).text = str
      show(loadingspr)
      show(loadingspr + 1)

  end case
  return 0
end
on showcard
  if the frame < 10 then
    exit
  end if
  spr = cardspr - 2
  repeat with x = 0 to 50
    if not the puppet of sprite spr + x then
      set the puppet of sprite spr + x to 1
    end if
    show(spr + x)
  end repeat
  sho = 1
  if getAt(ballState, 1) <> #nextHole then
    sho = 0
  end if
  if not (gamePlayMode = #Practice) then
    sho = 0
  end if
  if not sho then
    hide(cardspr)
    hide(cardspr - 1)
  end if
  if readhackv(holeNumber) >= 10 then
    set the memberNum of sprite spr to scorecardmem + 1
  else
    set the memberNum of sprite spr to scorecardmem
  end if
end
on hidecard
  if the frame < 10 then
    exit
  end if
  spr = cardspr - 2
  repeat with x = 0 to 50
    if not the puppet of sprite spr + x then
      set the puppet of sprite spr + x to 1
    end if
    hide(spr + x)
  end repeat
end
on hideCursor
  pt = getAt(holes, 1)
  x1 = pt.locH
  y1 = pt.locV
  x2 = the mouseH
  y2 = the mouseV
  dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
  if dist < 2500 and the mouseH >= 90 and not (scoreCardFlag or helpFlag) then
    cursor(200)
  else
    cursor(-1)
  end if
end
on getTest lst, ind
  if ind < 0 or ind > count(lst) then
    return 0
  end if
  return getAt(lst, ind)
end
on getAtWalls ind
  val = ind - 1
  tbl = int(val / count(walls0))
  ind1 = val mod count(walls0) + 1
  case tbl of
    0:
      return getTest(walls0, ind1)
    1:
      return getTest(walls1, ind1)
    2:
      return getTest(walls2, ind1)
    3:
      return getTest(walls3, ind1)
    4:
      return getTest(walls4, ind1)
    5:
      return getTest(walls5, ind1)
    6:
      return getTest(walls6, ind1)
    7:
      return getTest(walls7, ind1)
    8:
      return getTest(walls8, ind1)
    9:
      return getTest(walls9, ind1)

  end case
end
on getAtWallv ind
  val = ind - 1
  tbl = int(val / count(walls0))
  ind1 = val mod count(walls0) + 1
  case tbl of
    0:
      return getTest(wallv0, ind1)
    1:
      return getTest(wallv1, ind1)
    2:
      return getTest(wallv2, ind1)
    3:
      return getTest(wallv3, ind1)
    4:
      return getTest(wallv4, ind1)
    5:
      return getTest(wallv5, ind1)
    6:
      return getTest(wallv6, ind1)
    7:
      return getTest(wallv7, ind1)
    8:
      return getTest(wallv8, ind1)
    9:
      return getTest(wallv9, ind1)

  end case
end
on getAtWalle ind
  val = ind - 1
  tbl = int(val / count(walls0))
  ind1 = val mod count(walls0) + 1
  case tbl of
    0:
      return getTest(walle0, ind1)
    1:
      return getTest(walle1, ind1)
    2:
      return getTest(walle2, ind1)
    3:
      return getTest(walle3, ind1)
    4:
      return getTest(walle4, ind1)
    5:
      return getTest(walle5, ind1)
    6:
      return getTest(walle6, ind1)
    7:
      return getTest(walle7, ind1)
    8:
      return getTest(walle8, ind1)
    9:
      return getTest(walle9, ind1)

  end case
end
on getAtPlats ind
  val = ind - 1
  tbl = int(val / count(plats0))
  ind1 = val mod count(plats0) + 1
  case tbl of
    0:
      return getTest(plats0, ind1)
    1:
      return getTest(plats1, ind1)
    2:
      return getTest(plats2, ind1)
    3:
      return getTest(plats3, ind1)
    4:
      return getTest(plats4, ind1)
    5:
      return getTest(plats5, ind1)
    6:
      return getTest(plats6, ind1)
    7:
      return getTest(plats7, ind1)
    8:
      return getTest(plats8, ind1)
    9:
      return getTest(plats9, ind1)

  end case
end
on getAtPlatv ind
  val = ind - 1
  tbl = int(val / count(plats0))
  ind1 = val mod count(plats0) + 1
  case tbl of
    0:
      return getTest(platv0, ind1)
    1:
      return getTest(platv1, ind1)
    2:
      return getTest(platv2, ind1)
    3:
      return getTest(platv3, ind1)
    4:
      return getTest(platv4, ind1)
    5:
      return getTest(platv5, ind1)
    6:
      return getTest(platv6, ind1)
    7:
      return getTest(platv7, ind1)
    8:
      return getTest(platv8, ind1)
    9:
      return getTest(platv9, ind1)

  end case
end
on getAtPlate ind
  val = ind - 1
  tbl = int(val / count(plats0))
  ind1 = val mod count(plats0) + 1
  case tbl of
    0:
      return getAt(plate0, ind1)
    1:
      return getAt(plate1, ind1)
    2:
      return getAt(plate2, ind1)
    3:
      return getAt(plate3, ind1)
    4:
      return getAt(plate4, ind1)
    5:
      return getAt(plate5, ind1)
    6:
      return getAt(plate6, ind1)
    7:
      return getAt(plate7, ind1)
    8:
      return getAt(plate8, ind1)
    9:
      return getAt(plate9, ind1)

  end case
end
on testH Hval
  rightP = 0
  L_edge = 0
  R_edge = 0
  wallind = (dispV - ceiling) * wmult
  if wallind < 0 then
    return 0
  end if
  edge = 1
  repeat with i = 1 to wmult
    hp = getAtWalls(wallind + i)
    if hp = 0 then
      exit repeat
    end if
    if hp < Hval then
      L_edge = edge
    end if
    if rightP = 0 then
      if hp > Hval then
        rightP = hp
        R_edge = edge
      end if
    end if
    if Hval = hp then
      getVecw(wallind + i)
      ahit = 1
      return ahit
    end if
    edge = 1 - edge
  end repeat
  if L_edge = 0 and R_edge = 1 then
    insideFlg = 1
  end if
  return ahit
end
on testV Vval
  botP = 999
  platind = (dispH - leftWall) * pmult
  if platind < 0 then
    return 0
  end if
  repeat with i = 1 to pmult
    vp = getAtPlats(platind + i)
    if vp = 0 then
      exit repeat
    end if
    if Vval = vp then
      getVecp(platind + i)
      ahit = 1
      exit repeat
    end if
  end repeat
  return ahit
end
on restoreH plyr
  setAt(ballh, plyr, oldH)
  dispH = integer(oldH)
end
on restoreV plyr
  setAt(ballv, plyr, oldV)
  dispV = integer(oldV)
end
on ballcoll i
  repeat with j = 1 to numPlayers
    if j = i then
      next repeat
    end if
    x1 = getAt(ballh, j)
    y1 = getAt(ballv, j)
    x2 = getAt(ballh, i)
    y2 = getAt(ballv, i)
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    if dist < 121 then
      if doHit(i, j) then
      end if
    end if
  end repeat
end
on calcHit i, j
  dH = float(getAt(ballh, i) - getAt(ballh, j))
  dV = float(getAt(ballv, i) - getAt(ballv, j))
  if dH = 0 then
    angle = 90
  else
    angle = atan(abs(dV) / abs(dH)) * 180 / PI
  end if
  if dH < 0 and dV >= 0 then
  else
    if dH >= 0 and dV >= 0 then
      angle = 180.0 - angle
    end if
    if dH >= 0 and dV < 0 then
      angle = angle + 180.0
    end if
    if dH < 0 and dV < 0 then
      angle = 360.0 - angle
    end if
  end if
  da = circ(angle - getAt(ballAngle, i))
  if da > 260 then
    da = da - 360
  end if
  if abs(da) > 89 then
    return 0
  end if
  if getAt(ballMagnitude, j) > getAt(ballMagnitude, i) then
    return 0
  end if
  spdiff = cos(da * PI / 180)
  if spdiff < 0.02 then
    spdiff = 0.02
  end if
  spdiff = getAt(ballMagnitude, i) * spdiff
  return 1
end
on doHit i, j
  if not calcHit(i, j) then
    return 0
  end if
  vectorAdd(spdiff, angle, j)
  angle = circ(angle + 180)
  vectorAdd(spdiff, angle, i)
  h = getAt(ballh, j)
  v = getAt(ballv, j)
  ang = angle * PI / 180.0
  dh1 = ballwidth * cos(ang)
  dv1 = ballwidth * sin(ang)
  setAt(ballh, i, h + dh1)
  setAt(ballv, i, v - dv1)
  vol = spdiff * 12
  if vol > 255 then
    vol = 255
  end if
  rnd = random(3) - 1
  playSound(puttsnd, vol, 4)
end
on invertH plyr
  ang = getAt(ballAngle, plyr) * PI / 180.0
  mag = getAt(ballMagnitude, plyr)
  dx = mag * cos(ang)
  dy = mag * sin(ang)
  dx = 0 - dx
  rect2polarBall(dx, dy, plyr)
  setAt(ballMagnitude, plyr, mag * 0.7)
end
on invertV plyr
  ang = getAt(ballAngle, plyr) * PI / 180.0
  mag = getAt(ballMagnitude, plyr)
  dx = mag * cos(ang)
  dy = mag * sin(ang)
  dy = 0 - dy
  rect2polarBall(dx, dy, plyr)
  setAt(ballMagnitude, plyr, mag * 0.7)
end