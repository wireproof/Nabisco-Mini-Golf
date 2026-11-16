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
global path1
global path2
global path3
global path4
global path5
global fanState
global fanTimer
global fansnd
global fanList
global ballFly

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
  holes = [point(419, 236)]
  exitPoint = [point(0, 0)]
  exitVec = [0]
  exitMag = [0]
  holeCount = 1
  teePoints = [point(556, 290), point(574, 290), point(592, 290)]
  shelfPoints = [point(548, 311), point(566, 311), point(584, 311), point(602, 311)]
  ballPriority = [0, 0, 0, 0]
  initPath()
  ceiling = 32
  floor = 341
  leftWall = 125
  rightWall = 616
  wmult = 13
  pmult = 6
  wallsInit_17()
  wallvInit_17()
  walleInit_17()
  platsinit_17()
  platvinit_17()
  plateinit_17()
  obstaclemem = the number of member "Hole 17 Background"
  fansnd = the number of member "fan loop.aiff"
  floaterH = [0, 0, 0, 0]
  floaterV = [0, 0, 0, 0]
  ballRiding = [0, 0, 0, 0]
  floaterind = [0, 0, 0, 0]
  floating = 0
  fanState = #slow
  fanTimer = 90
  fanList = []
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
    st = getAt(ballState, x + 1)
    if st = #inPipe then
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
          fanState = #slow
          fanTimer = 90
          fanList = []
        #shelf:
          h = getAt(ballh, plyr)
          putOnShelf(plyr)
          if h >= 4000 then
            h = h - 4000
          end if
          setAt(ballh, plyr, h)
          setAt(ballPriority, plyr, 1)
        #placeball:
          if plyr = player then
            putterH = 4000
            setAt(ballPriority, plyr, 1)
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
        #fan:
          ind = ballFly + 1
          if ind > count(fanList) then
            setState(#shelf, plyr)
            putOnShelf(plyr)
            if plyr = player then
              setAt(ballMagnitude, plyr, 1)
              movingflag = 1
            end if
            setAt(ballGravity, plyr, 0)
            exit
          end if
          pt = getAt(fanList, ind)
          setAt(ballh, plyr, pt.locH)
          setAt(ballv, plyr, pt.locV)
          setAt(ballY, plyr, ballFly * 3)
          ballFly = ballFly + 1
        #fall:
          if getAt(ballMagnitude, plyr) < 2.0 then
            vectorAdd(0.2, 270, plyr)
          end if
          if getAt(ballY, plyr) < -50 then
            playSound(bubsnd + random(3) - 1, 255, 9)
            setState(#shelf, plyr)
            putOnShelf(plyr)
            if plyr = player then
              setAt(ballMagnitude, plyr, 1)
              movingflag = 1
            end if
            setAt(ballGravity, plyr, 0)
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
    if not (st = #moveball or st = #bounce or st = #fall) then
      next repeat
    end if
    bH = getAt(ballh, plyr)
    bV = getAt(ballv, plyr)
    if st = #moveball or st = #fall then
      flg = 0
      if bH < leftWall - 1 then
        flg = 1
      end if
      if bH > rightWall + 1 then
        flg = 1
      end if
      if bV < ceiling - 1 then
        flg = 1
      end if
      if bV > floor + 1 then
        flg = 1
      end if
      if flg then
        setState(#shelf, plyr)
        putOnShelf(plyr)
        if plyr = player then
          setAt(ballMagnitude, plyr, 1)
          playSound(buzzsnd, 150, 2)
        end if
        next repeat
      end if
    end if
    ahit = 0
    dogravity(plyr)
    lastDispV = -1
    lastDispH = -1
    dogravity(plyr)
    ang = getAt(ballAngle, plyr) * PI / 180.0
    dx = getAt(ballMagnitude, plyr) * cos(ang)
    dy = getAt(ballMagnitude, plyr) * sin(ang)
    blY = getAt(ballY, plyr)
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
      if st = #moveball or st = #fall and blY < 10 then
        ballcoll(plyr)
        if hitObstacle(plyr, oldH) then
          if rebound(plyr) then
            dx = 0
            dy = 0
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
      if getAt(ballMagnitude, x) > 0 then
        flg = 0
      end if
      if getAt(ballY, x) <> 0 then
        flg = 0
      end if
      if getAt(ballBounce, x) <> 0 then
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
    balspr = ballshad + plyr - 1
    p1 = the loc of sprite balspr
    region = 0
    repeat with spr = 1 to 3
      r1 = the rect of sprite spr
      r1 = r1 + rect(-8, -8, 8, 8)
      if inside(p1, r1) then
        if sprite balspr intersects spr then
          region = spr
        end if
      end if
    end repeat
    mag = getAt(ballMagnitude, plyr)
    ang = getAt(ballAngle, plyr)
    st = getAt(ballState, plyr)
    blY = getAt(ballY, plyr)
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
        vectorAdd(0.2, 280, plyr)
      3:
        if st <> #fan then
          if fanState = #fast then
            setAt(ballState, plyr, #fan)
            setAt(ballY, plyr, 1)
            ballFly = 0
            if getAt(ballh, plyr) < 260 then
              fanList = duplicate(path1)
            else
              fanList = duplicate(path3)
            end if
          else
            friction(plyr)
          end if
        else
          friction(plyr)
        end if
      otherwise:
        friction(plyr)

    end case
  end repeat
end
on friction plyr
  if getAt(ballY, plyr) = 0 then
    mag = getAt(ballMagnitude, plyr)
    if mag > 0 then
      mag = mag * 0.96
    end if
    if mag < 0.3 then
      mag = 0
    end if
    setAt(ballMagnitude, plyr, mag)
  end if
end
on obstacle
  if not (scoreCardFlag or helpFlag) then
    fanspr = obstacleshad
    case fanState of
      #slow:
        pic = int(frameTimer / 5.0) mod 10
        set the memberNum of sprite fanspr to obstaclemem + 4 + pic
        if fanTimer > 100 then
          prioritySound = 0
          playSound(fansnd, 200, 8)
          fanTimer = 0
          fanState = #fast
        end if
      #fast:
        pic = int(frameTimer) mod 10
        set the memberNum of sprite fanspr to obstaclemem + 4 + pic
        val = int(fanTimer / 2.0)
        showAirCrisp(120, val, path1)
        showAirCrisp(121, val, path2)
        showAirCrisp(122, val, path3)
        showAirCrisp(123, val, path4)
        showAirCrisp(124, val, path5)
        showAirCrisp(125, val + 3, path1)
        showAirCrisp(126, val + 3, path2)
        showAirCrisp(127, val + 3, path3)
        showAirCrisp(128, val + 3, path4)
        showAirCrisp(129, val + 3, path5)
        if fanTimer > 60 then
          prioritySound = 0
          playSound(fansnd + 1, 200, 1)
          fanTimer = 0
          fanState = #slowdown
        end if
      #slowdown:
        pic = int(frameTimer / 3.5) mod 10
        set the memberNum of sprite fanspr to obstaclemem + 4 + pic
        val = int((fanTimer + 60) / 2.0)
        showAirCrisp(120, val, path1)
        showAirCrisp(121, val, path2)
        showAirCrisp(122, val, path3)
        showAirCrisp(123, val, path4)
        showAirCrisp(124, val, path5)
        showAirCrisp(125, val + 3, path1)
        showAirCrisp(126, val + 3, path2)
        showAirCrisp(127, val + 3, path3)
        showAirCrisp(128, val + 3, path4)
        showAirCrisp(129, val + 3, path5)
        if fanTimer > 65 then
          fanTimer = 0
          fanState = #slow
        end if

    end case
    fanTimer = fanTimer + 1
  else
    if currentSound = fansnd then
      sound(#stop, effectsChannel)
    end if
  end if
end
on showAirCrisp spr, val, lst
  ind = val + 1
  if voidp(lst) then
    exit
  end if
  if not listp(lst) then
    exit
  end if
  if ind < 1 or ind > count(lst) then
    ind = ind - count(lst)
  end if
  pic = ind mod 5
  pt = getAt(lst, ind)
  z = 42.5
  if val < 4 or val > count(lst) then
    pic = spr mod 5
    z = 13
  end if
  set the loc of sprite spr to pt
  sprite(spr).locZ = z
  set the memberNum of sprite spr to obstaclemem + 14 + pic
end
on hitObstacle plyr, oldH
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
  wood = 0.7
  rock = 0.9
  bumper = 0.4
  metal = 0.4
  case elasticity of
    1:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    2, 3:
      mlt = absorb(rock, plyr, Ref, incidence)
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
        if getAt(ballY, plyr) < 5 then
          if dist < 80 then
            if dist < 16 then
              playSound(cupsnd, 255, 8)
              setState(#cup, plyr)
              h = getAt(ballh, plyr)
              if h < 4000 then
                h = h + 4000
              end if
              setAt(ballh, plyr, h)
              setAt(ballY, plyr, 0)
              setAt(ballBounce, plyr, 0)
              setAt(ballMagnitude, plyr, 0)
              movingflag = 1
            else
              ang = targeting(x1, y1, plyr)
              val = mag / 5
              if val < 1 then
                val = 1
              end if
              vectorAdd(val, ang, plyr)
            end if
          end if
        end if
      2, 3, 4, 8:
        if dist < 99 then
          if st = #moveball then
            prioritySound = 0
            playSound(pipe1snd, 255, 4)
            setAt(pipeTicks, plyr, the ticks + 135)
            setAt(ballState, plyr, #inPipe)
            setAt(exitVecVal, plyr, getAt(exitVec, hole))
            setAt(exitPointVal, plyr, getAt(exitPoint, hole))
            setAt(exitMagVal, plyr, getAt(exitMag, hole))
          end if
        end if
      5, 6, 7:
        if dist < 99 then
          if st = #moveball then
            prioritySound = 0
            playSound(pipe2snd, 255, 4)
            setAt(pipeTicks, plyr, the ticks + 164)
            setAt(ballState, plyr, #inPipe)
            setAt(exitVecVal, plyr, getAt(exitVec, hole))
            setAt(exitPointVal, plyr, getAt(exitPoint, hole))
            setAt(exitMagVal, plyr, getAt(exitMag, hole))
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
on initPath
  path1 = [point(233, 99), point(243, 89), point(252, 88), point(266, 95), point(279, 108), point(279, 128), point(273, 142), point(246, 147), point(220, 125), point(233, 95), point(265, 90), point(279, 113), point(266, 136), point(243, 141), point(226, 108), point(259, 75), point(285, 73), point(277, 112), point(245, 107), point(216, 45), point(248, 27), point(286, 42), point(263, 65), point(238, 43), point(244, -5), point(289, -16), point(295, 4), point(276, 15), point(246, -18), point(250, -51), point(281, -57), point(297, -53), point(277, -42), point(251, -67), point(253, -81), point(285, -79), point(304, -58), point(299, -39), point(287, -24), point(277, -10), point(271, -4), point(265, 3), point(258, 10), point(251, 14), point(249, 17), point(246, 22), point(244, 28), point(243, 32), point(245, 37), point(250, 45), point(257, 54), point(259, 61), point(258, 65), point(254, 70), point(247, 75), point(244, 76), point(242, 78), point(239, 82), point(237, 87), point(233, 99)]
  path2 = [point(272, 100), point(274, 104), point(280, 118), point(281, 135), point(276, 149), point(261, 156), point(241, 157), point(227, 148), point(218, 123), point(232, 103), point(253, 98), point(267, 105), point(273, 125), point(264, 144), point(246, 144), point(232, 114), point(259, 92), point(281, 91), point(274, 115), point(248, 121), point(223, 85), point(237, 60), point(278, 67), point(275, 93), point(245, 86), point(222, 47), point(251, 13), point(282, 9), point(276, 27), point(249, 28), point(226, -16), point(246, -46), point(290, -57), point(294, -45), point(268, -35), point(248, -57), point(246, -76), point(272, -75), point(289, -60), point(290, -40), point(285, -15), point(277, -5), point(266, 3), point(256, 6), point(247, 13), point(243, 20), point(240, 30), point(243, 39), point(251, 44), point(262, 48), point(278, 53), point(288, 61), point(292, 68), point(290, 74), point(265, 92), point(264, 95), point(265, 98), point(272, 102), point(273, 102), point(272, 100)]
  path3 = [point(277, 146), point(264, 154), point(245, 146), point(221, 130), point(217, 110), point(229, 99), point(261, 93), point(283, 102), point(287, 119), point(270, 142), point(248, 142), point(230, 111), point(243, 86), point(276, 81), point(285, 101), point(267, 112), point(221, 96), point(215, 55), point(260, 26), point(293, 27), point(282, 51), point(254, 38), point(234, 7), point(254, -20), point(280, -25), point(273, -5), point(255, -10), point(225, -48), point(238, -62), point(262, -59), point(284, -43), point(290, -30), point(286, -17), point(277, -8), point(268, 1), point(253, 13), point(245, 24), point(239, 44), point(243, 61), point(254, 72), point(269, 82), point(287, 93), point(292, 101), point(291, 104), point(286, 108), point(278, 113), point(271, 119), point(266, 123), point(263, 129), point(264, 133), point(267, 139), point(269, 144), point(270, 145), point(271, 147), point(273, 146), point(274, 146), point(274, 146), point(273, 146), point(274, 146), point(277, 146)]
  path4 = [point(241, 142), point(237, 126), point(242, 105), point(254, 94), point(282, 90), point(301, 102), point(301, 133), point(281, 149), point(246, 139), point(231, 108), point(251, 82), point(279, 76), point(280, 97), point(254, 106), point(225, 76), point(230, 42), point(262, 29), point(278, 46), point(268, 60), point(234, 36), point(236, 5), point(263, -16), point(283, -18), point(275, -5), point(262, -13), point(254, -45), point(277, -59), point(296, -61), point(292, -52), point(273, -48), point(246, -55), point(248, -55), point(264, -47), point(275, -28), point(274, -16), point(265, -7), point(258, -2), point(253, 2), point(248, 7), point(240, 18), point(241, 31), point(249, 41), point(258, 46), point(269, 55), point(278, 65), point(279, 70), point(276, 77), point(272, 82), point(265, 89), point(261, 92), point(256, 96), point(250, 103), point(247, 108), point(246, 115), point(247, 122), point(246, 128), point(245, 133), point(244, 139), point(243, 144), point(241, 142)]
  path5 = [point(244, 100), point(258, 96), point(274, 101), point(283, 115), point(275, 141), point(258, 150), point(233, 135), point(237, 105), point(265, 94), point(273, 97), point(263, 127), point(248, 127), point(226, 102), point(234, 74), point(272, 58), point(284, 75), point(266, 100), point(232, 84), point(220, 48), point(246, 32), point(273, 25), point(268, 46), point(249, 48), point(231, 22), point(235, -5), point(259, -22), point(271, -15), point(267, 3), point(254, -7), point(244, -35), point(256, -41), point(282, -38), point(295, -31), point(293, -27), point(289, -23), point(279, -14), point(268, -3), point(259, 6), point(250, 18), point(240, 31), point(237, 43), point(241, 51), point(250, 58), point(255, 69), point(255, 78), point(249, 88), point(243, 96), point(237, 102), point(232, 108), point(228, 115), point(226, 114), point(229, 113), point(231, 112), point(233, 108), point(233, 107), point(237, 105), point(238, 104), point(239, 102), point(241, 101), point(244, 100)]
end