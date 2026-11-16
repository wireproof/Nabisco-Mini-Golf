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
global LoopDeLoopsnd
global LoopDeLoop
global LoopSpeed
global LeftToRight
global path1

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
  holes = [point(263, 242), point(187, 49), point(179, 159), point(405, 87), point(319, 84)]
  exitPoint = [point(0, 0), point(179, 173), point(179, 173), point(298, 81), point(426, 93)]
  exitVec = [0, 260, 260, 180, 350]
  exitMag = [0, 3, 2, 15, 15]
  holeCount = 5
  teePoints = [point(535, 261), point(553, 264), point(570, 266)]
  shelfPoints = [point(517, 317), point(517 + 18, 317 + 3), point(517 + 36, 317 + 6), point(517 + 54, 317 + 9)]
  wallsInit_9()
  wallvInit_9()
  walleInit_9()
  platsinit_9()
  platvinit_9()
  plateinit_9()
  ceiling = 14
  floor = 337
  leftWall = 129
  rightWall = 613
  wmult = 15
  pmult = 7
  initPath()
  obstaclemem = the number of member "Hole 9 Background"
  LoopDeLoopsnd = the number of member "LoopDeLoop3.AIFF"
  LoopDeLoop = 0
  LeftToRight = 0
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
    if y < 0 or getAt(ballState, x + 1) = #inPipe then
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
  repeat with plyr = 1 to numPlayers
    st = getAt(ballState, plyr)
    if not (scoreCardFlag or helpFlag) then
      case st of
        #initHole:
          initHole()
          LoopDeLoop = 0
          LeftToRight = 0
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
        #LoopDeLoop:
          setAt(ballMagnitude, plyr, 2)
          ind = int(LoopDeLoop)
          if ind < 1 or ind > count(path1) then
            setAt(ballh, plyr, getAt(exitPointVal, plyr).locH)
            setAt(ballv, plyr, getAt(exitPointVal, plyr).locV)
            vec = getAt(exitVecVal, plyr)
            if readhackv(getAt(holeStrokes, plyr)) = 1 then
              vec = 158 + random(4)
            end if
            setAt(ballAngle, plyr, vec)
            mag = getAt(exitMagVal, plyr)
            setAt(ballMagnitude, plyr, mag)
            setState(#moveball, plyr)
            setAt(ballPriority, plyr, 1)
            LoopDeLoop = 0
          else
            mag = getAt(ballMagnitude, plyr)
            pt = getAt(path1, ind)
            setAt(ballh, plyr, pt.locH)
            setAt(ballv, plyr, pt.locV)
            pri = 0
            if ind >= 40 and ind <= 78 then
              pri = 1
            end if
            if ind >= 125 and ind <= 173 then
              pri = 1
            end if
            if ind >= 210 then
              pri = 1
            end if
            setAt(ballPriority, plyr, pri)
            if LeftToRight then
              LoopDeLoop = LoopDeLoop - LoopSpeed
            else
              was = LoopDeLoop
              LoopDeLoop = LoopDeLoop + LoopSpeed
            end if
          end if
        #inPipe:
          setAt(ballMagnitude, plyr, 2)
          if the ticks > getAt(pipeTicks, plyr) then
            setAt(ballh, plyr, getAt(exitPointVal, plyr).locH)
            setAt(ballv, plyr, getAt(exitPointVal, plyr).locV)
            vec = random(20) - 10
            vec = vec + getAt(exitVecVal, plyr)
            setAt(ballAngle, plyr, vec)
            mag = random(3) - 1
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
    repeat with spr = 1 to 5
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
        if mag > 0 then
          mag = mag * 0.8
        end if
        if mag < 0.3 then
          mag = 0
        end if
        setAt(ballMagnitude, plyr, mag)
      3:
        if st <> #LoopDeLoop then
          if getAt(ballY, plyr) = 0 then
            playSound(bubsnd + random(3) - 1, 255, 9)
            setState(#shelf, plyr)
            putOnShelf(plyr)
            if plyr = player then
              setAt(ballMagnitude, plyr, 1)
              movingflag = 1
            end if
          end if
        end if
      4:
        vectorAdd(0.4, 334, plyr)
      5:
        vectorAdd(0.4, 185, plyr)
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
  rock = 0.9
  metal = 0.4
  tree = 0.2
  pack = 0.5
  case elasticity of
    1:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    2, 3:
      mlt = absorb(metal, plyr, Ref, incidence)
      vol = mlt * mag * 8
      playSound(clanksnd, vol, 2)
    4, 5:
      mlt = absorb(rock, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bricksnd, vol, 2)
    6, 7:
      mlt = absorb(tree, plyr, Ref, incidence)
      vol = mlt * mag * 5
      playSound(treesnd, vol, 2)
    8:
      mlt = absorb(pack, plyr, Ref, incidence)
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
        if dist < 80 then
          if dist < 16 then
            playSound(cupsnd, 255, 9)
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
        if dist < 80 then
          if dist < 16 then
            if st <> #inPipe then
              prioritySound = 0
              playSound(pipe1snd, 255, 4)
              setAt(pipeTicks, plyr, the ticks + 135)
              setAt(ballState, plyr, #inPipe)
              setAt(exitVecVal, plyr, getAt(exitVec, hole))
              setAt(exitPointVal, plyr, getAt(exitPoint, hole))
              setAt(exitMagVal, plyr, getAt(exitMag, hole))
              setAt(ballMagnitude, plyr, 2)
              movingflag = 1
            end if
          else
            ang = targeting(x1, y1, plyr)
            val = mag / 5
            if val < 1 then
              val = 1
            end if
            vectorAdd(val, ang, plyr)
          end if
        end if
      3:
        if dist < 99 then
          if st <> #inPipe then
            prioritySound = 0
            playSound(pipe2snd, 255, 4)
            setAt(pipeTicks, plyr, the ticks + 164)
            setAt(ballState, plyr, #inPipe)
            setAt(exitVecVal, plyr, getAt(exitVec, hole))
            setAt(exitPointVal, plyr, getAt(exitPoint, hole))
            setAt(exitMagVal, plyr, getAt(exitMag, hole))
            setAt(ballMagnitude, plyr, 2)
            movingflag = 1
          end if
        end if
      4, 5:
        if dist < 145 then
          if st <> #LoopDeLoop then
            if mag >= 8 then
              prioritySound = 0
              playSound(LoopDeLoopsnd, 255, 4)
              LoopSpeed = mag * 0.75
              setAt(ballState, plyr, #LoopDeLoop)
              vec = random(20) - 10
              setAt(exitVecVal, plyr, vec + getAt(exitVec, hole))
              setAt(exitPointVal, plyr, getAt(exitPoint, hole))
              setAt(exitMagVal, plyr, mag)
              setAt(ballMagnitude, plyr, 2)
              movingflag = 1
              LeftToRight = 0
              LoopDeLoop = 1
              if hole = 5 then
                LeftToRight = 1
                LoopDeLoop = count(path1) - 15
              end if
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
  path1 = [point(406, 88), point(406, 87), point(406, 87), point(405, 86), point(404, 85), point(403, 84), point(403, 83), point(403, 82), point(402, 80), point(402, 79), point(402, 79), point(402, 78), point(402, 77), point(403, 76), point(403, 75), point(404, 75), point(404, 74), point(404, 74), point(404, 74), point(405, 74), point(405, 74), point(405, 74), point(406, 74), point(406, 75), point(407, 75), point(408, 76), point(409, 76), point(410, 76), point(411, 77), point(411, 77), point(412, 78), point(413, 79), point(414, 79), point(414, 80), point(415, 81), point(416, 82), point(417, 83), point(417, 83), point(418, 85), point(419, 86), point(419, 87), point(419, 88), point(419, 89), point(419, 90), point(419, 91), point(420, 92), point(420, 93), point(420, 93), point(420, 94), point(419, 95), point(419, 96), point(419, 97), point(418, 98), point(418, 99), point(417, 99), point(416, 100), point(416, 100), point(415, 100), point(414, 101), point(413, 101), point(412, 101), point(411, 101), point(410, 101), point(408, 101), point(408, 101), point(406, 101), point(405, 101), point(404, 101), point(402, 100), point(401, 100), point(399, 100), point(398, 99), point(397, 99), point(396, 99), point(394, 98), point(393, 98), point(392, 97), point(391, 97), point(389, 97), point(388, 96), point(387, 96), point(385, 95), point(384, 95), point(382, 94), point(381, 93), point(380, 93), point(379, 92), point(377, 91), point(376, 91), point(375, 90), point(374, 90), point(372, 89), point(370, 88), point(368, 87), point(367, 87), point(366, 86), point(364, 85), point(363, 84), point(362, 83), point(361, 82), point(360, 81), point(359, 81), point(358, 80), point(356, 79), point(355, 78), point(354, 77), point(353, 76), point(353, 75), point(353, 74), point(353, 72), point(353, 71), point(353, 70), point(353, 69), point(353, 68), point(354, 67), point(354, 66), point(355, 66), point(356, 66), point(356, 65), point(358, 65), point(359, 65), point(360, 66), point(361, 66), point(362, 66), point(364, 67), point(365, 67), point(367, 68), point(368, 69), point(368, 69), point(369, 70), point(370, 71), point(371, 72), point(371, 73), point(372, 74), point(372, 75), point(373, 76), point(373, 77), point(373, 78), point(373, 79), point(373, 80), point(373, 81), point(373, 82), point(373, 83), point(373, 84), point(373, 85), point(373, 86), point(373, 87), point(372, 87), point(372, 88), point(371, 88), point(371, 88), point(370, 89), point(369, 89), point(367, 90), point(366, 90), point(364, 90), point(364, 90), point(363, 90), point(361, 90), point(359, 89), point(358, 89), point(356, 88), point(355, 87), point(353, 87), point(353, 86), point(352, 86), point(351, 86), point(349, 86), point(349, 85), point(348, 85), point(346, 84), point(345, 84), point(344, 83), point(343, 82), point(341, 82), point(340, 81), point(338, 81), point(337, 80), point(335, 79), point(333, 78), point(331, 77), point(329, 76), point(327, 75), point(325, 75), point(324, 74), point(323, 73), point(322, 73), point(321, 71), point(320, 71), point(320, 70), point(319, 69), point(318, 68), point(317, 68), point(316, 66), point(316, 65), point(315, 64), point(315, 63), point(315, 62), point(315, 61), point(316, 60), point(316, 60), point(316, 59), point(317, 59), point(318, 59), point(318, 59), point(319, 59), point(321, 59), point(323, 59), point(325, 61), point(327, 62), point(328, 62), point(328, 63), point(329, 64), point(330, 65), point(330, 66), point(331, 67), point(331, 69), point(332, 70), point(332, 71), point(332, 72), point(332, 73), point(332, 74), point(332, 75), point(332, 76), point(332, 76), point(331, 77), point(331, 77), point(330, 78), point(330, 79), point(329, 79), point(328, 80), point(328, 80), point(327, 80), point(327, 81), point(326, 81), point(325, 81), point(324, 82), point(324, 82), point(323, 82), point(322, 83), point(321, 83), point(320, 83), point(318, 83), point(317, 83), point(316, 83), point(314, 82), point(313, 82), point(312, 82), point(311, 81), point(310, 81), point(308, 81), point(307, 80), point(306, 80), point(304, 80), point(301, 80)]
end