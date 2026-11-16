-- Script
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
global obstaclespr_local
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
global btn1flash
global btn2flash
global btn3flash
global btn4flash
global btn5flash
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
global carbrakesnd
global carcrashsnd
global carpeeloutsnd
global carrevsnd
global bagsnd
global breadsnd
global cheesesnd
global crackersnd
global glasssnd
global grapesnd
global hydrantsnd
global legosnd
global metalcarsnd
global mousesnd
global mugsnd
global mushroomsnd
global paperclipsnd
global pensnd
global pencilsnd
global plasticspringsnd
global platesnd
global snorkelsnd
global silverwaresnd
global wallsnd
global woodenspoonsnd
global propellersnd
global rollupsnd
global rolluphitsnd
global worminsnd
global wormoutsnd
global cdspinsnd
global mouseslidesnd
global candysnd
global cupcakesnd
global candlesnd
global draweropensnd
global drawerclosesnd
global dumpsnd
global tractorarmsnd
global tractorbeepsnd
global truckforwardsnd
global truckreversesnd
global obstacleTimer
global obstacleHitSnd
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
global g_multi
global whichHole
global holeDelay
global exitHole
global minBallMag
global milkRippleMem
global milkRippleSpr
global milkRippleForce
global milkRippleSpeed
global milkRippleList
global milkRippleCount
global obstacleMemCnt
global obstacleshadmem
global obstacleDxDy
global obstacleOffset
global obstacleAngle
global obstacleLoc
global obstacleMoveTo
global obstaclePoints
global obstacleShadOffset
global obstacleCollision
global nextObstacleStateQ
global obstacle_mem
global obstacle_anim
global obstacle_ind
global obstacle_cnt
global obstacle_collision_spr
global obstacle_num
global obstacle_angle

on prepareFrame
  if the frame < 9 then
    exit
  end if
  if numPlayers < 1 then
    exit
  end if
  if holeNumber = holeNumberDeb then
    exit
  end if
  holeNumberDeb = holeNumber
  holeStrokes = emptyList(4).duplicate()
  loading = 0
  setPlayer(1)
  ceiling = [0, 0, 0, 0, 0, 0, 0, 0]
  floor = [0, 0, 0, 0, 0, 0, 0, 0]
  leftWall = [0, 0, 0, 0, 0, 0, 0, 0]
  rightWall = [0, 0, 0, 0, 0, 0, 0, 0]
  wmult = [0, 0, 0, 0, 0, 0, 0, 0]
  pmult = [0, 0, 0, 0, 0, 0, 0, 0]
  holeCount = 1
  holes = [point(226, 249)]
  exitPoint = [point(0, 0)]
  exitVec = [0]
  exitVecRnd = [0]
  exitMag = [0]
  exitMagRnd = [0]
  teePoints = [point(129, 99), point(136, 111), point(143, 123)]
  shelfPoints = [point(32, 310), point(42, 304), point(52, 300), point(61, 297)]
  screenInit_10_0()
  screenInit_10_1()
  screenInit_10_2()
  holeFlag1 = [0, 0, 0, 0]
  whichHole = [0, 0, 0, 0]
  holeDelay = [0, 0, 0, 0]
  exitHole = [0, 0, 0, 0]
  regionMap = [5, 5, 5, 5, 5, 5, 5, 5]
  obstacleHitSnd = [0, 0, 0, 0]
  obstacle_mem = member("half down").memberNum
  obstaclespr_local = 10
  obstacle_ind = 1
  obstacle_collision_spr = 8
  obstacleCollision = [0, 0, 0, 0]
  ballPriority = [25, 26, 27, 28]
end
on enterFrame
  if the frame < 9 then
    pass()
  end if
  if numPlayers < 1 then
    pass()
  end if
  if g_multi then
    doPlayback()
  end if
  gameLogic()
  if ballState[1] <> #nextHole then
    if moveBalls() then
      pass()
    end if
    if frameTimer > 2 then
      testRegion()
    end if
    testHoles()
    obstacle()
  end if
  showBalls()
  pass()
