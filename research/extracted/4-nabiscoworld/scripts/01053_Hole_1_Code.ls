-- Script
global Projector
global standAlone
global loading
global nextname
global dest
global preloaded
global gamePlayMode
global holeNumber
global holeNumberDeb
global scoreCard
global parList
global front9Score
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
global whooshsnd

on prepareFrame
  if the frame < 3 then
    exit
  end if
  if numPlayers < 1 then
    exit
  end if
  if holeNumber = holeNumberDeb then
    exit
  end if
  holeNumberDeb = holeNumber
  loading = 0
  holeStrokes = duplicate(emptyList(4))
  player = 1
  wallHeight = 20
  holes = [point(381, 260)]
  exitPoint = [point(0, 0)]
  exitVec = [0]
  exitMag = [0]
  holeCount = 1
  teePoints = [point(151, 272), point(168, 277), point(185, 282)]
  shelfPoints = [point(96, 287), point(111, 276), point(214, 312), point(220, 327)]
  wallsInit_1()
  wallvInit_1()
  walleInit_1()
  platsinit_1()
  platvinit_1()
  plateinit_1()
  ceiling = 55
  floor = 344
  leftWall = 26
  rightWall = 552
  wmult = 13
  pmult = 2
  obstaclemem = the number of member "Ice Gun Blast Trails"
  whooshsnd = the number of member "Ice Gun Whoosh"
  frameTimer = 30
end
on enterFrame
  if the frame < 3 then
    pass()
  end if
  if numPlayers < 1 then
    pass()
  end if
  if voidp(ballState) then
    pass()
  end if
  gameLogic()
  if moveBalls() then
    exit
  end if
  if frameTimer > 2 then
    testRegion()
  end if
  testHoles()
  obstacle()
  showBalls()
  pass()
end
on showBalls
  repeat with x = 0 to numPlayers - 1
    if getAt(ballState, x + 1) = #inPipe then
      offs = 4000
    else
      offs = 0
    end if
    if loading = 0 then
      set the locH of sprite ballshad + x to getAt(ballh, x + 1) + offs
      set the locV of sprite ballshad + x to getAt(ballv, x + 1)
      set the memberNum of sprite ballshad + x to shadmem
      set the ink of sprite ballshad + x to 36
    end if
    y = getAt(ballY, x + 1)
    pri = getAt(ballPriority, x + 1)
    if y < 0 then
      hide(ballshad + x)
      pri = 0
    end if
    if not pri then
      set the locH of sprite balllow + x to getAt(ballh, x + 1) + offs
      set the locV of sprite balllow + x to getAt(ballv, x + 1) - y
      set the memberNum of sprite balllow + x to ballBase + x
      set the ink of sprite balllow + x to 8
      hide(ballhigh + x)
      next repeat
    end if
    set the locH of sprite ballhigh + x to getAt(ballh, x + 1) + offs
    set the locV of sprite ballhigh + x to getAt(ballv, x + 1) - y
    set the memberNum of sprite ballhigh + x to ballBase + x
    set the ink of sprite ballhigh + x to 8
    hide(balllow + x)
  end repeat
  repeat with x = numPlayers + 1 to 4
    if loading = 0 then
      hide(ballshad + x - 1)
    end if
    hide(balllow + x - 1)
    hide(ballhigh + x - 1)
  end repeat
