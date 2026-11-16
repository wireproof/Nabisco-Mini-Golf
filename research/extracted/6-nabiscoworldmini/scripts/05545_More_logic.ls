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

on updateRegionMap
  if count(regionMap) < 1 then
    spr = 1
  end if
end
on displayHelp flg
  helpFlag = flg
  if flg then
    show(helpspr)
    show(helpspr + 1)
    show(helpspr + 2)
    show(helpspr + 3)
    sprite(helpspr + 2).visible = 1
    set the memberNum of sprite helpspr + 3 to closeButton
    repeat with i = 165 to 175
      sprite(i).locZ = 149
    end repeat
  else
    hide(helpspr)
    hide(helpspr + 1)
    hide(helpspr + 2)
    hide(helpspr + 3)
    sprite(helpspr + 2).visible = 0
    repeat with i = 165 to 175
      sprite(i).locZ = i
    end repeat
  end if
end
on displayScore flg
  if the frame > 2 then
    scoreCardFlag = flg
    if flg then
      showcard()
      buildCard()
    else
      hidecard()
    end if
  end if
end
on enableChat
  if g_multi then
    show(sendbtnspr)
    show(chatselspr)
    show(historyspr)
    sprite(sendbtnspr).memberNum = btnmem + 12
  else
    hide(sendbtnspr)
    hide(chatselspr)
    hide(historyspr)
  end if
end
on mouseRange
  if playerType[player] = #local and frameTimer > 5 and not remoteControl then
    if the mouseDown and (the mouseH > 106 and the mouseH < 624 and the mouseV > 0 and the mouseV < 350) then
      return 1
    end if
  end if
  return 0
end
on compBest
  lowestScore = 99999
  if g_multi then
    tmp = 0
    repeat with x = 1 to g_numberOfHoles
      ind = (x - 1) * 4 + g_myPlayerNumber
      tmp = tmp + readhackv(getAt(scoreCard, ind))
    end repeat
    if tmp > 0 then
      if tmp < lowestScore then
        lowestScore = tmp
      end if
    end if
  else
    repeat with plyr = 1 to 4
      tmp = 0
      repeat with x = 1 to g_numberOfHoles
        ind = (x - 1) * 4 + plyr
        tmp = tmp + readhackv(getAt(scoreCard, ind))
      end repeat
      if tmp > 0 then
        if tmp < lowestScore then
          lowestScore = tmp
        end if
      end if
    end repeat
  end if
  return lowestScore