end
on showBalls
  baloffs = 0
  if currentScreen >= 4 then
    baloffs = 5
  end if
  repeat with x = 0 to numPlayers - 1
    plyr = x + 1
    pri = getAt(ballPriority, plyr)
    y = getAt(ballY, plyr)
    if y < 0 then
      if pri >= ballhigh then
        pri = balllow + x
      end if
    end if
    shad = 1
    ball = 1
    st = getAt(ballState, plyr)
    if st = #inPipe then
      ball = 0
    end if
    if st = #rattle or st = #cup then
      shad = 0
    end if
    typ = getAt(playerType, plyr)
    if not (typ = #local or typ = #remote) then
      ball = 0
    end if
    if int(getAt(ballScreen, plyr) / 4) <> int(currentScreen / 4) then
      ball = 0
    end if
    if pri < balllow then
      shad = 0
    end if
    if shad and ball then
      set the locH of sprite ballshad + x to getAt(ballh, plyr)
      set the locV of sprite ballshad + x to getAt(ballv, plyr)
      set the memberNum of sprite ballshad + x to shadmem + baloffs
      set the ink of sprite ballshad + x to 36
    else
      hide(ballshad + x)
    end if
    if ball then
      set the locH of sprite balllow + x to getAt(ballh, plyr)
      set the locV of sprite balllow + x to getAt(ballv, plyr) - y
      set the memberNum of sprite balllow + x to ballBase + baloffs + x
      set the ink of sprite balllow + x to 8
      sprite(balllow + x).locZ = pri
      next repeat
    end if
    hide(balllow + x)
  end repeat
  repeat with x = numPlayers + 1 to 4
    hide(ballshad + x - 1)
    hide(balllow + x - 1)
  end repeat
end
on gameLogic
  state = ballState[player]
  repeat with plyr = 1 to numPlayers
    baltimr = getAt(ballStateTimer, plyr)
    st = getAt(ballState, plyr)
    if not (scoreCardFlag or helpFlag) then
      case st of
        #shelf:
          putOnShelf(plyr)
        #placeball:
          if plyr = player then
            putterScreen = currentScreen
            nearestTee()
            putterH = 4000
            if mouseRange() then
              setState(plyr, #waitRelease)
            end if
          end if
        #waitRelease:
          if plyr = player then
            putterH = getAt(ballh, player)
            putterV = getAt(ballv, player)
            if not mouseRange() then
              setState(plyr, #aim)
            end if
          end if
        #aim:
          if plyr = player then
            aimPutter()
            addressball()
            if mouseRange() then
              setState(plyr, #drawback)
            end if
          end if
        #drawback:
          if plyr = player then
            aimPutter()
            addressball()
            if mouseRange() and not remoteControl then
              val = putterForce / 5
              if val < 1 then
                val = 1
              end if
              if val > 4 then
                val = 4
              end if
              if putterForce < 119 then
                putterForce = putterForce + val
              end if
            else
              if not remoteControl and rollover(ballshad + player - 1) then
                putterForce = 0
                addressball()
                setState(plyr, #aim)
              else
                if putterForce < 6 then
                  putterForce = 6
                end if
                ballAngle[plyr] = putterAngle
                ballMagnitude[plyr] = putterForce / 4
                playSound(puttsnd, putterForce * 4, 4)
                putterForce = 0
                addressball()
                setState(plyr, #moveball)
                movingflag = 1
                addStroke(plyr)
              end if
            end if
          end if
        #swing:
        #moveball:
        #inPipe:
        #bounce:
          h = getAt(ballh, plyr)
          v = getAt(ballv, plyr)
          bnce = getAt(ballBounce, plyr)
          mag = getAt(ballMagnitude, plyr)
          val = mag / 10
          if val < 0.1 then
            val = 0.1
          end if
          vectorAdd(val, 270, plyr)
          if bnce = 0 then
            max = 0
            if h < -max or v < -max or h > theStageWidth + max or v > theStageHeight + max then
              OutOfBounds(plyr)
            end if
          else
            max = 100
            if h < -max or v < -max or h > theStageWidth + max or v > theStageHeight + max then
              OutOfBounds(plyr)
            end if
          end if
          bnce = getAt(ballBounce, plyr)
          if bnce <> 0 then
            bnce = bnce - 1
            if bnce = 0 then
              bnce = -1
            end if
            y = getAt(ballY, plyr)
            y = y + bnce
            if y < 0 then
              y = 0
              bnce = (0 - bnce) * 0.9
              vol = bnce * 10
              if vol > 255 then
                vol = 255
              end if
              playSound(puttsnd, vol, 2, (255 - vol) / 25.0)
              if bnce < 1 then
                bnce = 0
                y = 0
              end if
            end if
            setAt(ballY, plyr, y)
            setAt(ballBounce, plyr, bnce)
          end if
        #rattle:
          setAt(ballMagnitude, plyr, 0.2)
          pt = getAt(exitPointVal, plyr)
          h = pt.locH
          v = pt.locV
          if baltimr < 24 then
            max = int((24 - baltimr) / 6.0)
            if max < 1 then
              max = 1
            end if
            rndH = random(max) - int(max / 2.0)
            rndV = random(max) - int(max / 2.0)
            setAt(ballh, plyr, h - rndH)
            setAt(ballv, plyr, v - rndV)
          else
            setAt(ballh, plyr, h)
            setAt(ballv, plyr, v)
            setState(plyr, #cup)
            setAt(ballMagnitude, plyr, 0)
          end if
        #cup:
          setAt(holeFlag1, plyr, 0)

      end case
    end if
    baltimr = baltimr + 1
    setAt(ballStateTimer, plyr, baltimr)
  end repeat
end
on moveBalls
  repeat with plyr = 1 to numPlayers
    st = ballState[plyr]
    scrn = ballScreen[plyr]
    if int(scrn / 4) <> int(currentScreen / 4) then
      next repeat
    end if
    leftWallLimit = leftWall[scrn + 1]
    rightWallLimit = rightWall[scrn + 1]
    ceilingLimit = ceiling[scrn + 1]
    floorLimit = floor[scrn + 1]
    bH = getAt(ballh, plyr)
    bV = getAt(ballv, plyr)
    if st = #moveball or st = #aim then
      flg = 0
      if bH < g_playareaMinH or bH > g_playareaMaxH or bV < g_playareaMinV or bV > g_playareaMaxV then
        flg = 1
      else
        if bH < leftWallLimit - 1 then
          flg = 1
        else
          if bH > rightWallLimit + 1 then
            flg = 1
          else
            if bV < ceilingLimit - 1 then
              flg = 1
            else
              if bV > floorLimit + 1 then
                flg = 1
              end if
            end if
          end if
        end if
      end if
      if flg then
        OutOfBounds(plyr)
        next repeat
      end if
    end if
    if not (st = #moveball or st = #bounce or st = #cup or st = #aim) then
      next repeat
    end if
    dogravity(plyr)
    ahit = 0
    hitob = 0
    lastDispV = -1
    lastDispH = -1
    ang = ballAngle[plyr] * PI / 180.0
    dx = ballMagnitude[plyr] * cos(ang)
    dy = ballMagnitude[plyr] * sin(ang)
    if abs(dx) >= abs(dy) then
      lp = integer(abs(dx)) + 1
    else
      lp = integer(abs(dy)) + 1
    end if
    dx = dx / lp
    dy = dy / lp
    repeat with v = 1 to lp
      oldH = ballh[plyr]
      oldV = ballv[plyr]
      dispH = integer(oldH)
      dispV = integer(oldV)
      if v > 1 then
        setH(ballh[plyr] + dx, plyr)
      else
        setH(ballh[plyr], plyr)
      end if
      if st = #moveball or st = #aim then
        if dispH < leftWallLimit then
          setH(leftWallLimit, plyr)
        end if
        if dispH > rightWallLimit then
          setH(rightWallLimit, plyr)
        end if
        if lastDispH <> dispH then
          lastDispH = dispH
          insideFlg = 0
          if testPoint(dispH, dispV, scrn) then
            if rebound(plyr) then
              obstacleCollision[plyr] = 0
              restoreH(plyr)
              exit repeat
            end if
          end if
        end if
      end if
      if v > 1 then
        setv(ballv[plyr] - dy, plyr)
      else
        setv(ballv[plyr], plyr)
      end if
      if st = #moveball or st = #aim then
        if ballv[plyr] <= ceilingLimit then
          setv(ceilingLimit + 1, plyr)
          vectorAdd(1, 270, plyr)
          wallAngle = 180
        end if
        if lastDispV <> dispV then
          lastDispV = dispV
          insideFlg = 0
          if testPoint(dispH, dispV, scrn) then
            if rebound(plyr) then
              obstacleCollision[plyr] = 0
              restoreV(plyr)
              exit repeat
            end if
          end if
        end if
        if ballv[plyr] >= floorLimit then
          setv(floorLimit - 1, plyr)
        end if
        ballcoll(plyr)
        if not hitob then
          hitob = TestHitObstacle(plyr, oldH, oldV)
          if hitob then
            ReactToObstacleCollision(plyr, obstaclespr_local)
          end if
        end if
      end if
    end repeat
    if not ahit and not hitob then
      obstacleHitSnd[plyr] = 0
    end if
    collflg = ahit
    oldDispH = dispH
    oldDispV = dispV
  end repeat
  frameChanged = 0
  if movingflag then
    flg = 1
    repeat with plyr = 1 to numPlayers
      st = ballState[plyr]
      if ballMagnitude[plyr] <> 0 or ballGravity[plyr] <> 0 or ballY[plyr] <> 0 then
        flg = 0
        exit repeat
      end if
    end repeat
    if flg then
      frameChanged = nextShot()
    end if
  end if
  return frameChanged
end
on dogravity plyr
  grav = getAt(ballGravity, plyr)
  bY = getAt(ballY, plyr)
  if grav <> 0 then
    if grav > -100 then
      grav = grav - 13
      if grav = 0 then
        grav = -1
      end if
    end if
    gnd = getAt(groundLevel, plyr)
    if bY > gnd then
      bY = bY + grav / 10.0
      if bY = gnd then
        bY = gnd + 0.1
      end if
      if bY < gnd then
        grav = hitSurface(plyr, grav, gnd, bY)
        bY = getAt(ballY, plyr)
        setAt(ballForce, plyr, grav)
      end if
    end if
  end if
  setAt(ballGravity, plyr, grav)
  setAt(ballY, plyr, bY)
end
on hitSurface plyr, grav, gnd, bY
  grav = (0 - grav) * 0.8
  vol = grav * 2
  if vol > 255 then
    vol = 255
  end if
  playSound(puttsnd, vol, 2, (255 - vol) / 25.0)
  bY = gnd + 0.1
  if grav < 32 then
    grav = 0
    bY = gnd
  end if
  ballY[plyr] = bY
  return grav
end
on testRegion
  repeat with plyr = 1 to numPlayers
    scrn = getAt(ballScreen, plyr)
    if int(scrn / 4) <> int(currentScreen / 4) then
      next repeat
    end if
    balspr = ballshad + plyr - 1
    bH = ballh[plyr]
    bV = ballv[plyr]
    p1 = point(bH, bV)
    oldRegion = ballRegion[plyr]
    maxreg = regionMap[currentScreen + 1]
    region = 0
    repeat with spr = 1 to maxreg
      r1 = the rect of sprite spr
      r1 = r1 + rect(-8, -8, 8, 8)
      if inside(p1, r1) then
        if sprite balspr intersects spr then
          region = spr
        end if
      end if
    end repeat
    ba = ballAngle[plyr]
    mag = ballMagnitude[plyr]
    st = ballState[plyr]
    bY = ballY[plyr]
    force = ballForce[plyr]
    if oldRegion > region then
      regionChanged = -1
    else
      if oldRegion < region then
        regionChanged = 1
      else
        regionChanged = 0
      end if
    end if
    min = 0
    if st = #moveball then
      ballPriority[plyr] = balllow + plyr - 1
    end if
    case region of
      0:
        if regionChanged <> 0 and st = #moveball then
          ballY[plyr] = 7
          ballv[plyr] = ballv[plyr] + 7
          ballGravity[plyr] = -1
        end if
        ballScreen[plyr] = 2
        if mag > 0 then
          mag = mag * 0.9699
        end if
        if mag < 0.2999 then
          mag = min
        end if
      1:
        offon = sprite(obstaclespr_local).locH < 2000 and sprite(obstaclespr_local).memberNum = obstacle_mem + 1
        ballScreen[plyr] = offon
        if mag > 0 then
          mag = mag * 0.9599
        end if
        if mag < 0.2999 then
          mag = min
        end if
      2:
        offon = sprite(obstaclespr_local).locH < 2000 and sprite(obstaclespr_local).memberNum = obstacle_mem + 1
        ballScreen[plyr] = offon
        if mag > 0 then
          mag = mag * 0.9799
        end if
        if mag < 0.2999 then
          mag = min
        end if
      3:
        OutOfBounds(plyr)
      4:
        if st = #moveball or st = #aim then
          if ballh[plyr] < 463 then
            ang = 310
          else
            ang = 297
          end if
          f = abs(sin(ang / 180.0 * PI) / 4.0)
          vectorAdd(f, ang, plyr)
          mag = ballMagnitude[plyr]
          if mag > 0 then
            mag = mag * 0.9799
          end if
          if mag < 0.2999 then
            mag = min
          end if
        end if
      5:
        if mag < 1.0 and st = #moveball then
          mag = 1.0
        end if
        ballScreen[plyr] = 0
      otherwise:
        if mag > 0 then
          mag = mag * 0.9699
        end if
        if mag < 0.2999 then
          mag = min
        end if

    end case
    ballMagnitude[plyr] = mag
    ballRegion[plyr] = region
  end repeat
end
on obstacle
  if not (scoreCardFlag or helpFlag) then
    obstacle_ind = obstacle_ind mod 80
    off = 0
    if obstacle_ind < 6 then
      off = 1
    end if
    if obstacle_ind > 6 + 24 and obstacle_ind < 6 + 24 + 6 then
      off = 1
    end if
    if obstacle_ind >= 6 and obstacle_ind <= 6 + 24 then
      off = 2
    end if
    result = 0
    repeat with i = 1 to numPlayers
      balspr = ballshad + i - 1
      if off = 2 and sprite(balspr).intersects(obstacle_collision_spr) then
        result = 1
      end if
    end repeat
    if off = 0 then
      hide(obstaclespr_local)
    else
      show(obstaclespr_local)
      sprite(obstaclespr_local).memberNum = obstacle_mem + off - 1
    end if
    if off = 2 and result = 1 then
      abc = 1
    else
      obstacle_ind = obstacle_ind + 1
    end if
  end if
end
on TestHitObstacle plyr, oldH, oldV
  balspr = ballshad + plyr - 1
  result = 0
  return result
end
on ReactToObstacleCollision plyr, region
end
on rebound plyr, wa
  ba = ballAngle[plyr]
  if voidp(wa) then
    wa = wallAngle
    if wa < 180 then
      if ba > wa and ba < wa + 180 then
        return 0
      end if
    else
      if not (ba < wa and ba > wa - 180) then
        return 0
      end if
    end if
  end if
  if wa = ba or circ(wa + 180) = ba then
    ahit = 1
    return 0
  end if
  incidence = acute(circ(ba - 180) - wa)
  Ref = circ(wa + 180)
  mag = ballMagnitude[plyr]
  ballAngle[plyr] = circ(Ref - incidence)
  val = elasticity
  case elasticity of
    1:
      material = mat_book
      snd = breadsnd
    2:
      material = mat_plastic
      snd = legosnd
    3:
      material = mat_cookie
      snd = crackersnd
    4:
      material = mat_bag
      snd = bagsnd
    5:
      material = mat_bag
      snd = bagsnd
    6:
      material = mat_metal
      snd = paperclipsnd
    7:
      material = mat_plastic
      snd = legosnd
    8:
      material = mat_plastic
      snd = pensnd

  end case
  vol = absorb(material, plyr, Ref, incidence) * mag * 20
  if obstacleHitSnd[plyr] = 0 then
    if vol > 255 then
      vol = 255
    end if
    playSound(snd, vol, 2, (255 - vol) / 25.0)
    obstacleHitSnd[plyr] = snd
  end if
  return 1
end
on SetupObstacleQueue
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 2, 3, 1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 2, 3, 1, 25, 0, 0.0])
  nextObstacleStateQ.add([0, 20, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 1, 8, -1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 1, 8, -1, 25, 0, 180.0])
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 3000, 0.0])
  nextObstacleStateQ.add([3000, 30, 0, 0, 0, 0, 0, 0.0])
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 3, 5, -1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 3, 5, -1, 25, 0, 255.0])
  nextObstacleStateQ.add([0, 20, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 1, 0, 1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 1, 0, 1, 25, 0, 75.0])
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 3000, 0.0])
  nextObstacleStateQ.add([3000, 30, 0, 0, 0, 0, 0, 0.0])
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 2, 3, 1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 2, 3, 1, 25, 0, 0.0])
  nextObstacleStateQ.add([0, 20, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 4, 6, 1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 4, 6, 1, 25, 0, 225.0])
  nextObstacleStateQ.add([0, 20, 0, 0, 0, 0, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 3, 6, -1, 25, 0, 225.0])
  nextObstacleStateQ.add([0, 20, 0, 0, 0, 0, 2000, 0.0])
  nextObstacleStateQ.add([2000, 9999, 1, 0, 1, 25, 1000, 0.0])
  nextObstacleStateQ.add([1000, 9999, 1, 0, 1, 25, 0, 75.0])
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 3000, 0.0])
  nextObstacleStateQ.add([3000, 120, 0, 0, 0, 0, 0, 0.0])
  nextObstacleStateQ.add([0, 15, 0, 0, 0, 0, 0, 0.0])
