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
global upperLevel
global upperState
global candyPath
global candyHit
global path1
global floating
global floatermem
global floaterH
global floaterV
global floaterind

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
  holes = [point(391, 248), point(538, 270), point(461, 62)]
  exitPoint = [point(0, 0), point(475, 271), point(325, 189)]
  exitVec = [0, 180, 315]
  exitMag = [0, 7, 7]
  holeCount = 3
  teePoints = [point(222, 313), point(239, 313), point(257, 313)]
  shelfPoints = [point(208, 330), point(225, 330), point(242, 330), point(259, 330)]
  ballPriority = [0, 0, 0, 0]
  upperLevel = [0, 0, 0, 0]
  upperState = 1
  setUpper(1)
  initPath()
  obstaclemem = the number of member "Hole 8 Background"
  floatermem = the number of member "Hole8 candy2"
  floaterH = [0, 0, 0, 0]
  floaterV = [0, 0, 0, 0]
  ballRiding = [0, 0, 0, 0]
  floaterind = [0, 0, 0, 0]
  candyHit = [0, 0, 0, 0]
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
    if y >= 20 or getAt(upperLevel, x + 1) then
      pri = 1
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
          candyHit = [0, 0, 0, 0]
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
            setAt(ballGravity, plyr, 70)
            setAt(ballY, plyr, 2)
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
    blY = getAt(ballY, plyr)
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
      if flg and blY < 1 then
        setState(#shelf, plyr)
        putOnShelf(plyr)
        if plyr = player then
          setAt(ballMagnitude, plyr, 1)
          movingflag = 1
        end if
        playSound(buzzsnd, 150, 2)
        next repeat
      end if
    end if
    setUpper(plyr)
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
      if st = #moveball or st = #fall and blY < wallHeight then
        ballcoll(plyr)
        if hitObstacle(plyr) then
          invertH(plyr)
          dx = 0
          dy = 0
          ang = getAt(ballAngle, plyr) * PI / 180.0
          mag = getAt(ballMagnitude, plyr)
          yval = mag * sin(ang)
          vol = abs(yval) * 30
          if vol > 255 then
            vol = 255
          end if
          playSound(woodsnd, vol, 4)
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
      if getAt(ballGravity, x) <> 0 then
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
  deflectType = [45, 315, 180, 0]
  repeat with plyr = 1 to numPlayers
    balspr = ballshad + plyr - 1
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
    ang = getAt(ballAngle, plyr)
    st = getAt(ballState, plyr)
    blY = getAt(ballY, plyr)
    wallHeight = 20
    case region of
      1:
        setAt(upperLevel, plyr, 0)
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
        if getAt(ballGravity, plyr) = 0 then
          if getAt(ballh, plyr) > 367 then
            vectorAdd(0.4, 180, plyr)
            if ang > 270 or ang < 90 then
              val = mag * 1.0
              if val > 15 then
                val = 15
              end if
              setAt(ballY, plyr, 2)
              setAt(ballMagnitude, plyr, mag * 0.75)
              setAt(ballGravity, plyr, val * 7.0)
            end if
          else
            vectorAdd(0.15, 180, plyr)
          end if
        end if
      3:
        vectorAdd(0.15, 270, plyr)
      4, 5:
        if blY < 1 then
          playSound(bubsnd + random(3) - 1, 255, 9)
          setState(#shelf, plyr)
          putOnShelf(plyr)
          if plyr = player then
            setAt(ballMagnitude, plyr, 1)
            movingflag = 1
          end if
        end if
        balspr = ballshad + plyr - 1
        p1 = the loc of sprite balspr
        if mag > 5 then
          repeat with spr = 12 to 15
            typ = spr - 11
            if getAt(candyHit, typ) > 0 then
              next repeat
            end if
            if the memberNum of sprite spr > 0 then
              r1 = the rect of sprite spr
              r1 = r1 + rect(-8, -8, 8, 8)
              if inside(p1, r1) then
                if sprite balspr intersects spr then
                  mag = getAt(ballMagnitude, plyr)
                  ang = getAt(ballAngle, plyr)
                  grv = getAt(ballGravity, plyr)
                  bY = getAt(ballY, plyr)
                  defl = getAt(deflectType, typ)
                  setAt(ballY, plyr, bY + 10)
                  setAt(ballGravity, plyr, 80)
                  setAt(ballAngle, plyr, defl)
                  setAt(ballMagnitude, plyr, mag * 1.5)
                  vol = mag * 10
                  if vol > 255 then
                    vol = 255
                  end if
                  playSound(puttsnd, vol, 2)
                  setAt(candyHit, typ, 20)
                end if
              end if
            end if
          end repeat
        end if
      6:
        if blY < 1 then
          setState(#shelf, plyr)
          putOnShelf(plyr)
          setAt(ballMagnitude, plyr, 0.1)
          movingflag = 1
          playSound(buzzsnd, 150, 2)
        end if
      7:
        wallHeight = 20
        setAt(upperLevel, plyr, 0)
        if mag > 0 then
          mag = mag * 0.96
        end if
        if mag < 0.3 then
          mag = 0
        end if
        setAt(ballMagnitude, plyr, mag)
      8:
        wallHeight = 30
        if not getAt(upperLevel, plyr) then
          if blY > 20 then
            setAt(upperLevel, plyr, 1)
          end if
          if blY < 1 and getAt(ballh, plyr) < 441 then
            playSound(bubsnd + random(3) - 1, 255, 9)
            setState(#shelf, plyr)
            putOnShelf(plyr)
            if plyr = player then
              setAt(ballMagnitude, plyr, 1)
              movingflag = 1
            end if
          end if
        end if
        if mag > 0 then
          mag = mag * 0.96
        end if
        if mag < 0.3 then
          mag = 0
        end if
        setAt(ballMagnitude, plyr, mag)
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
    waterfallspr = obstacleshad - 1
    val = int(frameTimer / 10.0) mod 3
    case val of
      0:
        hide(waterfallspr)
      1:
        show(waterfallspr)
        set the memberNum of sprite waterfallspr to obstaclemem + 1
      2:
        show(waterfallspr)
        set the memberNum of sprite waterfallspr to obstaclemem + 2

    end case
    spc = 25
    val = integer(floating)
    doFloater(1, 12, val + spc * 4, 0)
    doFloater(2, 13, val + spc * 3, 3)
    doFloater(3, 14, val + spc * 2, 6)
    doFloater(4, 15, val + spc, 9)
    floating = floating + 0.32
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
  wood = 0.7
  rock = 0.9
  case elasticity of
    1, 2, 3:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    4, 5:
      mlt = absorb(rock, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bricksnd, vol, 2)

  end case
  return 1
end
on testHoles
  repeat with plyr = 1 to numPlayers
    hole = 0
    blY = getAt(ballY, plyr)
    repeat with x = 1 to holeCount
      x1 = getAt(holes, x).locH
      y1 = getAt(holes, x).locV
      x2 = getAt(ballh, plyr)
      y2 = getAt(ballv, plyr)
      dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
      if dist < 150 and blY < 1 then
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
              playSound(cupsnd, 255, 4)
              setState(#cup, plyr)
              h = getAt(ballh, plyr)
              if h < 4000 then
                h = h + 4000
              end if
              setAt(ballh, plyr, h)
              setAt(ballY, plyr, 0)
              setAt(ballBounce, plyr, 0)
              setAt(ballGravity, plyr, 0)
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
      2:
        if getAt(ballY, plyr) < 5 then
          if dist < 99 then
            if st = #moveball then
              prioritySound = 0
              playSound(pipe1snd, 255, 4)
              setAt(pipeTicks, plyr, the ticks + 135)
              setAt(ballState, plyr, #inPipe)
              setAt(exitVecVal, plyr, getAt(exitVec, hole))
              setAt(exitPointVal, plyr, getAt(exitPoint, hole))
              setAt(exitMagVal, plyr, getAt(exitMag, hole))
              setAt(upperLevel, plyr, 0)
            end if
          end if
        end if
      3:
        if getAt(ballY, plyr) < 5 and getAt(upperLevel, plyr) then
          if dist < 99 then
            if st = #moveball then
              prioritySound = 0
              playSound(pipe1snd, 255, 4)
              setAt(pipeTicks, plyr, the ticks + 135)
              setAt(ballState, plyr, #inPipe)
              setAt(exitVecVal, plyr, getAt(exitVec, hole))
              setAt(exitPointVal, plyr, getAt(exitPoint, hole))
              setAt(exitMagVal, plyr, getAt(exitMag, hole))
              setAt(upperLevel, plyr, 0)
            end if
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
on setUpper plyr
  upr = getAt(upperLevel, plyr)
  if upr then
    setAt(ballPriority, plyr, 1)
  else
    setAt(ballPriority, plyr, 0)
  end if
  if upperState <> upr then
    if upr then
      upperState = 1
      ceiling = 7
      floor = 342
      leftWall = 178
      rightWall = 579
      wmult = 10
      pmult = 8
      setAt(ballPriority, player, 1)
      wallsInit_8a()
      wallvInit_8a()
      walleInit_8a()
      platsinit_8a()
      platvinit_8a()
      plateinit_8a()
    else
      upperState = 0
      ceiling = 7
      floor = 342
      leftWall = 178
      rightWall = 579
      wmult = 10
      pmult = 8
      setAt(ballPriority, player, 0)
      wallsInit_8()
      wallvInit_8()
      walleInit_8()
      platsinit_8()
      platvinit_8()
      plateinit_8()
    end if
  end if
end
on doFloater whch, spr, ind, base
  picoff = [0, 3, 6, 9]
  if getAt(candyHit, whch) > 0 then
    setAt(candyHit, whch, getAt(candyHit, whch) - 1)
  end if
  len1 = count(path1)
  if ind >= 0 then
    ind = ind mod (len1 - 1)
    ind = ind + 1
    h = getAt(path1, ind).locH
    v = getAt(path1, ind).locV
    pic = 0
    if v > 184 then
      pic = int((v - 184) / 4.0)
      if pic > 2 then
        pic = 2
      end if
    end if
    showspr(spr, floatermem + base + pic, h, v, 36)
    setAt(floaterH, whch, h)
    setAt(floaterV, whch, v)
    setAt(floaterind, whch, ind)
  end if
end
on initPath
  path1 = [point(233, -14), point(233, -14), point(233, -14), point(233, -13), point(233, -11), point(232, -9), point(232, -5), point(232, -4), point(233, -1), point(236, 3), point(239, 8), point(241, 10), point(243, 12), point(246, 13), point(250, 15), point(256, 17), point(261, 19), point(268, 20), point(275, 21), point(282, 22), point(289, 22), point(295, 22), point(300, 22), point(305, 22), point(311, 22), point(319, 22), point(328, 22), point(338, 22), point(345, 22), point(352, 22), point(360, 22), point(363, 22), point(365, 22), point(368, 23), point(370, 24), point(371, 24), point(373, 25), point(376, 26), point(382, 28), point(386, 30), point(388, 31), point(389, 33), point(390, 34), point(390, 36), point(391, 40), point(392, 42), point(393, 45), point(395, 49), point(396, 53), point(396, 55), point(397, 58), point(397, 61), point(397, 66), point(397, 69), point(398, 72), point(398, 76), point(398, 79), point(399, 84), point(398, 88), point(399, 92), point(399, 94), point(399, 100), point(400, 105), point(400, 107), point(400, 110), point(400, 111), point(400, 114), point(400, 116), point(401, 118), point(402, 121), point(404, 124), point(405, 127), point(405, 129), point(405, 132), point(405, 133), point(405, 136), point(405, 137), point(405, 139), point(404, 141), point(404, 143), point(404, 145), point(403, 146), point(403, 148), point(402, 150), point(401, 152), point(401, 154), point(400, 157), point(399, 159), point(398, 161), point(398, 162), point(397, 164), point(396, 166), point(396, 167), point(396, 169), point(396, 172), point(395, 174), point(395, 176), point(395, 178), point(395, 180), point(395, 182), point(395, 184), point(395, 188), point(395, 192), point(395, 196), point(395, 200)]
end