end
on gameLogic
  state = getAt(ballState, player)
  repeat with plyr = 1 to numPlayers
    st = getAt(ballState, plyr)
    if not (scoreCardFlag or helpFlag) then
      case st of
        #initHole:
          initHole()
        #shelf:
          h = getAt(ballh, plyr)
          putOnShelf(plyr)
          if h >= 4000 then
            h = h - 4000
          end if
          setAt(ballh, plyr, h)
        #placeball:
          if plyr = player then
            putterH = 4000
            nearestTee()
            if mouseRange() then
              setState(#waitRelease, plyr)
            end if
          end if
        #waitRelease:
          if plyr = player then
            putterH = 4000
            if not mouseRange() then
              setState(#aim, plyr)
            end if
          end if
        #aim:
          if plyr = player then
            aimPutter()
            addressball()
            if mouseRange() then
              setState(#drawback, plyr)
            end if
          end if
        #drawback:
          if plyr = player then
            aimPutter()
            addressball()
            if mouseRange() then
              val = putterForce / 5
              if val < 1 then
                val = 1
              end if
              if val > 4 then
                val = 4
              end if
              if putterForce < 90 then
                putterForce = putterForce + val
              end if
            else
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
              putterForce = 0
              addressball()
              setState(#moveball, plyr)
              movingflag = 1
              addStroke(plyr)
            end if
          end if
        #moveball:
        #fall:
          h = getAt(ballh, plyr)
          v = getAt(ballv, plyr)
          setAt(ballPriority, plyr, 0)
          bnce = getAt(ballBounce, plyr)
          mag = getAt(ballMagnitude, plyr)
          if mag < 0.2 then
            setAt(ballMagnitude, plyr, 0.1)
          end if
          if bnce <> 0 then
            bnce = bnce - 1
            if bnce = 0 then
              bnce = -1
            end if
            y = getAt(ballY, plyr)
            y = y + bnce
            if y < 0 then
              setAt(ballY, plyr, 0)
              bnce = (0 - bnce) * 0.7
              y = 0
              if abs(bnce) < 0.5 then
                bnce = 0
                y = 0
                setAt(ballState, plyr, #moveball)
                movingflag = 1
              end if
            end if
            setAt(ballY, plyr, y)
            setAt(ballBounce, plyr, bnce)
          end if
        #inPipe:
          setAt(ballMagnitude, plyr, 2)
          if the ticks > getAt(pipeTicks, plyr) then
            setAt(ballh, plyr, getAt(exitPointVal, plyr).locH)
            setAt(ballv, plyr, getAt(exitPointVal, plyr).locV)
            vec = random(20) - 10
            vec = vec + getAt(exitVecVal, plyr)
            setAt(ballAngle, plyr, vec)
            mag = random(7) - 4
            mag = mag + getAt(exitMagVal, plyr)
            setAt(ballMagnitude, plyr, mag)
            setState(#moveball, plyr)
          end if
        #bounce:
          h = getAt(ballh, plyr)
          v = getAt(ballv, plyr)
          bnce = getAt(ballBounce, plyr)
          mag = getAt(ballMagnitude, plyr)
          val = mag / 10
          if val < 0.1 then
            val = 0.1
          end if
          vectorAdd(val, 292, plyr)
          if bnce = 0 then
            max = 0
            if h < -max or v < -max or h > the stageRight - the stageLeft + max or v > the stageBottom - the stageTop + max then
              setState(#shelf, plyr)
              putOnShelf(plyr)
            end if
          else
            max = 100
            if h < -max or v < -max or h > the stageRight - the stageLeft + max or v > the stageBottom - the stageTop + max then
              setState(#shelf, plyr)
              putOnShelf(plyr)
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
              playSound(puttsnd, vol, 2)
              if bnce < 1 then
                bnce = 0
                y = 0
              end if
            end if
            setAt(ballY, plyr, y)
            setAt(ballBounce, plyr, bnce)
          end if
        #cup:
          h = getAt(ballh, plyr)
          if h < 4000 then
            h = h + 4000
          end if
          setAt(ballh, plyr, h)

      end case
    end if
  end repeat
end
on moveBalls
  repeat with plyr = 1 to numPlayers
    st = getAt(ballState, plyr)
    blY = getAt(ballY, plyr)
    if not (st = #moveball or st = #bounce) then
      next repeat
    end if
    ahit = 0
    lastDispV = -1
    lastDispH = -1
    dogravity(plyr)
    ang = getAt(ballAngle, plyr) * PI / 180.0
    dx = getAt(ballMagnitude, plyr) * cos(ang)
    dy = getAt(ballMagnitude, plyr) * sin(ang)
    if abs(dx) >= abs(dy) then
      lp = integer(abs(dx))
    else
      lp = integer(abs(dy))
    end if
    lp = lp + 1
    dx = dx / lp
    dy = dy / lp
    repeat with v = 1 to lp
      oldH = getAt(ballh, plyr)
      oldV = getAt(ballv, plyr)
      dispH = integer(oldH)
      dispV = integer(oldV)
      setH(getAt(ballh, plyr) + dx, plyr)
      if st = #moveball and blY < wallHeight then
        if dispH < leftWall then
          setH(leftWall, plyr)
        end if
        if dispH > rightWall then
          setH(rightWall, plyr)
        end if
        if lastDispH <> dispH then
          lastDispH = dispH
          insideFlg = 0
          if testPoint() then
            if rebound(plyr) then
              restoreH(plyr)
              exit repeat
            else
              ahit = 0
            end if
          end if
        end if
      end if
      setv(getAt(ballv, plyr) - dy, plyr)
      if st = #moveball and blY < wallHeight then
        if dispV < ceiling then
          setv(ceiling, plyr)
        end if
        if dispV > floor then
          setv(floor, plyr)
        end if
        if lastDispV <> dispV then
          lastDispV = dispV
          insideFlg = 0
          if testPoint() then
            if rebound(plyr) then
              restoreH(plyr)
              restoreV(plyr)
              exit repeat
            else
              ahit = 0
            end if
          end if
        end if
      end if
      if st = #moveball then
        ballcoll(plyr)
        if hitObstacle(plyr) then
          if getAt(ballAngle, plyr) < 180 then
            invertV(plyr)
            dx = 0
            dy = 0
            ang = getAt(ballAngle, plyr) * PI / 180.0
            mag = getAt(ballMagnitude, plyr)
            yval = mag * sin(ang)
            vol = abs(yval) * 30
            if vol > 255 then
              vol = 255
            end if
            playSound(puttsnd, vol, 4)
          end if
        end if
      end if
    end repeat
    collflg = ahit
    oldDispH = dispH
    oldDispV = dispV
  end repeat
  frameChanged = 0
  if movingflag then
    flg = 1
    repeat with x = 1 to numPlayers
      mag = getAt(ballMagnitude, x)
      if mag > 0 then
        flg = 0
      end if
    end repeat
    if flg then
      frameChanged = nextShot()
    end if
  end if
  return frameChanged
end
on testRegion
  repeat with plyr = 1 to numPlayers
    balspr = balllow + plyr - 1
    if getAt(ballPriority, plyr) then
      balspr = ballhigh + plyr - 1
    end if
    p1 = the loc of sprite balspr
    region = 0
    repeat with spr = 1 to 8
      r1 = the rect of sprite spr
      r1 = r1 + rect(-8, -8, 8, 8)
      if inside(p1, r1) then
        if sprite balspr intersects spr then
          region = spr
        end if
      end if
    end repeat
    mag = getAt(ballMagnitude, plyr)
    st = getAt(ballState, plyr)
    case region of
      1:
        if st = #moveball then
          p1 = getAt(teePoints, 1)
          p2 = getAt(teePoints, 3)
          dH = float(p2.locH - p1.locH)
          dV = float(p1.locV - p2.locV)
          if dH = 0.0 then
            dH = 0.01
          end if
          ang1 = atan(dV / dH) * 180.0 / PI
          if ang1 < 0 then
            ang1 = circ(ang1)
          end if
          ang2 = circ(ang1 + 180)
          ba = getAt(ballAngle, plyr)
          if ang2 > ang1 and (ba < ang1 or ba > ang2) or ang2 < ang1 and (ba < ang1 and ba > ang2) then
            setAt(ballState, plyr, #bounce)
            mag = getAt(ballMagnitude, plyr)
            if mag > 7 then
              mag = 7
            end if
            if mag < 1 then
              mag = 1
            end if
            setAt(ballBounce, plyr, mag)
            vol = mag * 10
            if vol > 255 then
              vol = 255
            end if
            playSound(puttsnd, vol, 2)
          end if
        end if
      2:
        vectorAdd(0.2, 250, plyr)
      3, 4:
        if mag > 0 then
          mag = mag * 0.99
        end if
        if mag < 0.3 then
          mag = 0
        end if
        setAt(ballMagnitude, plyr, mag)
      5:
        vectorAdd(0.1, 234, plyr)
      6:
        vectorAdd(0.1, 54, plyr)
      7:
        vectorAdd(0.2, 324, plyr)
      8:
        vectorAdd(0.2, 144, plyr)
      otherwise:
        if mag > 0 then
          mag = mag * 0.96
        end if
        if mag < 0.3 then
          mag = 0
        end if
        setAt(ballMagnitude, plyr, mag)

    end case
  end repeat
end
on obstacle
  if not (scoreCardFlag or helpFlag) then
    blastanim = [4, 3, 4, 3, 4, 3, 2, 1, 0]
    pudanim = [0, 1, 2, 1, 2, 1, 2, 1, 0]
    leftpud = obstacleshad
    leftlgts = obstaclespr + 1
    leftstream = obstaclespr + 2
    rightpud = obstacleshad + 1
    rightlgts = obstaclespr + 4
    rightstream = obstaclespr + 5
    val = int(frameTimer mod 100 / 4.0)
    if val > 8 then
      hide(leftpud)
      hide(leftlgts)
      hide(leftstream)
      hide(rightpud)
      hide(rightlgts)
      hide(rightstream)
    else
      chan = 3 - effectsChannel
      if not soundBusy(chan) and val = 0 then
        qualifyVol(chan, 255)
        puppetSound(chan, whooshsnd)
      end if
      show(leftpud)
      show(leftlgts)
      show(leftstream)
      show(rightpud)
      show(rightlgts)
      show(rightstream)
      pic1 = getAt(blastanim, val + 1)
      pic2 = getAt(pudanim, val + 1)
      if pic1 < 3 then
        hide(leftlgts)
        hide(rightlgts)
      end if
      set the memberNum of sprite leftstream to obstaclemem + 8 + pic1
      set the backColor of sprite leftstream to 6
      set the memberNum of sprite leftpud to obstaclemem + 5 + pic2
      set the backColor of sprite leftpud to 6
      set the memberNum of sprite rightstream to obstaclemem + pic1
      set the backColor of sprite rightstream to 6
      set the memberNum of sprite rightpud to obstaclemem + 13 + pic2
      set the backColor of sprite rightpud to 6
    end if
    if val <= 8 then
      repeat with plyr = 1 to numPlayers
        x1 = 260
        y1 = 125
        x2 = getAt(ballh, plyr)
        y2 = getAt(ballv, plyr)
        dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
        if dist < 10000 then
          tmp = dist
          if tmp < 100 then
            tmp = 100
          end if
          mag = 300.0 / float(tmp)
          rnd = random(10) - 5
          ang = 317 + rnd
          vectorAdd(mag, ang, plyr)
          if getAt(ballState, plyr) = #aim then
            if mag > 0.2 then
              setAt(ballState, plyr, #moveball)
              movingflag = 1
            end if
          end if
        end if
        x1 = 464
        y1 = 145
        x2 = getAt(ballh, plyr)
        y2 = getAt(ballv, plyr)
        dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
        if dist < 10000 then
          tmp = dist
          if tmp < 100 then
            tmp = 100
          end if
          mag = 300.0 / float(tmp)
          rnd = random(10) - 5
          ang = 220 + rnd
          vectorAdd(mag, ang, plyr)
          if getAt(ballState, plyr) = #aim then
            if mag > 0.2 then
              setAt(ballState, plyr, #moveball)
              movingflag = 1
            end if
          end if
        end if
      end repeat
    end if
  end if
end
on hitObstacle plyr
  return 0
end
on rebound plyr
  wa = wallAngle
  ba = getAt(ballAngle, plyr)
  incidence = acute(circ(ba - 180) - wa)
  if wa < 180 then
    if ba > wa and ba < wa + 180 then
      return 0
    end if
  else
    if ba < wa and ba > wa - 180 then
    else
      return 0
    end if
  end if
  if wa = ba or circ(wa + 180) = ba then
    ahit = 1
    return 0
  end if
  Ref = circ(wa + 180)
  refract = incidence
  mag = getAt(ballMagnitude, plyr)
  setAt(ballAngle, plyr, circ(Ref - refract))
  wood = 0.6
  brick = 0.9
  case elasticity of
    1:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    2, 3, 4, 5:
      mlt = absorb(brick, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bricksnd, vol, 2)

  end case
  return 1
end
on testHoles
  repeat with plyr = 1 to numPlayers
    hole = 0
    repeat with x = 1 to holeCount
      x1 = getAt(holes, x).locH
      y1 = getAt(holes, x).locV
      x2 = getAt(ballh, plyr)
      y2 = getAt(ballv, plyr)
      dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
      if dist < 150 then
        hole = x
        exit repeat
      end if
    end repeat
    st = getAt(ballState, plyr)
    mag = getAt(ballMagnitude, plyr)
    case hole of
      1:
        if dist < 80 then
          if dist < 16 then
            playSound(cupsnd, 255, 4)
            setState(#cup, plyr)
            h = getAt(ballh, plyr)
            if h < 4000 then
              h = h + 4000
            end if
            setAt(ballh, plyr, h)
            setAt(ballMagnitude, plyr, 0)
          else
            ang = targeting(x1, y1, plyr)
            val = mag / 5
            if val < 1 then
              val = 1
            end if
            vectorAdd(val, ang, plyr)
          end if
        end if
      2:
        if dist < 16 then
          if st = #moveball then
            prioritySound = 0
            playSound(pipe1snd, 255, 4)
            setAt(pipeTicks, plyr, the ticks + 135)
            setAt(ballState, plyr, #inPipe)
            setAt(exitVecVal, plyr, getAt(exitVec, 2))
            setAt(exitPointVal, plyr, getAt(exitPoint, 2))
            setAt(exitMagVal, plyr, getAt(exitMag, 2))
          end if
        end if
      3:
        if dist < 16 then
          if st = #moveball then
            prioritySound = 0
            playSound(pipe2snd, 255, 4)
            setAt(pipeTicks, plyr, the ticks + 164)
            setAt(ballState, plyr, #inPipe)
            setAt(exitVecVal, plyr, getAt(exitVec, 3))
            setAt(exitPointVal, plyr, getAt(exitPoint, 3))
            setAt(exitMagVal, plyr, getAt(exitMag, 3))
          end if
        end if

    end case
  end repeat
end
on testPoint
  if testH(dispH) then
    return ahit
  end if
  if testV(dispV) then
    return ahit
  end if
  return ahit
end