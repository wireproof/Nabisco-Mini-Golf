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
global cubePosList
global cubeSeq
global cubecnt
global cubeTimer
global cube1loc
global cube2loc
global cubeSeqList
global cubepic

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
  holes = [point(224, 275)]
  exitPoint = [point(0, 0)]
  exitVec = [0]
  exitMag = [0]
  holeCount = 1
  teePoints = [point(537, 296), point(555, 296), point(573, 296)]
  shelfPoints = [point(529, 340), point(547, 337), point(565, 337), point(583, 340)]
  wallsInit_2()
  wallvInit_2()
  walleInit_2()
  platsInit_2()
  platvInit_2()
  plateInit_2()
  ceiling = 21
  floor = 343
  leftWall = 178
  rightWall = 616
  wmult = 15
  pmult = 5
  obstaclemem = the number of member "Hole 2 Ice Popup"
  initPosList()
  cubecnt = 0
  cubeSeqList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  cubepic = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
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
    ballmid = 26
    case pri of
      0:
        set the locH of sprite balllow + x to getAt(ballh, x + 1) + offs
        set the locV of sprite balllow + x to getAt(ballv, x + 1) - y
        set the memberNum of sprite balllow + x to ballBase + x
        set the ink of sprite balllow + x to 8
        hide(ballmid + x)
        hide(ballhigh + x)
      1:
        set the locH of sprite ballmid + x to getAt(ballh, x + 1) + offs
        set the locV of sprite ballmid + x to getAt(ballv, x + 1) - y
        set the memberNum of sprite ballmid + x to ballBase + x
        set the ink of sprite ballmid + x to 8
        hide(balllow + x)
        hide(ballhigh + x)
      2:
        set the locH of sprite ballhigh + x to getAt(ballh, x + 1) + offs
        set the locV of sprite ballhigh + x to getAt(ballv, x + 1) - y
        set the memberNum of sprite ballhigh + x to ballBase + x
        set the ink of sprite ballhigh + x to 8
        hide(balllow + x)
        hide(ballmid + x)

    end case
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
          testOffScreen(h, v, plyr, bnce)
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
          if val > 0.3 then
            val = 0.3
          end if
          vectorAdd(val, 292, plyr)
          testOffScreen(h, v, plyr, bnce)
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
on testOffScreen h, v, plyr, bnce
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
          dx = 0
          dy = 0
          exit repeat
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
    balspr = balllow + plyr - 1
    if getAt(ballPriority, plyr) = 1 then
      balspr = 26 + plyr - 1
    end if
    if getAt(ballPriority, plyr) = 2 then
      balspr = ballhigh + plyr - 1
    end if
    p1 = the loc of sprite balspr
    region = 0
    repeat with spr = 1 to 7
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
        vectorAdd(0.3, 270, plyr)
      3:
        vectorAdd(0.2, 270, plyr)
      4:
        x1 = 411
        y1 = 200
        x2 = getAt(ballh, plyr)
        y2 = getAt(ballv, plyr)
        ang = targeting(x1, y1, plyr)
        ang = circ(ang + 180)
        val = mag / 15.0
        if val < 1 then
          val = 1
        end if
        vectorAdd(0.3, ang, plyr)
      5:
        vectorAdd(0.5, 180, plyr)
      6:
        vectorAdd(0.5, 0, plyr)
      7:
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
    icecubespr = 120
    repeat with x = 0 to 11
      cube = x + 1
      spr = icecubespr + x
      if cube < 7 then
        sprite(spr).locZ = 25
      else
        sprite(spr).locZ = 30
      end if
      val = getAt(cubeSeqList, cube)
      pic = 20 - val
      if pic > 10 then
        pic = 20 - pic
      end if
      if pic > 3 then
        pic = 3
      end if
      if pic < 0 then
        pic = 0
      end if
      setAt(cubepic, cube, pic)
      if pic = 0 then
        hide(spr)
      else
        show(spr)
        set the memberNum of sprite spr to obstaclemem + pic - 1
      end if
      if val > 0 then
        val = val - 1
      end if
      setAt(cubeSeqList, cube, val)
    end repeat
    if max(cubeSeqList) = 0 then
      cubecnt = cubecnt + 1
      if cubecnt > 7 then
        cubecnt = 1
      end if
      case cubecnt of
        1:
          cubeSeqList = [30, 32, 34, 36, 38, 40, 52, 50, 48, 46, 44, 42]
        2:
          cubeSeqList = [30, 32, 34, 36, 38, 40, 30, 32, 34, 36, 38, 40]
        3:
          cubeSeqList = [40, 38, 36, 34, 32, 30, 40, 38, 36, 34, 32, 30]
        4:
          cubeSeqList = [30, 30, 30, 30, 30, 30, 0, 0, 0, 0, 0, 0]
        5:
          cubeSeqList = [0, 0, 0, 0, 0, 0, 30, 30, 30, 30, 30, 30]
        6:
          cubeSeqList = [30, 50, 30, 50, 30, 50, 30, 50, 30, 50, 30, 50]
        7:
          cubeSeqList = [60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]

      end case
    end if
    repeat with plyr = 1 to 4
      blv = getAt(ballv, plyr)
      pri = 0
      if blv > 41 then
        pri = 1
      end if
      if blv > 76 then
        pri = 2
      end if
      if getAt(ballY, plyr) > 0 then
        pri = 2
      end if
      if getAt(ballState, plyr) = #bounce then
        pri = 2
      end if
      setAt(ballPriority, plyr, pri)
    end repeat
  end if