end
on nextShot becausePlayerDropped
  if voidp(becausePlayerDropped) then
    becausePlayerDropped = 0
  end if
  if playbackFlag then
    if playbackState = #playbackDone then
      playbackFlag = 0
    else
      exit
    end if
  else
    if not becausePlayerDropped then
      recordAllBalls(#last)
      turnTimer = 0
    end if
  end if
  movingflag = 0
  repeat with plyr = 1 to numPlayers
    strok = readhackv(getAt(holeStrokes, plyr))
    if strok >= g_maxStrokes then
      st = getAt(ballState, plyr)
      if st <> #cup then
        setAt(ballh, plyr, 4000)
        setAt(ballv, plyr, 0)
        setState(plyr, #cup)
        ballMagnitude[plyr] = 0
        ballY[plyr] = 0
        ballGravity[plyr] = 0
        playSound(buzzsnd, 255, 9)
      end if
    end if
  end repeat
  flg = 1
  repeat with plyr = 1 to numPlayers
    st = getAt(ballState, plyr)
    typ = getAt(playerType, plyr)
    if typ = #local or typ = #remote then
      if st <> #cup then
        flg = 0
      end if
    end if
  end repeat
  if flg then
    ballState = [#nextHole, #nextHole, #nextHole, #nextHole]
    putterH = 4000
    hn = readhackv(holeNumber)
    holeCompleted = hn
    displayHelp(0)
    displayScore(1)
    case gamePlayMode of
      #Practice:
        initHole()
        return 1
      #front9:
        if hn < 9 then
          nextHole = hn + 1
          tst = getAt(holeImplemented, nextHole)
          repeat while not tst
            nextHole = nextHole + 1
            if nextHole >= count(holeImplemented) then
              nextHole = 0
              next repeat
            end if
            tst = getAt(holeImplemented, nextHole)
          end repeat
        else
          best = readhackv(bestScore)
          this = compBest()
          gameover()
          return 1
        end if
      #back9:
        if hn < 18 then
          nextHole = hn + 1
          tst = getAt(holeImplemented, nextHole)
          repeat while not tst
            nextHole = nextHole + 1
            if nextHole >= count(holeImplemented) then
              nextHole = 9
              next repeat
            end if
            tst = getAt(holeImplemented, nextHole)
          end repeat
        else
          best = readhackv(bestScore)
          this = compBest()
          gameover()
          return 1
        end if
      #full18:
        if hn < g_numberOfHoles then
          nextHole = hn + 1
          tst = getAt(holeImplemented, nextHole)
          repeat while not tst
            nextHole = nextHole + 1
            if nextHole >= count(holeImplemented) then
              nextHole = 0
              next repeat
            end if
            tst = getAt(holeImplemented, nextHole)
          end repeat
        else
          best = readhackv(bestScore)
          this = compBest()
          if this < best then
            bestScore = inithackv(this)
          end if
          gameover()
          return 1
        end if

    end case
    return 1
  end if
  who = []
  repeat with plyr = 1 to numPlayers
    if ballState[plyr] <> #moveball then
      next repeat
    end if
    scrn = getAt(ballScreen, plyr)
    offs = 0
    if scrn >= 4 then
      offs = 1000
    end if
    pt = getAt(holes, 1)
    x1 = pt.locH - offs
    y1 = pt.locV
    x2 = getAt(ballh, plyr)
    y2 = getAt(ballv, plyr)
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    dist = float(int(dist) + plyr / 10.0)
    if dist < 1500 then
      add(who, dist)
    end if
  end repeat
  if count(who) > 0 then
    sort(who)
    frac = getAt(who, 1)
    frac = frac - int(frac)
    frac = frac * 10
    setPlayer(integer(frac))
  else
    repeat while 1
      player = player + 1
      setPlayer(player)
      state = getAt(ballState, player)
      if state <> #cup and state <> #rattle then
        exit repeat
      end if
    end repeat
  end if
  if state = #shelf or st = #drain then
    setState(player, #placeball)
  else
    setState(player, #aim)
  end if
  return 0
end
on setPlayer val
  if val < 1 or val > g_maxPlayers then
    val = 1
  end if
  repeat while 1
    if val > numPlayers then
      val = 1
    end if
    typ = getAt(playerType, val)
    if typ = #local or typ = #remote then
      exit repeat
    end if
    val = val + 1
  end repeat
  player = val
end
on setState plyr, val
  if not playbackFlag then
    setAt(ballState, plyr, val)
  end if
end
on putOnShelf plyr
  if not voidp(shelfPoints) then
    h = getAt(shelfPoints, plyr).locH + 12000
    v = getAt(shelfPoints, plyr).locV
    setAt(ballh, plyr, h)
    setAt(oldballH, plyr, h)
    setAt(ballv, plyr, v)
    setAt(ballY, plyr, 0)
    setAt(ballBounce, plyr, 0)
    setAt(ballGravity, plyr, 0)
    setAt(ballMagnitude, plyr, 0)
    setAt(ballScreen, plyr, 0)
    ballPriority[plyr] = ballhigh + plyr - 1
    if plyr = player then
      putterForce = 0
    end if
  end if
end
on OutOfBounds plyr
  playSound(buzzsnd, 150, 2, 0)
  setState(plyr, #shelf)
  putOnShelf(plyr)
  if plyr = player then
    ballMagnitude[plyr] = 1
    movingflag = 1
  end if
end
on nearestTee
  if remoteControl then
    msH = putterH
    msV = putterV
  else
    msH = the mouseH
    msV = the mouseV
  end if
  min = 99999999
  ind = 0
  repeat with x = 1 to 3
    x1 = getAt(teePoints, x).locH
    y1 = getAt(teePoints, x).locV
    x2 = msH
    y2 = msV
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    if dist < min then
      ind = x
      min = dist
    end if
  end repeat
  if ind < 1 or ind > 3 then
    ind = 0
  else
    ballh[player] = teePoints[ind].locH
    ballv[player] = teePoints[ind].locV
    setAt(ballScreen, player, 0)
  end if
  return ind
end
on flashPlayer
  if not (scoreCardFlag or helpFlag) then
    repeat with plyr = 1 to numPlayers
      typ = playerType[plyr]
      spr = score1spr + 7 * (plyr - 1)
      if not (typ = #local or typ = #remote) then
        hide(spr)
        next repeat
      end if
      st = ballState[plyr]
      val = frameTimer mod 18
      if st = #aim or st = #placeball then
        if val < 9 then
          hide(spr)
        else
          show(spr)
        end if
        next repeat
      end if
      show(spr)
    end repeat
  else
    unflashPlayer()
  end if
end
on unflashPlayer
  repeat with plyr = 1 to numPlayers
    spr = score1spr + 7 * (plyr - 1)
    hide(playerNamespr + plyr - 1)
    hide(spr)
  end repeat
end
on throwBall
  setAt(ballAngle, 1, circ(56 + (the mouseH - oldMouseH)))
  setAt(ballMagnitude, 1, 5)
end
on revealScores
  if the frame > 9 then
    repeat with plyr = 1 to g_maxPlayers
      typ = playerType[plyr]
      st = ballState[plyr]
      spr = score1spr + 7 * (plyr - 1)
      if plyr <= numPlayers and (typ = #local or typ = #remote) then
        if plyr = player then
          show(spr)
        else
          hide(spr)
        end if
        show(spr + 1)
        show(spr + 2)
        show(spr + 3)
        show(spr + 4)
        show(spr + 5)
        show(spr + 6)
        next repeat
      end if
      hide(playerNamespr + plyr - 1)
      hide(spr)
      hide(spr + 1)
      hide(spr + 2)
      hide(spr + 3)
      hide(spr + 4)
      hide(spr + 5)
      hide(spr + 6)
    end repeat
  else
    repeat with plyr = 1 to g_maxPlayers
      hide(playerNamespr + plyr - 1)
      spr = score1spr + 7 * (plyr - 1)
      hide(spr)
      hide(spr + 1)
      hide(spr + 2)
      hide(spr + 3)
      hide(spr + 4)
      hide(spr + 5)
      hide(spr + 6)
    end repeat
  end if
end
on addStroke plyr
  strok = readhackv(getAt(holeStrokes, plyr)) + 1
  tmp = inithackv(strok)
  setAt(holeStrokes, plyr, tmp)
  setAt(scoreCard, (readhackv(holeNumber) - 1) * 4 + plyr, tmp)
  showScore(plyr)
end
on showScore plyr
  if plyr <= g_maxPlayers then
    spr = score1spr + 7 * (plyr - 1) + 1
    if plyr <= numPlayers then
      tmp1 = readhackv(getAt(holeStrokes, plyr))
      if readhackv(holeNumber) > 9 then
        val = compBack(plyr)
      else
        val = compFront(plyr)
      end if
      dig5 = val mod 10
      val = int(val / 10)
      dig4 = val mod 10
      val = int(val / 10)
      dig3 = val mod 10
      val = tmp1
      dig2 = val mod 10
      val = int(val / 10)
      dig1 = val mod 10
      set the memberNum of sprite spr to numbase + dig1
      set the memberNum of sprite spr + 1 to numbase + dig2
      set the memberNum of sprite spr + 3 to numbase + dig3
      set the memberNum of sprite spr + 4 to numbase + dig4
      sprite(spr + 5).memberNum = numbase + dig5
      show(spr)
      show(spr + 1)
      show(spr + 2)
      show(spr + 3)
      show(spr + 4)
      show(spr + 5)
    else
      hide(spr)
      hide(spr + 1)
      hide(spr + 2)
      hide(spr + 3)
      show(spr + 4)
      hide(spr + 5)
    end if
  end if
end
on compFront plyr
  tmp = 0
  repeat with x = 0 to 8
    ind = x * 4 + plyr
    tmp = tmp + readhackv(getAt(scoreCard, ind))
  end repeat
  tmp1 = inithackv(tmp)
  setAt(front9Score, plyr, tmp1)
  return tmp
end
on compBack plyr
  tmp = 0
  repeat with x = 0 to 8
    ind = (x + 9) * 4 + plyr
    tmp = tmp + readhackv(getAt(scoreCard, ind))
  end repeat
  return tmp
end
on pickBall
  readMouse()
  setAt(ballh, 1, the mouseH)
  setAt(ballv, 1, the mouseV)
  setAt(ballMagnitude, 1, 0)
end
on targeting hh, vv, plyr
  dH = (getAt(ballh, plyr) - hh) * 1.0
  dV = (getAt(ballv, plyr) - vv) * 1.0
  if dH = 0 then
    ang = 90
  else
    ang = atan(abs(dV) / abs(dH)) * 180.0 / PI
  end if
  if not (dH < 0 and dV >= 0) then
    if dH >= 0 and dV >= 0 then
      ang = 180.0 - ang
    end if
    if dH >= 0 and dV < 0 then
      ang = ang + 180.0
    end if
    if dH < 0 and dV < 0 then
      ang = 360.0 - ang
    end if
  end if
  return ang
end
on aimPutter
  if not remoteControl then
    targetH = the mouseH
    targetV = the mouseV
  end if
end
on addressball
  h = ballh[player]
  v = ballv[player]
  if playerType[player] = #remote then
    putterScreen = ballScreen[player]
  end if
  if remoteControl then
    putterH = h
    putterV = v
  else
    putterAngle = targeting(targetH, targetV, player)
    pic = int(circ(putterAngle + 2) / 4)
    ang = circ(putterAngle + 180) * PI / 180.0
    dist = ballwidth / 2 + 4 + putterForce
    dH = dist * cos(ang) / 2
    dV = dist * sin(ang) / 2
    putterScreen = currentScreen
    putterH = h + dH
    putterV = v - dV
  end if
end
on showPutter
  if not (scoreCardFlag or helpFlag) then
    sprite(putterspr).loc = point(putterH, putterV)
    sprite(putterspr).memberNum = putterBase + int(circ(putterAngle + 2) / 4)
  end if
end
on moveButt plyr
  if plyr <> player then
    exit
  end if
  if currentScreen >= 4 then
    r1 = the rect of sprite putterspr + 1
    p1 = getAt(holes, 1)
    h = p1.locH
    v = p1.locV
    p1 = point(h mod 1000, v)
    r2 = inflate(r1, -20, -20)
    h = getAt(ballh, player)
    v = getAt(ballv, player)
    p2 = point(h, v)
    if inside(p1, r1) or inside(p2, r2) then
      putterAngle = circ(putterAngle + 3)
    end if
  end if
end
on showGolfer
  if not (scoreCardFlag or helpFlag) then
    if not playbackFlag then
      st = getAt(ballState, player)
      if st = #aim then
        aimTime = 0
      end if
      if st = #drawback then
        aimTime = aimTime + 1
      end if
    end if
    if golferState <> oldGolferState then
      golferStateTimer = 0
    end if
    oldGolferState = golferState
    gpic = 0
    case golferState of
      #freeze:
      #waggle:
        golferAnim = golferAnim + 1
        val1 = int(golferAnim / 3.0)
        a1 = 60
        a2 = int(a1 / 2)
        val2 = val1 mod a1
        if val2 > a2 then
          val2 = a1 - val2
        end if
        val2 = val2 - int(a2 / 2) + 8
        gpic = val2
        if gpic < 0 then
          gpic = 0
        end if
        if gpic > 15 then
          gpic = 15
        end if
      #prepare:
        golferState = #swing
        golferAnim = 0
        swingTime = obstacleTimer
      #swing:
        if putterForce > 60 then
          glst = [0, 1, 1, 1, 3, 5, 5, 5, 4, 4, 3]
        else
          if putterForce < 20 then
            glst = [0, 1, 1, 1, 2, 3, 4, 4, 4, 4, 3]
          else
            glst = [0, 1, 1, 1, 3, 4, 4, 4, 3]
          end if
        end if
        ind = int(golferAnim) + 1
        if ind > count(glst) then
          ind = count(glst)
          golferState = #freeze
          putterForce = 0
        end if
        if ind < 1 then
          ind = 1
        end if
        gpic = getAt(glst, ind) + 16
        if gpic >= 19 then
          plyr = player
          if getAt(ballState, plyr) = #swing then
            if putterForce < 6 then
              putterForce = 6
            end if
            setAt(ballAngle, plyr, putterAngle)
            setAt(ballMagnitude, plyr, putterForce / 4)
            vol = putterForce * 4
            if vol > 255 then
              vol = 255
            end if
            playSound(puttsnd, vol, 4)
            addressball()
            setState(plyr, #moveball)
            movingflag = 1
            DebugLog("f=" & string(putterForce) && "bA=" & string(putterAngle) && "mag=" & string(putterForce / 4))
            if not playbackFlag then
              addStroke(plyr)
              recordAllBalls(#first)
            end if
          end if
        end if
        spd = 1
        golferAnim = golferAnim + spd

    end case
    golferStateTimer = golferStateTimer + 1
    offs = 0
    if int(putterScreen / 4) <> int(currentScreen / 4) then
      offs = 4000
    end if
    if currentScreen >= 4 then
      pic = 24
      spr = putterspr
      set the locH of sprite spr to putterH + offs
      set the locV of sprite spr to putterV
      set the memberNum of sprite spr to putterBase + gpic + pic
      sprite(spr).rotation = circ(90 - putterAngle)
    else
      pic = 1
      spr = putterspr
      set the locH of sprite spr to putterH - 64 + offs
      set the locV of sprite spr to putterV
      set the memberNum of sprite spr to putterBase + gpic + pic
    end if
  end if
end
on animateSwing
  if not playbackFlag then
    st = getAt(ballState, player)
    if st = #aim then
      aimTime = 0
    end if
    if st = #drawback then
      aimTime = aimTime + 1
    end if
  end if
  if golferState <> oldGolferState then
    golferStateTimer = 0
  end if
  oldGolferState = golferState
  gpic = 0
  if putterForce > 60 then
    glst = [0, 1, 1, 1, 3, 5, 5, 5, 4, 4, 3]
  else
    if putterForce < 20 then
      glst = [0, 1, 1, 1, 2, 3, 4, 4, 4, 4, 3]
    else
      glst = [0, 1, 1, 1, 3, 4, 4, 4, 3]
    end if
  end if
  ind = int(golferAnim) + 1
  if ind > count(glst) then
    ind = count(glst)
    golferState = #freeze
    putterForce = 0
  end if
  if ind < 1 then
    ind = 1
  end if
  gpic = getAt(glst, ind) + 16
  if gpic >= 19 then
    plyr = player
    if getAt(ballState, plyr) = #swing then
      if putterForce < 6 then
        putterForce = 6
      end if
      setAt(ballAngle, plyr, putterAngle)
      setAt(ballMagnitude, plyr, putterForce / 4)
      vol = putterForce * 4
      if vol > 255 then
        vol = 255
      end if
      playSound(puttsnd, vol, 4)
      addressball()
      setState(plyr, #moveball)
      movingflag = 1
      DebugLog("f=" & string(putterForce) && "bA=" & string(putterAngle) && "mag=" & string(putterForce / 4))
      if not playbackFlag then
        addStroke(plyr)
        recordAllBalls(#first)
      end if
    end if
  end if
  spd = 1
  golferAnim = golferAnim + spd
  offs = 0
  pic = 24
  spr = putterspr
  set the locH of sprite spr to putterH + offs
  set the locV of sprite spr to putterV
  set the memberNum of sprite spr to putterBase + gpic + pic
  sprite(spr).rotation = circ(90 - putterAngle)
end
on showRubberBand flg
  if flg then
    sprite(rubberbandspr).loc = point(ballh[player], ballv[player])
    sprite(rubberbandspr).rotation = circ(90 - putterAngle)
    sprite(rubberbandspr).height = putterForce
  else
    hide(rubberbandspr)
  end if
end
on relativeScore plyr
  hn = readhackv(holeNumber)
  first = 1
  if hn >= 10 then
    if gamePlayMode = #back9 then
      first = 10
    end if
  end if
  last = holeCompleted
  num = 0
  par = 0
  repeat with x = first to last
    ind = (x - 1) * 4 + plyr
    num = num + readhackv(getAt(scoreCard, ind))
    par = par + getAt(parList, x)
  end repeat
  scor = num - par
  return scor
end
on num2overunder num
  str = EMPTY
  if num = 0 then
    return "(even)"
  end if
  if num > 0 then
    sign = "+"
  else
    sign = "-"
  end if
  str = "(" & sign & string(abs(num)) & ")"
  return str
end
on showspr spr, pic, h, v, inkv
  set the memberNum of sprite spr to pic
  sprite(spr).visible = 1
  set the ink of sprite spr to inkv
  set the locH of sprite spr to h
  set the locV of sprite spr to v
end
on comma num
  str1 = string(num)
  cnt = length(str1)
  if cnt < 4 then
    str = str1
  else
    if cnt > 6 then
      str = chars(str1, cnt - 6, cnt - 6) & "," & chars(str1, cnt - 5, cnt - 3) & "," & chars(str1, cnt - 2, cnt)
    else
      one = cnt - 6
      if one < 1 then
        one = 1
      end if
      str = chars(str1, one, cnt - 3) & "," & chars(str1, cnt - 2, cnt)
    end if
  end if
  return str
end
on nextFrame
  frameInit = 0
  frameTimer = 0
  go(the frame + 1)
end
on goFrame val
  if scoreCardFlag then
    puppetOffScoreOn()
  else
    puppetOff()
  end if
  go(val)
end
on readMouse
  if the mouseH <> oldMouseH then
    timeoutCount = 0
  end if
  if the mouseV <> oldmouseV then
    timeoutCount = 0
  end if
  if abs(the mouseH - oldMouseH) > 10 then
    goflg = 1
  end if
  if abs(the mouseV - oldmouseV) > 10 then
    goflg = 1
  end if
  oldMouseH = the mouseH
  oldmouseV = the mouseV
end
on vectorAdd magnitude, ang, plyr
  mag = getAt(ballMagnitude, plyr)
  ang1 = getAt(ballAngle, plyr) * PI / 180.0
  dx1 = mag * cos(ang1)
  dy1 = mag * sin(ang1)
  ang2 = ang * PI / 180.0
  dx2 = magnitude * cos(ang2)
  dy2 = magnitude * sin(ang2)
  dx = dx1 + dx2
  dy = dy1 + dy2
  rect2polarBall(dx, dy, plyr, 1)
end
on rect2polarBall dx, dy, plyr, testZero
  if voidp(testZero) then
    testZero = 0
  end if
  rect2polar(dx, dy)
  setAt(ballAngle, plyr, anglePrime)
  if testZero then
    if getAt(ballMagnitude, plyr) <> 0.0 and magprime = 0.0 then
      magprime = 0.01
    end if
  end if
  setAt(ballMagnitude, plyr, magprime)
end
on rect2polar dx, dy
  if dx < 0 then
    xsign = -1
  else
    xsign = 1
  end if
  if dy < 0 then
    ysign = -1
  else
    ysign = 1
  end if
  magprime = sqrt(dx * dx + dy * dy)
  if dx = 0 then
    if dy < 0 then
      anglePrime = 270
    else
      anglePrime = 90
    end if
  else
    theta = atan(abs(dy / dx))
    anglePrime = integer(theta * 360 / twopi)
    if xsign < 0 then
      anglePrime = 180 - anglePrime
    end if
    if ysign < 0 then
      anglePrime = 360 - anglePrime
    end if
    anglePrime = circ(anglePrime)
  end if
  return anglePrime
end
on getVecw indx, scrn
  wallAngle = getAtWallv(indx, scrn)
  elasticity = getAtWalle(indx, scrn)
end
on getVecp indx, scrn
  wallAngle = getAtPlatv(indx, scrn)
  elasticity = getAtPlate(indx, scrn)
end
on circ ang
  ang = integer(ang)
  repeat while ang < 0
    ang = ang + 360
  end repeat
  repeat while ang >= 360
    ang = ang - 360
  end repeat
  return ang
end
on acute ang
  repeat while ang < 0 or ang >= 180
    if ang < 0 then
      ang = ang + 180
    end if
    if ang >= 180 then
      ang = ang - 180
    end if
  end repeat
  return ang
end
on GetForceAngle p1h, p1v, p2h, p2v
  dH = (p2h - p1h) * 1.0
  dV = (p2v - p1v) * -1.0
  if dV = 0 then
    ang = 90.0
  else
    ang = atan(abs(dH) / abs(dV)) * 360.0 / twopi
  end if
  if dH >= 0 and dV < 0 then
    ang = 180.0 - ang
  end if
  if dH < 0 and dV < 0 then
    ang = ang + 180.0
  end if
  if dH < 0 and dV >= 0 then
    ang = 360.0 - ang
  end if
  ang = 360.0 - (ang - 90.0)
  if ang < 0 then
    ang = ang + 360.0
  end if
  if ang > 360.0 then
    ang = ang - 360.0
  end if
  return ang
end
on absorb coeff, plyr, Ref, incid
  mag = getAt(ballMagnitude, plyr)
  ang = incid * PI / 180.0
  mid = circ(Ref + 90)
  val = mag * (1 - coeff) * abs(sin(ang))
  vectorAdd(val, mid, plyr)
  mlt = abs(sin(ang))
  return mlt
end
on reflectStatic plyr, wa, surfaceType, sndToPlay
  ba = ballAngle[plyr]
  if not (wa = ba or circ(wa + 180) = ba) then
    incidence = acute(circ(ba - 180) - wa)
    Ref = circ(wa + 180)
    ballAngle[plyr] = circ(Ref - incidence)
    vol = absorb(surfaceType, plyr, Ref, incidence) * ballMagnitude[plyr] * 20
    if not voidp(sndToPlay) then
      if vol > 255 then
        vol = 255
      end if
      playSound(sndToPlay, vol, 2, (255 - vol) / 25.0)
    end if
    result = 1
  else
    result = 0
  end if
  return result
end
on PointRelatedToLine pt, ptRef, p1, p2
  result = -1
  fp = (pt[1] - p1[1]) * (p2[2] - p1[2]) - (pt[2] - p1[2]) * (p2[1] - p1[1])
  if fp = 0 then
    result = 0
  else
    fr = (ptRef[1] - p1[1]) * (p2[2] - p1[2]) - (ptRef[2] - p1[2]) * (p2[1] - p1[1])
    if fp < 0 and fr < 0 or fp > 0 and fr > 0 then
      result = 1
    end if
  end if
  return result
end
on GetPathAngle objectPoint, targetPoint
  dH = (objectPoint.locH - targetPoint.locH) * 1.0
  dV = (objectPoint.locV - targetPoint.locV) * 1.0
  if dH = 0 then
    result = 90
  else
    result = atan(abs(dV) / abs(dH)) * (180.0 / PI)
  end if
  if dH >= 0 and dV >= 0 then
    result = 180.0 - result
  else
    if dH >= 0 and dV < 0 then
      result = result + 180.0
    else
      if dH < 0 and dV < 0 then
        result = 360.0 - result
      end if
    end if
  end if
  return result
end
on setH val, plyr
  setAt(ballh, plyr, val)
  dispH = integer(val)
end
on setv val, plyr
  setAt(ballv, plyr, val)
  dispV = integer(val)
end
on testPoint Hval, Vval, scrn
  if testH(Hval, Vval, scrn) then
    return ahit
  end if
  if testV(Vval, Hval, scrn) then
    return ahit
  end if
  return ahit
end
on doWallState num
  exit
end
on puppetAll
  repeat with x = 1 to 200
    set the puppet of sprite x to 1
  end repeat
end
on puppetOff
  repeat with x = 1 to 200
    set the puppet of sprite x to 0
  end repeat
end
on puppetOffScoreOn
  repeat with x = 1 to rubberbandspr
    set the puppet of sprite x to 0
  end repeat
  repeat with x = rubberbandspr + 1 to 200
    set the puppet of sprite x to 1
  end repeat
end
on ResetScores
  member("Score 1").text = "00 / 00"
  member("Score 2").text = "00 / 00"
  member("Score 3").text = "00 / 00"
  member("Score 4").text = "00 / 00"
end
on show spr
  h = the locH of sprite spr
  if not the puppet of sprite spr then
    set the puppet of sprite spr to 1
  end if
  if h > 2000 then
    set the locH of sprite spr to h - 4000
  end if
end
on hide spr
  h = the locH of sprite spr
  if not the puppet of sprite spr then
    set the puppet of sprite spr to 1
  end if
  if h < 2000 then
    set the locH of sprite spr to h + 4000
  end if
end
on int val
  if val > -0.5 and val < 0.5 then
    return 0
  end if
  if val < 0 then
    return integer(val + 0.5)
  else
    return integer(val - 0.5)
  end if
end
on memorize
  repeat with x = 1 to 48
    set the puppet of sprite x to 0
  end repeat
  updateStage()
  go(2)
  updateStage()
  put the frame
  repeat with x = 1 to 48
    mem = the memberNum of sprite x
    xval = the locH of sprite x
    yval = the locV of sprite x
    inkv = the ink of sprite x
    vis = sprite(x).visible
    if mem <> 0 then
      str = "**" & "*"
      str = str & string(x) & ","
      str = str & string(mem) & ","
      str = str & string(xval) & ","
      str = str & string(yval) & ","
      str = str & string(inkv) & ","
      str = str & string(vis) & ","
      str = str & "\" & "**" & "*"
      put str
    end if
  end repeat
end
on makeCastList
  maxcast = 18
  str = "**" & "*"
  str = str & "on initcastmems" & "**" & "*"
  put str
  str = "**" & "*"
  str = str & "   set castmems to ["
  str = str & "\" & "**" & "*"
  put str
  mem = 0
  cst = 1
  str = "**" & "*     "
  col = 0
  mem = mem + 1
  bracketed = 0
  repeat while 1
    if the mouseDown then
      exit repeat
    end if
    typ = member(mem, cst).type
    mem2 = mem + 1
    typ2 = member(mem2, cst).type
    if cst = g_holesCast then
      if typ = #empty and typ2 = #empty then
        exit repeat
      end if
      if typ = #empty then
        typ = #next
      end if
    end if
    if col > 0 then
      str = str & ","
    end if
    str = str & "#" & string(typ)
    mem = mem + 1
    if mem > member("LastCastMember").number - 1 and cst = 1 then
      mem = 1
      cst = g_holesCast
      typ = #next
      str = str & ",#next"
    end if
    col = col + 1
    if col > 8 or typ = #next then
      str = str & "," & "\" & "**" & "*"
      put str
      str = "**" & "*     "
      col = 0
    end if
  end repeat
  if not bracketed then
    str = str & "]" & "**" & "*"
    put str
  end if
  str = "**" & "*"
  str = str & "end initcastmems" & "**" & "*"
  put str
end
on makeCastListRB
  maxcast = 18
  nam = member("castlist").number
  member(nam).text = "[\" & RETURN
  mem = 0
  cst = 1
  str = EMPTY
  col = 0
  mem = mem + 1
  bracketed = 0
  repeat while 1
    if the mouseDown then
      exit repeat
    end if
    typ = member(mem, cst).type
    mem2 = mem + 1
    typ2 = member(mem2, cst).type
    if cst = g_holesCast then
      if typ = #empty and typ2 = #empty then
        exit repeat
      end if
      if typ = #empty then
        typ = #next
      end if
    end if
    if col > 0 then
      str = str & ","
    end if
    str = str & "#" & string(typ)
    mem = mem + 1
    if mem > member("LastCastMember").number - 1 and cst = 1 then
      mem = 1
      cst = g_holesCast
      typ = #next
      str = str & ",#next"
    end if
    col = col + 1
    if col > 8 or typ = #next then
      str = str & "," & "\"
      member(nam).text = member(nam).text & str & RETURN
      str = EMPTY
      col = 0
    end if
  end repeat
  if not bracketed then
    str = str & "]"
    member(nam).text = member(nam).text & str & RETURN
  end if
  member(nam).text = member(nam).text & str & RETURN
end
on setCastLoad
  repeat with x = 2 to 18
    castLib(x).preloadMode = 0
  end repeat
end
on debugSprite spr
  put "-=-=-=-=-= sprite " & string(spr) & " =-=-=-=-=-"
  put " memberNum", the memberNum of sprite spr
  put "castLibNum", the castLibNum of sprite spr
  put "      locH", the locH of sprite spr
  put "      locV", the locV of sprite spr
  put "      locZ", sprite(spr).locZ
  put "     width", the width of sprite spr
  put "    height", the height of sprite spr
  put "      rect", the rect of sprite spr
  put "      quad", sprite(spr).quad
  put "      type", the type of sprite spr
  put "   visible", sprite(spr).visible
  put "    puppet", the puppet of sprite spr
  put "       ink", the ink of sprite spr
  put "     blend", the blend of sprite spr
  put " foreColor", the foreColor of sprite spr
  put " backColor", the backColor of sprite spr
  put "    trails", the trails of sprite spr
  put "  rotation", sprite(spr).rotation
  put "     flipH", sprite(spr).flipH
  put "     flipV", sprite(spr).flipV
  put " behaviors", the scriptInstanceList of sprite spr
end
on gameover
  ballState = [#gameover, #gameover, #gameover, #gameover]
  frm = label("end")
  cursor(-1)
  playSound(member("game over snd").memberNum, 255, effectsChannel, 0)
  goFrame(frm)
end