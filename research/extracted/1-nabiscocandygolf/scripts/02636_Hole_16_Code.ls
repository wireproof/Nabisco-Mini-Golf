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
global floating
global floatermem
global floaterH
global floaterV
global floaterind
global toastersnd
global toasterState
global toasterTimer
global toasterpic

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
  holes = [point(369, 299), point(573, 87), point(574, 110), point(577, 142), point(480, 217), point(518, 217), point(559, 217), point(519, 291)]
  exitPoint = [point(0, 0), point(480, 227), point(518, 227), point(559, 227), point(563, 87), point(564, 110), point(567, 142), point(439, 267)]
  exitVec = [0, 260, 270, 280, 190, 180, 170, 200]
  exitMag = [0, 5, 5, 5, 5, 5, 5, 5]
  holeCount = 8
  teePoints = [point(160, 268), point(178, 268), point(196, 268)]
  shelfPoints = [point(138, 341), point(156, 341), point(174, 341), point(192, 341)]
  ballPriority = [1, 1, 1, 1]
  initPath()
  ceiling = 54
  floor = 337
  leftWall = 115
  rightWall = 587
  wmult = 13
  pmult = 8
  wallsInit_16()
  wallvInit_16()
  walleInit_16()
  platsInit_16()
  platvInit_16()
  plateInit_16()
  obstaclemem = the number of member "Hole 16 Background"
  floatermem = the number of member "Hole 16 Fruits"
  toastersnd = the number of member "toaster down.aiff"
  floaterH = [0, 0, 0, 0]
  floaterV = [0, 0, 0, 0]
  ballRiding = [0, 0, 0, 0]
  floaterind = [0, 0, 0, 0]
  floating = 0
  toasterState = #wait
  toasterTimer = 30
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
          toasterState = #wait
          toasterTimer = 30
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
          movingflag = 1
        end if
        playSound(buzzsnd, 150, 2)
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
        vectorAdd(0.2, 263, plyr)
      3:
        vectorAdd(0.2, 0, plyr)
      4:
        friction(plyr)
      5:
        if getAt(ballState, plyr) <> #fall and getAt(ballY, plyr) = 0 then
          setAt(ballGravity, plyr, -1)
          setAt(ballY, plyr, -1)
          setAt(ballState, plyr, #fall)
        end if
      6:
        if toasterpic >= 1 and toasterpic <= 3 then
          if getAt(ballGravity, plyr) = 0 then
            setAt(ballState, plyr, #moveball)
            setAt(ballAngle, plyr, 180)
            setAt(ballMagnitude, plyr, 3.3)
            setAt(ballGravity, plyr, 110)
            setAt(ballY, plyr, 30)
            playSound(firesnd, 120, 4)
          end if
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
    toastspr = 10
    toasterPlunger = 11
    if floating > 10 and the locH of sprite 12 = 109 then
      floating = 0
    end if
    spc = 22
    val = integer(floating)
    doFloater(1, 12, val + spc * 5, 0)
    doFloater(2, 13, val + spc * 4, 1)
    doFloater(3, 14, val + spc * 3, 2)
    doFloater(4, 15, val + spc * 2, 3)
    doFloater(5, 16, val + spc, 4)
    floating = floating + 0.3
    case toasterState of
      #wait:
        if toasterTimer > 30 then
          playSound(toastersnd, 200, 1)
          toasterTimer = 0
          toasterState = #down
        end if
      #down:
        v = toasterTimer * 5
        if v > 26 then
          v = 26
        end if
        set the locV of sprite toasterPlunger to 178 + v
        toasterpic = 0
        set the memberNum of sprite toastspr to obstaclemem + 14 + toasterpic
        if toasterTimer > 60 then
          playSound(toastersnd + 1, 200, 1)
          toasterTimer = 0
          toasterState = #up
        end if
      #up:
        v = toasterTimer * 9
        if v > 26 then
          v = 26
        end if
        v = 26 - v
        set the locV of sprite toasterPlunger to 178 + v
        pic = int(toasterTimer / 3.0)
        if pic > 4 then
          pic = 4
        end if
        toasterpic = pic
        set the memberNum of sprite toastspr to obstaclemem + 14 + toasterpic
        if pic = 4 then
          toasterTimer = 0
          toasterState = #wait
        end if

    end case
    toasterTimer = toasterTimer + 1
  end if
end
on hitObstacle plyr, oldH
  if toasterpic = 0 then
    return 0
  end if
  if getAt(ballY, plyr) <> 0 then
    return 0
  end if
  ba = getAt(ballAngle, plyr)
  bH = getAt(ballh, plyr)
  if ba > 0 and ba < 270 then
    if bH < 333 and oldH >= 333 or bH < 305 and oldH >= 305 then
      wallAngle = 270
      elasticity = 6
      return 1
    end if
  else
    if bH > 283 and oldH <= 283 or bH > 308 and oldH <= 308 then
      wallAngle = 90
      elasticity = 6
      return 1
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
  wood = 0.7
  rock = 0.9
  bumper = 0.4
  case elasticity of
    1, 2:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    3, 4, 5:
      mlt = absorb(rock, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bricksnd, vol, 2)
    6:
      mlt = absorb(bumper, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bumpersnd, vol, 2)

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
on doFloater whch, spr, ind, base
  picoff = [0, 3, 6, 9]
  len1 = count(path1)
  if ind >= 0 then
    ind = ind mod (len1 - 1)
    ind = ind + 1
    h = getAt(path1, ind).locH
    v = getAt(path1, ind).locV
    showspr(spr, floatermem + base, h, v, 36)
    setAt(floaterH, whch, h)
    setAt(floaterV, whch, v)
    setAt(floaterind, whch, ind)
  end if
end
on initPath
  path1 = [point(648, 295), point(642, 294), point(636, 294), point(632, 295), point(629, 294), point(626, 294), point(624, 295), point(622, 294), point(620, 294), point(618, 294), point(612, 294), point(609, 294), point(603, 294), point(595, 293), point(590, 293), point(586, 293), point(581, 293), point(576, 292), point(573, 292), point(567, 291), point(561, 290), point(557, 290), point(554, 289), point(548, 288), point(542, 287), point(536, 285), point(531, 284), point(525, 282), point(521, 280), point(516, 277), point(514, 276), point(509, 273), point(506, 272), point(500, 270), point(498, 269), point(493, 267), point(484, 265), point(477, 263), point(470, 260), point(466, 259), point(463, 258), point(459, 256), point(452, 253), point(441, 250), point(434, 249), point(432, 250), point(429, 251), point(426, 252), point(424, 252), point(420, 252), point(414, 253), point(407, 253), point(402, 254), point(398, 254), point(391, 255), point(384, 255), point(374, 257), point(367, 257), point(359, 257), point(355, 257), point(347, 258), point(342, 259), point(336, 258), point(329, 255), point(321, 253), point(316, 251), point(313, 249), point(308, 245), point(302, 241), point(296, 238), point(290, 234), point(282, 229), point(273, 224), point(265, 220), point(255, 215), point(246, 211), point(240, 209), point(234, 207), point(231, 207), point(228, 207), point(227, 207), point(224, 207), point(221, 207), point(215, 207), point(210, 206), point(206, 207), point(203, 207), point(199, 208), point(193, 208), point(190, 208), point(185, 209), point(182, 209), point(179, 209), point(176, 209), point(174, 209), point(171, 208), point(166, 207), point(164, 206), point(161, 205), point(158, 204), point(154, 203), point(152, 203), point(150, 203), point(148, 203), point(141, 203), point(132, 203), point(126, 203), point(121, 204), point(117, 205), point(112, 206), point(109, 207), point(107, 208), point(104, 209), point(102, 210), point(96, 211), point(89, 211), point(84, 211), point(79, 211), point(73, 211), point(68, 210), point(65, 210), point(62, 209), point(61, 209), point(57, 208), point(51, 207), point(46, 206), point(39, 205), point(30, 204), point(24, 204)]
end