end
on hitObstacle plyr
  repeat with cube = 1 to 12
    p1 = getAt(cubePosList, cube)
    x1 = p1.locH
    y1 = p1.locV
    blH = getAt(ballh, plyr)
    blv = getAt(ballv, plyr)
    dx = blH - x1
    dy = blv - y1
    if abs(dx) > 20 or abs(dy) > 20 then
      next repeat
    end if
    dist = dx * dx + dy * dy
    if dist > 441 then
      next repeat
    end if
    case getAt(cubepic, cube) of
      1, 2:
        if getAt(cubeSeqList, cube) > 10 then
          setAt(ballState, plyr, #bounce)
          setAt(ballAngle, plyr, 270)
          setAt(ballMagnitude, plyr, 1)
          setAt(ballBounce, plyr, 15)
          playSound(firesnd, 120, 4)
          return 1
        end if
      3:
        ang = circ(targeting(x1, y1, plyr) - 180)
        mag = 21.5
        ang1 = ang * PI / 180.0
        dx1 = mag * cos(ang1)
        dy1 = mag * sin(ang1)
        newH = x1 + dx1
        newV = y1 - dy1
        oldmag = getAt(ballMagnitude, plyr)
        setAt(ballh, plyr, newH)
        setAt(ballv, plyr, newV)
        elasticity = 2
        wallAngle = circ(ang - 90)
        rebound(plyr)
        return 1

    end case
  end repeat
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
    2, 3, 4:
      mlt = absorb(rock, plyr, Ref, incidence)
      vol = mlt * mag * 8
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
on initPosList
  cubePosList = []
  add(cubePosList, point(304, 39))
  add(cubePosList, point(340, 39))
  add(cubePosList, point(376, 39))
  add(cubePosList, point(413, 39))
  add(cubePosList, point(448, 39))
  add(cubePosList, point(486, 39))
  add(cubePosList, point(304, 72))
  add(cubePosList, point(340, 72))
  add(cubePosList, point(376, 72))
  add(cubePosList, point(413, 72))
  add(cubePosList, point(448, 72))
  add(cubePosList, point(486, 72))
  cubeSeq = [1, 11, 10, 8, 2, 7, 5, 6, 9, 4, 12, 3]
end