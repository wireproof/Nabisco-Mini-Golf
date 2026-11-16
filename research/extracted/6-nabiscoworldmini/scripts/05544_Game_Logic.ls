-- Behavior
global Projector
global standAlone
global loading
global nextname
global dest
global preloaded
global holeNumber
global holeNumberDeb
global scoreCard
global parList
global holeCompleted
global nextHole
global bestScore
global holeImplemented
global frameCtr
global frameTimer
global frameInit
global wasFrame
global state
global pause
global userControl
global goflg
global mouseFlag
global g_numberOfHoles
global g_maxStrokes
global g_maxPlayers
global g_brandingSponsors
global g_menuBaseSpr
global codeVersion
global theStageWidth
global theStageHeight
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
global ballStateTimer
global ballScreen
global ballRegion
global ballGravity
global oldballH
global ballForce
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
global scoreDigitmem
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
global rubberbandspr
global putterBase
global putterH
global putterV
global putterScreen
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
global groundLevel
global holes
global holeCount
global exitPoint
global exitVec
global exitVecRnd
global exitMag
global exitMagRnd
global teePoints
global shelfPoints
global currentScreen
global golferState
global oldGolferState
global golferStateTimer
global golferAnim
global exitVecVal
global exitPointVal
global exitMagVal
global angle
global spdiff
global movingflag
global playerNamespr
global historyspr
global historymem
global historyText
global guiBtnBaseSpr
global btnmem
global sendbtnspr
global chatselspr
global lineV
global lineText
global lineCursorV
global scoreBtnflash
global helpBtnflash
global quitBtnflash
global menuBtnflash
global sendBtnflash
global againBtnflash
global backBtnflash
global btncnt
global holeStrokes
global scoreCardFlag
global helpFlag
global cardspr
global cupShadspr
global cupZ
global g_cardParNumSpr
global g_cardHoleNumSpr
global g_cardParNumMem
global g_cardHoleNumMem
global g_parMarkerMem
global g_parMarkerSpr
global numbase
global playerNamesmem
global putNamemem
global trailDigit1
global trailDigit2
global trailDigit3
global helpspr
global loadingspr
global loadtextmem
global closeButton
global closeButtonTimer
global ballPriority
global pipeTicks
global holeFlag1
global holeFlag2
global refract
global wallState
global regionMap
global select4
global textScoremem
global scorecardmem
global scorecardname
global helpbubmem
global helpbubspr
global g_showGameOver
global g_cardCloseBtnSpr
global g_helpCloseBtnSpr
global g_selectPlayersSpr
global g_selectPlayersMem
global g_selectPlayersCloseButtonTimer
global g_MouseDownOnMe
global g_playAgainBtnMem
global g_BackToMenuBtnMem
global mat_wood
global mat_dish
global mat_cracker
global mat_bag
global mat_glass
global mat_metal
global mat_cookie
global mat_rock
global mat_book
global mat_plastic
global g_playareaMaxH
global g_playareaMinH
global g_playareaMaxV
global g_playareaMinV
global sndQueue
global frameQueue
global sndCount
global basetime
global curChan
global cursnd
global currentSoundLabel
global flash_sfx
global cupsnd
global bricksnd
global woodsnd
global metalsnd
global pipe1snd
global pipe2snd
global puttsnd
global buzzsnd
global catchsnd
global clickinsnd
global turnMemory1
global turnMemory2
global turnMemory3
global turnMemory4
global turnControlMemory
global svt1
global svt2
global svt3
global svt4
global svtc
global turnTimer
global lastTurnTimer
global turnIndex
global playbackFlag
global remoteControl
global playbackState
global swingTime
global aimTime
global gamePlayMode
global front9Score
global playerType
global obstacleTimer
global g_numPlayers
global g_playerstatus
global playerGender
global putterBaseBoy
global putterBaseGirl
global g_multi
global g_myPlayerNumber
global castmems
global loadedList
global loadingNum
global myNetIDList
global castNameList
global g_holesCast
global g_brandingBaseMem
global g_brandingSpr
global g_currentBrand
global g_brandingCount
global g_hioMem
global g_hioSpr
global g_hioCount
global g_hioShowing
global g_gamename
global g_gameCode
global g_gameSecurityCode
global g_clientCode
global g_debug