end
on testHoles
  repeat with plyr = 1 to numPlayers
    hole = 0
    repeat with x = 1 to holeCount
      scrn = ballScreen[plyr]
      offs = 0
      if scrn >= 4 then
        offs = 1000
      end if
      x1 = holes[x].locH - offs
      y1 = holes[x].locV
      x2 = ballh[plyr]
      y2 = ballv[plyr]
      dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
      if dist < 200 then
        hole = x
        exit repeat
      end if
    end repeat
    st = ballState[plyr]
    mag = ballMagnitude[plyr]
    bY = ballY[plyr]
    goodHole = holeFlag1[plyr]
    case hole of
      1:
        if mag > 0 and (dist < 90 and bY = 0) then
          if dist < 32 and mag < 6.0 then
            playSound(cupsnd, 255, 4, 0)
            setState(plyr, #rattle)
            ballStateTimer[plyr] = 0
            z = cupShadspr - 4 + cupZ
            cupZ = cupZ + 1
            ballPriority[plyr] = z
            exitPointVal[plyr] = point(x1, y1)
            ballMagnitude[plyr] = 0.1
            ballY[plyr] = 0
            ballGravity[plyr] = 0
            StartHoleInOne(plyr)
          else
            ang = targeting(x1, y1, plyr)
            val = mag * 0.2
            if val < 1.0 then
              val = 1.0
            end if
            vectorAdd(val, ang, plyr)
          end if
        end if

    end case
  end repeat
end
on BallInHole x, plyr, hole
  case x of
    #badHole:
      prioritySound = 0
      playSound(pipe1snd, 255, 4, 0)
      setAt(pipeTicks, plyr, the ticks + 135)
      setState(plyr, #inPipe)
      ex = 3
      vecrnd = getAt(exitVecRnd, ex)
      rnd = random(vecrnd) - vecrnd / 2
      if vecrnd = 0 then
        rnd = 0
      end if
      vec = getAt(exitVec, ex) + rnd
      magrnd = getAt(exitMagRnd, ex)
      rnd = random(magrnd) - magrnd / 2
      if magrnd = 0 then
        rnd = 0
      end if
      mag = getAt(exitMag, ex) + rnd
      setAt(exitVecVal, plyr, vec)
      setAt(exitPointVal, plyr, getAt(exitPoint, ex))
      setAt(exitMagVal, plyr, mag)
      exitHole[plyr] = ex
      holeFlag1[plyr] = 0
      holeDelay[plyr] = 0
      whichHole[plyr] = 0
    #goodHole:
      setAt(holeFlag1, plyr, 0)
      prioritySound = 0
      playSound(pipe1snd, 255, 4)
      setAt(pipeTicks, plyr, the ticks + 135)
      setState(plyr, #inPipe)
      ex = 2
      vecrnd = getAt(exitVecRnd, ex)
      rnd = random(vecrnd) - vecrnd / 2
      if vecrnd = 0 then
        rnd = 0
      end if
      vec = getAt(exitVec, ex) + rnd
      magrnd = getAt(exitMagRnd, ex)
      rnd = random(magrnd) - magrnd / 2
      if magrnd = 0 then
        rnd = 0
      end if
      mag = getAt(exitMag, ex) + rnd
      setAt(exitVecVal, plyr, vec)
      setAt(exitPointVal, plyr, getAt(exitPoint, ex))
      setAt(exitMagVal, plyr, mag)
      exitHole[plyr] = ex
      holeDelay[plyr] = 0
      whichHole[plyr] = 0
    #goodHoleDelay:
      holeFlag1[plyr] = 1
      holeDelay[plyr] = 4
      whichHole[plyr] = 2
      setState(plyr, #inHole)
      ballh[plyr] = holes[2][1]
      ballv[plyr] = holes[2][2]
      ballPriority[plyr] = balllow + plyr - 1
    #badHoleDelay:
      holeFlag1[plyr] = 0
      holeDelay[plyr] = 4
      whichHole[plyr] = hole
      setState(plyr, #inHole)
      ballh[plyr] = holes[hole][1]
      ballv[plyr] = holes[hole][2]
      ballPriority[plyr] = balllow + plyr - 1

  end case
end