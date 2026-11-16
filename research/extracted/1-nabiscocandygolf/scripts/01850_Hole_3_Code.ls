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
global balloonH
global balloonV
global balloonY
global balloonseq
global balloonMag
global balloonAng
global doorpic
global gumsnd
global magnetsnd
global suctionsnd
global objpath
global onXtimer

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
  holes = [point(553, 212)]
  exitPoint = [point(0, 0)]
  exitVec = [0]
  exitMag = [0]
  holeCount = 1
  teePoints = [point(173, 282), point(191, 282), point(209, 282)]
  shelfPoints = [point(109, 341), point(125, 341), point(141, 341), point(157, 341)]
  wallsInit_3()
  wallvInit_3()
  walleInit_3()
  platsInit_3()
  platvInit_3()
  plateInit_3()
  ceiling = 6
  floor = 343
  leftWall = 92
  rightWall = 582
  wmult = 11
  pmult = 6
  obstaclemem = the number of member "Hole 3 Gate"
  gumsnd = the number of member "bounce gum"
  magnetsnd = the number of member "magnet.aiff"
  suctionsnd = the number of member "suction.aiff"
  initPath()
  if voidp(balloonH) then
    balloonH = 303
    balloonV = 47
    balloonseq = 1
    balloonY = 0
  end if
  balloonMag = 0
  balloonAng = 0
  onXtimer = 0
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
    if st = #rideBalloon then
      hide(ballshad + x)
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
  numwait = 0
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
        #waitBalloon:
          setAt(ballMagnitude, plyr, 0)
          setAt(ballBounce, plyr, 0)
          setAt(ballGravity, plyr, 0)
          setAt(ballY, plyr, 0)
          x1 = 303 + 11 * numwait
          y1 = 47
          setAt(ballh, plyr, x1)
          setAt(ballv, plyr, y1)
          numwait = numwait + 1
        #rideBalloon:
          setAt(ballh, plyr, balloonH - 2)
          setAt(ballv, plyr, balloonV - 11)
          setAt(ballY, plyr, balloonY)
          setAt(ballPriority, plyr, 1)
          if the mouseDown and the mouseH > 0 then
            setAt(ballMagnitude, plyr, balloonMag)
            setAt(ballAngle, plyr, balloonAng)
            setAt(ballState, plyr, #fall)
            setAt(ballBounce, plyr, -1)
          end if
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
              vol = bnce * 10
              if vol > 255 then
                vol = 255
              end if
              playSound(puttsnd, vol, 2)
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
    if not (st = #moveball or st = #bounce or st = #fall) then
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
      if getAt(ballState, player) = #waitBalloon then
        flg = 0
      end if
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
    balspr = balllow + plyr - 1
    if getAt(ballPriority, plyr) then
      balspr = ballhigh + plyr - 1
    end if
    p1 = the loc of sprite balspr
    region = 0
    repeat with spr = 1 to 6
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
    blH = getAt(ballh, plyr)
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
        if blH < 190 then
          vectorAdd(0.15, 87, plyr)
        else
          vectorAdd(0.15, 93, plyr)
        end if
      3:
        if blH < 190 then
          vectorAdd(0.15, 273, plyr)
        else
          vectorAdd(0.15, 267, plyr)
        end if
      4:
        vectorAdd(0.15, 90, plyr)
      5:
        vectorAdd(0.15, 270, plyr)
      5:
        vectorAdd(0.1, 234, plyr)
      6:
        numwait = 0
        repeat with x = 1 to numPlayers
          if getAt(ballState, x) = #waitBalloon then
            numwait = numwait + 1
          end if
        end repeat
        if not (st = #waitBalloon or st = #rideBalloon) then
          if currentSound <> magnetsnd then
            playSound(magnetsnd, 255, 1)
            onXtimer = onXtimer + 1
          end if
        end if
        mag = getAt(ballMagnitude, plyr)
        mag = mag * 0.9
        setAt(ballMagnitude, plyr, mag)
        x1 = 303 + 11 * numwait
        y1 = 47
        x2 = getAt(ballh, plyr)
        y2 = getAt(ballv, plyr)
        dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
        if dist < 15 and mag < 0.5 or onXtimer > 3 or st = #aim or st = #drawback then
          onXtimer = 0
          setAt(ballh, plyr, x1)
          setAt(ballv, plyr, y1)
          setAt(ballMagnitude, plyr, 0)
          setAt(ballState, plyr, #waitBalloon)
        else
          ang = targeting(x1, y1, plyr)
          val = mag / 5
          if val < 1 then
            val = 1
          end if
          vectorAdd(val, ang, plyr)
        end if
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
    landingpad = obstacleshad
    gatespr = obstaclespr
    balloonlow = 29
    balloonspr = 53
    blinkspr = obstacleshad - 1
    val = frameTimer mod 200
    show(blinkspr)
    if val > 160 then
      hide(blinkspr)
    end if
    if val > 192 then
      show(blinkspr)
    end if
    if val > 195 then
      hide(blinkspr)
    end if
    val = frameTimer mod 60
    if val < 30 then
      hide(landingpad)
    else
      show(landingpad)
    end if
    doorpic = 0
    top = 8
    val = int(frameTimer / 3.0) mod 60
    if val > top then
      val = top
    end if
    doorpic = val
    if val >= top - 2 then
      doorpic = top - val
    end if
    if doorpic > 2 then
      doorpic = 2
    end if
    if doorpic < 0 then
      doorpic = 0
    end if
    set the memberNum of sprite gatespr to obstaclemem + doorpic
    ballThere = 0
    st = getAt(ballState, player)
    if st = #waitBalloon then
      ballThere = 1
    end if
    if ballThere then
      p1 = point(303, 47)
    else
      p1 = getAt(objpath, balloonseq)
    end if
    x1 = balloonH
    y1 = balloonV
    x2 = p1.locH
    y2 = p1.locV
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    if dist < 50 then
      balloonseq = balloonseq + 1
      if balloonseq > count(objpath) or ballThere then
        balloonseq = 1
        if ballThere then
          playSound(suctionsnd, 255, 9)
          setAt(ballState, player, #rideBalloon)
        end if
      end if
      p1 = getAt(objpath, balloonseq)
      x2 = p1.locH
      y2 = p1.locV
    end if
    balloonAng = trackPath(x1, y1, x2, y2)
    balloonMag = 2.0
    ang = balloonAng * PI / 180.0
    dx = balloonMag * cos(ang)
    dy = balloonMag * sin(ang)
    balloonH = balloonH + dx
    balloonV = balloonV - dy
    if balloonseq > 50 then
      balloonY = count(objpath) - balloonseq
    else
      balloonY = balloonseq
    end if
    if ballThere then
      balloonY = sqrt(dist)
    end if
    if balloonY > 40 then
      balloonY = 40
    end if
    if balloonY < 0 then
      balloonY = 0
    end if
    set the locH of sprite balloonlow to balloonH
    set the locV of sprite balloonlow to balloonV - balloonY
    set the locH of sprite balloonspr to balloonH
    set the locV of sprite balloonspr to balloonV - balloonY
  end if
end
on trackPath h1, v1, h2, v2
  dH = (h1 - h2) * 1.0
  dV = (v1 - v2) * 1.0
  if dH = 0 then
    ang = 90
  else
    ang = atan(abs(dV) / abs(dH)) * 180.0 / PI
  end if
  if dH < 0 and dV >= 0 then
  else
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
on objVectorAdd modmag, modang, objmag, objang
  ang1 = objang * PI / 180.0
  dx1 = objmag * cos(ang1)
  dy1 = objmag * sin(ang1)
  ang2 = modang * PI / 180.0
  dx2 = modmag * cos(ang2)
  dy2 = modmag * sin(ang2)
  dx = dx1 + dx2
  dy = dy1 + dy2
  rect2polar(dx, dy)
end
on hitObstacle plyr
  if getAt(ballv, plyr) < 90 then
    if getAt(ballh, plyr) > 262 and getAt(ballh, plyr) < 280 then
      if getAt(ballAngle, plyr) < 90 or getAt(ballAngle, plyr) > 270 then
        if doorpic <> 2 then
          return 1
        end if
      end if
    end if
  end if
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
  rock = 0.9
  tree = 0.1
  gum = 0.4
  case elasticity of
    1:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    2, 3:
      mlt = absorb(gum, plyr, Ref, incidence)
      vol = mlt * mag * 8
      playSound(gumsnd, vol, 2)
    4, 7, 8, 9, 10:
      mlt = absorb(rock, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bricksnd, vol, 2)
    5, 6:
      mlt = absorb(tree, plyr, Ref, incidence)
      vol = mlt * mag * 10
      playSound(treesnd, vol, 2)

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
              playSound(cupsnd, 255, 4)
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
  objpath = [point(306, 51), point(306, 51), point(306, 51), point(304, 50), point(300, 47), point(292, 44), point(289, 43), point(286, 42), point(284, 41), point(280, 40), point(277, 39), point(276, 38), point(271, 37), point(266, 36), point(262, 35), point(257, 35), point(251, 35), point(248, 34), point(244, 34), point(236, 35), point(231, 35), point(228, 37), point(226, 38), point(223, 40), point(222, 41), point(220, 42), point(219, 43), point(218, 44), point(217, 46), point(216, 47), point(213, 50), point(211, 52), point(208, 55), point(207, 57), point(205, 61), point(204, 64), point(203, 69), point(203, 73), point(203, 79), point(203, 83), point(202, 90), point(202, 96), point(203, 103), point(206, 112), point(208, 121), point(209, 125), point(210, 130), point(214, 138), point(218, 143), point(218, 143), point(218, 143), point(218, 143), point(218, 143), point(218, 144), point(218, 145), point(220, 148), point(223, 154), point(226, 158), point(226, 162), point(225, 165), point(224, 168), point(222, 172), point(220, 174), point(219, 179), point(219, 181), point(220, 185), point(221, 188), point(224, 192), point(228, 197), point(232, 200), point(237, 204), point(242, 208), point(248, 211), point(256, 213), point(260, 215), point(268, 218), point(273, 220), point(278, 221), point(283, 222), point(290, 224), point(295, 226), point(297, 227), point(300, 228), point(304, 232), point(308, 234), point(310, 236), point(311, 236), point(313, 237), point(319, 238), point(323, 239), point(330, 240), point(333, 240), point(336, 240), point(343, 241), point(351, 242), point(359, 243), point(367, 243), point(375, 245), point(382, 246), point(385, 247), point(389, 249), point(391, 250), point(393, 251), point(394, 251), point(397, 253), point(400, 259), point(405, 268), point(406, 271), point(406, 271), point(406, 271), point(406, 271), point(406, 271), point(406, 271), point(412, 277), point(419, 282), point(423, 288), point(424, 291), point(426, 296), point(429, 300), point(433, 306), point(435, 308), point(437, 308), point(441, 309), point(446, 310), point(449, 310), point(454, 311), point(462, 312), point(470, 313), point(479, 315), point(487, 315), point(490, 314), point(492, 313), point(494, 311), point(496, 309), point(498, 306), point(500, 304), point(502, 301), point(504, 298), point(507, 294), point(510, 289), point(511, 284), point(512, 282), point(513, 281), point(515, 280), point(516, 278), point(517, 278), point(522, 276), point(523, 274), point(525, 273), point(527, 272), point(530, 271), point(534, 270), point(538, 269), point(544, 268), point(546, 266), point(548, 265), point(551, 264), point(554, 261), point(556, 258), point(558, 257), point(560, 253), point(563, 249), point(564, 246), point(565, 243), point(565, 240), point(566, 237), point(566, 233), point(565, 230), point(565, 227), point(565, 224), point(564, 223), point(562, 221), point(559, 220), point(556, 219), point(553, 219), point(551, 219), point(548, 220), point(545, 221), point(542, 223), point(538, 226), point(536, 228), point(534, 230), point(531, 233), point(527, 236), point(522, 240), point(517, 245), point(513, 247), point(511, 249), point(508, 251), point(504, 252), point(497, 254), point(495, 255), point(489, 257), point(485, 257), point(481, 259), point(480, 259), point(478, 259), point(476, 260), point(475, 260), point(473, 260), point(471, 260), point(467, 259), point(463, 259), point(457, 259), point(447, 258), point(441, 257), point(435, 256), point(428, 255), point(421, 253), point(413, 252), point(406, 251), point(399, 250), point(392, 249), point(389, 250), point(384, 251), point(379, 252), point(371, 253), point(364, 253), point(359, 253), point(354, 251), point(349, 249), point(340, 245), point(336, 242), point(333, 241), point(329, 239), point(325, 237), point(321, 236), point(318, 236), point(312, 235), point(306, 234), point(298, 233), point(294, 233), point(291, 233), point(287, 232), point(280, 229), point(276, 228), point(271, 226), point(264, 223), point(255, 216), point(248, 210), point(242, 205), point(238, 200), point(234, 195), point(231, 188), point(228, 182), point(227, 174), point(223, 166), point(219, 158), point(217, 151), point(215, 145), point(215, 141), point(216, 134), point(217, 129), point(219, 124), point(221, 121), point(223, 115), point(225, 111), point(226, 106), point(226, 102), point(226, 98), point(224, 92), point(220, 86), point(217, 82), point(214, 76), point(214, 73), point(215, 69), point(216, 65), point(219, 60), point(223, 55), point(227, 51), point(232, 47), point(238, 41), point(245, 35), point(246, 34), point(253, 34), point(261, 35), point(264, 35), point(269, 35), point(272, 36), point(274, 37), point(276, 38), point(283, 39), point(285, 40), point(286, 41), point(290, 43), point(293, 44), point(295, 44), point(298, 45), point(301, 46), point(301, 46), point(302, 47)]
end