on keyDown
  timeoutCount = 0
  if g_debug then
    if the shiftDown then
      val = the keyCode
      case val of
        29:
          val = 10
        18, 19, 20, 21:
          val = val - 7
        23:
          val = 15
        22:
          val = 16
        26:
          val = 17
        28:
          val = 18
        46:
          val = 101
        4:
          val = 102
        1:
          val = 103
        12:
          val = 104
        otherwise:
          val = 0

      end case
    else
      val = value(the key)
    end if
    case val of
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18:
        if not g_multi and holeImplemented[val] then
          gamePlayMode = #Practice
          holeNumber = inithackv(val)
          ballState = [#cup, #cup, #cup, #cup]
          goHole(val)
        end if
      101:
        if not g_multi then
          countGames()
          goMenu()
          updateStage()
        end if
      102:
        displayHelp(1)
        displayScore(0)
      103:
        displayHelp(0)
        displayScore(1)
      104:
        myExit()
        updateStage()

    end case
  end if
  showVersion()
end
on mouseDownCode
  pause = 0
  timeoutCount = 0
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
on enterFrame
  if frameInit = 0 then
    set the timeoutLength to 20 * 60
    mouseFlag = the mouseDown
    codeInit()
    frameInit = 1
  end if
  clearVersion()
  DoButtonFlashes()
  if the frame > 9 and numPlayers < 1 then
    PromptForPlayers(1)
    exit
  end if
  if the frame <> wasFrame then
    wasFrame = the frame
    puppetAll()
  end if
  if not (ballState[1] = #holeLoading or ballState[1] = #gameover) then
    hide(loadingspr)
    hide(loadingspr + 1)
    hide(loadingspr + 2)
  end if
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
    end if
  end if
  mouseFlag = flg
  if getAt(ballState, 1) = #gameover then
    tmp = frameTimer mod 16
    if tmp >= 8 then
      set the memberNum of sprite guiBtnBaseSpr + 2 to btnmem + 6 + 1
    else
      set the memberNum of sprite guiBtnBaseSpr + 2 to btnmem + 6
    end if
  end if
  frameTimer = frameTimer + 1
  if the frame > 9 then
    CorrectBrandingFade()
    hideCursor()
    if ballState[1] = #quitting then
      exit
    end if
    revealScores()
    remoteControl = playbackFlag
    if playerType[player] <> #local then
      remoteControl = 1
    end if
    if pause then
      set the volume of sound 1 to 0
      set the volume of sound 2 to 0
    else
      set the volume of sound 1 to sound1shad
      set the volume of sound 2 to sound2shad
    end if
    frameCtr = frameCtr + 1
    delayTimer = delayTimer + 1
    if playerType[player] = #remote then
      st = ballState[player]
      if (st = #placeball or st = #aim) and not playbackFlag then
        wait_MP_Update()
      end if
    end if
    if logic2() then
      exit
    end if
    AnimateHoleInOne()
    flashPlayer()
    showPutter()
  end if
end
on exitFrame
  if g_multi then
    mpThread()
  end if
  updateRegionMap()
  if voidp(ballState) then
    go(the frame)
    exit
  end if
  st = getAt(ballState, 1)
  if st = #loadDone and nextHole > 0 then
    frm = label("Hole" & string(nextHole))
    holeNumber = inithackv(nextHole)
    setAt(ballState, 1, #initHole)
    nextHole = 0
    currentScreen = 0
    ballScreen = [0, 0, 0, 0]
    goFrame(frm)
  else
    scrn = getAt(ballScreen, player)
    if playbackFlag then
      if getAt(ballMagnitude, player) = 0 then
        repeat with plyr = 1 to numPlayers
          if plyr = player then
            next repeat
          end if
          if getAt(ballMagnitude, plyr) > 0 then
            scrn = getAt(ballScreen, plyr)
          end if
        end repeat
      end if
    end if
    if int(scrn / 4) = int(currentScreen / 4) then
      go(the frame)
    else
      currentScreen = scrn
      frm = label("Hole" & string(readhackv(holeNumber)))
      if currentScreen >= 4 then
        frm = frm + 5
      end if
      puppetOffScoreOn()
      go(frm)
    end if
  end if
end
on goRestart
  scoreCardFlag = 0
  displayHelp(0)
  ballState = [#initHole, #initHole, #initHole, #initHole]
  scoreCard = duplicate(emptyList(g_numberOfHoles * 4))
  holeStrokes = emptyList(4).duplicate()
  frameTimer = 1
  codeInit()
  hol = 1
  holeNumber = -1
  holeCompleted = 0
  setAt(ballState, 1, #loadDone)
  nextHole = 1
  if g_multi then
    mpNewGame()
  end if
end
on myExit
  ballState = [#quitting, #quitting, #quitting, #quitting]
  if readhackv(bestScore) < 9999 then
    MD5 = 0
    if g_multi then
      plyr = g_myPlayerNumber
      mpSessionId = string(mpGetSessionNumber())
    else
      plyr = 1
      mpSessionId = EMPTY
    end if
    exitPoint(g_gameCode, g_gameSecurityCode, plyr, bestScore, #lowscore, g_clientCode, mpSessionId, MD5, EMPTY)
  else
    if the runMode contains "Author" then
      put "No complete game played"
    else
      gotoNetPage(externalParamValue("SW1"))
    end if
  end if
  if the runMode contains "Author" then
    halt()
  end if
end
on doPreload hol
  if the runMode contains "Plugin" then
    if not preloaded then
      id = preloadNetThing("Holes.cct")
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
      str = RETURN & "Loading Hole " & string(nextHole) & "... Please Wait"
      member(loadtextmem).text = str
      setAt(ballState, 1, #testload)
    #testload:
      testLoaded()
      if not getLoadedList(nextHole) then
        doPreload()
        show(loadingspr)
        show(loadingspr + 1)
        show(loadingspr + 2)
        sprite(loadingspr).locZ = g_cardHoleNumSpr + 13
        sprite(loadingspr + 1).locZ = g_cardHoleNumSpr + 14
        sprite(loadingspr + 2).locZ = g_cardHoleNumSpr + 15
      end if
      setAt(ballState, 1, #holeLoading)
    #holeLoading:
      testLoaded()
      if getLoadedList(nextHole) then
        hide(loadingspr)
        hide(loadingspr + 1)
        hide(loadingspr + 2)
        setAt(ballState, 1, #loadDone)
      end if
    #loadDone:
    #initHole:
      initHole()
    #gameover:
      str = "Game Over" & RETURN & "Click Menu or Quit"
      member(loadtextmem).text = str
      if g_showGameOver then
        show(loadingspr)
        show(loadingspr + 1)
      else
        hide(loadingspr)
        hide(loadingspr + 1)
      end if

  end case
  return 0
end
on getTest lst, ind
  if ind < 0 or ind > count(lst) then
    return 0
  end if
  return getAt(lst, ind)
end
on getAtWalls ind, scrn
  case scrn of
    0:
      return getTest(walls0, ind)
    1:
      return getTest(walls1, ind)
    2:
      return getTest(walls2, ind)
    3:
      return getTest(walls3, ind)
    4:
      return getTest(walls4, ind)
    5:
      return getTest(walls5, ind)
    6:
      return getTest(walls6, ind)
    7:
      return getTest(walls7, ind)
    8:
      return getTest(walls8, ind)
    9:
      return getTest(walls9, ind)

  end case
end
on getAtWallv ind, scrn
  case scrn of
    0:
      return getTest(wallv0, ind)
    1:
      return getTest(wallv1, ind)
    2:
      return getTest(wallv2, ind)
    3:
      return getTest(wallv3, ind)
    4:
      return getTest(wallv4, ind)
    5:
      return getTest(wallv5, ind)
    6:
      return getTest(wallv6, ind)
    7:
      return getTest(wallv7, ind)
    8:
      return getTest(wallv8, ind)
    9:
      return getTest(wallv9, ind)

  end case
end
on getAtWalle ind, scrn
  case scrn of
    0:
      return getTest(walle0, ind)
    1:
      return getTest(walle1, ind)
    2:
      return getTest(walle2, ind)
    3:
      return getTest(walle3, ind)
    4:
      return getTest(walle4, ind)
    5:
      return getTest(walle5, ind)
    6:
      return getTest(walle6, ind)
    7:
      return getTest(walle7, ind)
    8:
      return getTest(walle8, ind)
    9:
      return getTest(walle9, ind)

  end case
end
on getAtPlats ind, scrn
  case scrn of
    0:
      return getTest(plats0, ind)
    1:
      return getTest(plats1, ind)
    2:
      return getTest(plats2, ind)
    3:
      return getTest(plats3, ind)
    4:
      return getTest(plats4, ind)
    5:
      return getTest(plats5, ind)
    6:
      return getTest(plats6, ind)
    7:
      return getTest(plats7, ind)
    8:
      return getTest(plats8, ind)
    9:
      return getTest(plats9, ind)

  end case
end
on getAtPlatv ind, scrn
  case scrn of
    0:
      return getTest(platv0, ind)
    1:
      return getTest(platv1, ind)
    2:
      return getTest(platv2, ind)
    3:
      return getTest(platv3, ind)
    4:
      return getTest(platv4, ind)
    5:
      return getTest(platv5, ind)
    6:
      return getTest(platv6, ind)
    7:
      return getTest(platv7, ind)
    8:
      return getTest(platv8, ind)
    9:
      return getTest(platv9, ind)

  end case
end
on getAtPlate ind, scrn
  case scrn of
    0:
      return getAt(plate0, ind)
    1:
      return getAt(plate1, ind)
    2:
      return getAt(plate2, ind)
    3:
      return getAt(plate3, ind)
    4:
      return getAt(plate4, ind)
    5:
      return getAt(plate5, ind)
    6:
      return getAt(plate6, ind)
    7:
      return getAt(plate7, ind)
    8:
      return getAt(plate8, ind)
    9:
      return getAt(plate9, ind)

  end case
end
on testH Hval, Vval, scrn
  rightP = 0
  L_edge = 0
  R_edge = 0
  mywmult = getAt(wmult, scrn + 1)
  wallind = (Vval - getAt(ceiling, scrn + 1)) * mywmult
  if wallind < 1 then
    return 0
  end if
  edge = 1
  repeat with i = 1 to mywmult
    hp = getAtWalls(wallind + i, scrn)
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
      getVecw(wallind + i, scrn)
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
on testV Vval, Hval, scrn
  botP = 999
  mypmult = getAt(pmult, scrn + 1)
  platind = (Hval - getAt(leftWall, scrn + 1)) * mypmult
  if platind < 1 then
    return 0
  end if
  repeat with i = 1 to mypmult
    vp = getAtPlats(platind + i, scrn)
    if vp = 0 then
      exit repeat
    end if
    if Vval = vp then
      getVecp(platind + i, scrn)
      ahit = 1
      exit repeat
    end if
  end repeat
  return ahit
end
on restoreH plyr
  if not collflg then
    setAt(ballh, plyr, oldH)
    dispH = integer(oldH)
  end if
end
on restoreV plyr
  if not collflg then
    setAt(ballv, plyr, oldV)
    dispV = integer(oldV)
  end if
end
on ballcoll plyr
  repeat with j = 1 to numPlayers
    if j = plyr then
      next repeat
    end if
    st = ballState[j]
    if st = #rattle or st = #cup then
      next repeat
    end if
    if ballScreen[plyr] <> ballScreen[j] then
      next repeat
    end if
    x1 = getAt(ballh, j)
    y1 = getAt(ballv, j)
    x2 = getAt(ballh, plyr)
    y2 = getAt(ballv, plyr)
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    if dist < 121 then
      doHit(plyr, j)
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
  ang = angle * PI / 180.0
  ballh[i] = ballh[j] + ballwidth * cos(ang)
  ballv[i] = ballv[j] - ballwidth * sin(ang)
  vol = spdiff * 12
  if vol > 255 then
    vol = 255
  end if
  playSound(puttsnd, vol, 4, (255 - vol) / 25.0)
end
on invertH plyr
  ang = getAt(ballAngle, plyr) * PI / 180.0
  mag = getAt(ballMagnitude, plyr)
  dx = mag * cos(ang)
  dy = mag * sin(ang)
  dx = 0 - dx
  rect2polarBall(dx, dy, plyr)
end
on invertV plyr
  ang = getAt(ballAngle, plyr) * PI / 180.0
  mag = getAt(ballMagnitude, plyr)
  dx = mag * cos(ang)
  dy = mag * sin(ang)
  dy = 0 - dy
  rect2polarBall(dx, dy, plyr)
end
on nextGrand val
  return (int(val / 1000) + 1) * 1000
end
on recordMovement plyr, stor, snd
  if voidp(stor) then
    stor = 0
  end if
  if voidp(snd) then
    snd = -1
  end if
  case plyr of
    1:
      recordIt(1, turnMemory1, stor, snd)
    2:
      recordIt(2, turnMemory2, stor, snd)
    3:
      recordIt(3, turnMemory3, stor, snd)
    4:
      recordIt(4, turnMemory4, stor, snd)

  end case
end
on recordIt plyr, lst, stor, snd
  if voidp(stor) then
    stor = 0
  end if
  if voidp(snd) then
    snd = -1
  end if
  if turnTimer = 0 then
    exit
  end if
  recordlen = 12
  change = 0
  if stor then
    change = 1
  end if
  st = getAt(ballState, plyr)
  bH = getAt(ballh, plyr)
  bV = getAt(ballv, plyr)
  bY = getAt(ballY, plyr)
  mag = getAt(ballMagnitude, plyr)
  ang = getAt(ballAngle, plyr)
  grv = getAt(ballGravity, plyr)
  scr = getAt(ballScreen, plyr)
  pri = getAt(ballPriority, plyr)
  ind = count(lst)
  if ind >= recordlen then
    val1 = getAt(lst, ind - recordlen + 2)
    val2 = getAt(lst, ind - recordlen + 3)
    val3 = getAt(lst, ind - recordlen + 4)
    val4 = getAt(lst, ind - recordlen + 5)
    val5 = getAt(lst, ind - recordlen + 6)
    val6 = getAt(lst, ind - recordlen + 7)
    val7 = getAt(lst, ind - recordlen + 8)
    val8 = getAt(lst, ind - recordlen + 9)
    val9 = getAt(lst, ind - recordlen + 10)
    if st <> val1 then
      change = 1
    end if
    if bY <> val4 then
      change = 1
    end if
    if mag <> val5 and val5 = 0 then
      change = 1
    end if
    if ang <> val6 then
      change = 1
    end if
    if grv <> val7 then
      change = 1
    end if
    if scr <> val8 then
      change = 1
    end if
    if pri <> val9 then
      change = 1
    end if
    if st = #moveball and turnTimer - lastTurnTimer > 4 then
      change = 1
    end if
  end if
  if change then
    add(lst, turnTimer)
    lastTurnTimer = turnTimer
    add(lst, getAt(ballState, plyr))
    add(lst, getAt(ballh, plyr))
    add(lst, getAt(ballv, plyr))
    add(lst, getAt(ballY, plyr))
    add(lst, getAt(ballMagnitude, plyr))
    add(lst, getAt(ballAngle, plyr))
    add(lst, getAt(ballGravity, plyr))
    add(lst, getAt(ballScreen, plyr))
    add(lst, getAt(ballPriority, plyr))
    add(lst, obstacleTimer)
    add(lst, snd)
  end if
end
on recordAllBalls flg
  if voidp(flg) then
    flg = #noFlag
  end if
  sav = obstacleTimer
  if flg = #first then
    turnMemory1 = []
    turnMemory2 = []
    turnMemory3 = []
    turnMemory4 = []
    turnControlMemory = []
    turnTimer = 1
    turnControlMemory = [player, currentScreen, 0, putterH, putterV, putterAngle, putterForce, 0]
    if currentScreen < 4 then
      turnControlMemory[3] = swingTime
    else
      turnControlMemory[3] = aimTime
    end if
  end if
  recordBlock(1, turnMemory1)
  recordBlock(2, turnMemory2)
  recordBlock(3, turnMemory3)
  recordBlock(4, turnMemory4)
  if flg = #last then
    send_MP_turn()
  end if
end
on recordBlock plyr, lst
  case plyr of
    1:
      recordIt(1, turnMemory1, 1)
    2:
      recordIt(2, turnMemory2, 1)
    3:
      recordIt(3, turnMemory3, 1)
    4:
      recordIt(4, turnMemory4, 1)

  end case
end
on startPlayback
  turnMemory1 = duplicate(svt1)
  turnMemory2 = duplicate(svt2)
  turnMemory3 = duplicate(svt3)
  turnMemory4 = duplicate(svt4)
  turnControlMemory = duplicate(svtc)
  playbackState = #start
  playbackFlag = 1
end
on savePlayback
  svt1 = duplicate(turnMemory1)
  svt2 = duplicate(turnMemory2)
  svt3 = duplicate(turnMemory3)
  svt4 = duplicate(turnMemory4)
  svtc = duplicate(turnControlMemory)
end
on doPlayback
  if holeNumber <> holeNumberDeb then
    exit
  end if
  if playbackFlag then
    case playbackState of
      #start:
        playbackFlag = 1
        setPlayer(turnControlMemory[1])
        ballState = [#waitPlayback, #waitPlayback, #waitPlayback, #waitPlayback]
        turnIndex = [1, 1, 1, 1]
        playbackNext(1, turnMemory1, 1)
        playbackNext(2, turnMemory2, 1)
        playbackNext(3, turnMemory3, 1)
        playbackNext(4, turnMemory4, 1)
        putterScreen = getAt(ballScreen, player)
        setAt(ballMagnitude, player, 0)
        scrn = turnControlMemory[2]
        setAt(ballScreen, player, scrn)
        putterH = turnControlMemory[4]
        putterV = turnControlMemory[5]
        putterForce = 0
        putterAngle = turnControlMemory[6]
        if scrn < 4 then
          setAt(ballState, player, #placeball)
        else
          setAt(ballState, player, #aim)
        end if
        playbackState = #setRubberband
      #setRubberband:
        ang = turnControlMemory[6]
        mag = turnControlMemory[7]
        if putterForce < mag then
          putterForce = putterForce + 5
        end if
        if putterForce >= mag then
          putterForce = mag
          aimTime = 0
          playbackState = #syncTimer
        end if
      #syncTimer:
        tim = turnControlMemory[3]
        flg = 0
        if currentScreen < 4 then
          if obstacleTimer = tim then
            flg = 1
          end if
        else
          if aimTime >= tim then
            flg = 1
          end if
          aimTime = aimTime + 1
        end if
        if flg then
          setAt(ballState, player, #swing)
          golferState = #prepare
          golferAnim = 0
          playbackState = #puttBall
        end if
      #puttBall:
        mag = getAt(ballMagnitude, player)
        if mag > 0 then
          turnTimer = 1
          playbackState = #playback
          addStroke(player)
        end if
      #playback:
        flg1 = playbackNext(1, turnMemory1)
        flg2 = playbackNext(2, turnMemory2)
        flg3 = playbackNext(3, turnMemory3)
        flg4 = playbackNext(4, turnMemory4)
        if flg1 and flg2 and flg3 and flg4 then
          playbackState = #waitWhile
          turnTimer = -1
        end if
        if turnTimer > 0 then
          turnTimer = turnTimer + 1
        end if
      #waitWhile:
        if turnTimer < -20 then
          playbackState = #playbackDone
          nextShot()
          playbackFlag = 0
          turnTimer = 1
        end if
        turnTimer = turnTimer - 1

    end case
  end if
  if not playbackFlag then
    repeat with plyr = 1 to numPlayers
      recordMovement(plyr, 0, -1)
    end repeat
    if turnTimer > 0 then
      turnTimer = turnTimer + 1
    end if
  end if
end
on playbackNext plyr, lst, flg
  if voidp(flg) then
    flg = 0
  end if
  recordlen = 12
  ind = getAt(turnIndex, plyr)
  if ind < 1 then
    exit
  end if
  if ind > count(lst) then
    return 1
  end if
  tim = getAt(lst, ind)
  if turnTimer >= tim or flg then
    st = getAt(lst, ind + 1)
    setAt(ballState, plyr, st)
    setAt(ballh, plyr, getAt(lst, ind + 2))
    setAt(ballv, plyr, getAt(lst, ind + 3))
    setAt(ballY, plyr, getAt(lst, ind + 4))
    mag = getAt(lst, ind + 5)
    if mag > 0 then
      setAt(ballMagnitude, plyr, mag)
    end if
    setAt(ballAngle, plyr, getAt(lst, ind + 6))
    setAt(ballGravity, plyr, getAt(lst, ind + 7))
    setAt(ballScreen, plyr, getAt(lst, ind + 8))
    setAt(ballPriority, plyr, getAt(lst, ind + 9))
    if not flg then
      obstacleTimer = getAt(lst, ind + 10)
    end if
    snd = getAt(lst, ind + 11)
    if snd > 0 then
      playSound(snd, 255, 1)
    end if
    ind = ind + recordlen
    if not flg then
      setAt(turnIndex, plyr, ind)
    end if
  end if
  return 0
end
on goHole hol
  if hol >= 1 and hol <= g_numberOfHoles then
    if holeImplemented[hol] then
      hide(helpbubspr)
      holeNumberDeb = -1
      frm = label("Hole" & string(hol))
      frameTimer = 1
      SetInitialBallState()
      setPlayer(1)
      holeCompleted = 0
      if frm > 0 then
        goFrame(frm)
      else
        gameover()
      end if
    end if
  end if
end
on hideCursor
  if readhackv(holeNumber) = 9 then
    if obstacleTimer / 1000 <> 2 then
      cursor(-1)
      exit
    end if
  end if
  dist = (holes[1].locH - the mouseH) * (holes[1].locH - the mouseH) + (holes[1].locV - the mouseV) * (holes[1].locV - the mouseV)
  if dist < 2500 and the mouseH >= 106 and not (scoreCardFlag or helpFlag) then
    cursor(200)
  else
    cursor(-1)
  end if
end