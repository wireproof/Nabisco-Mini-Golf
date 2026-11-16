-- Behavior
global Projector
global standAlone
global loading
global nextname
global dest
global preloaded
global holeNumber
global scoreCard
global parList
global holeCompleted
global nextHole
global bestScore
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
global blackNums
global redNums
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
global scorespr
global lastscorespr
global numbase
global numdigits
global textflg
global textpos
global textchar
global textkern
global textseq
global gamePlayMode
global front9Score
global castmems
global loadedList
global loadingNum
global myNetIDList
global castNameList

on mouseRange
  if frameTimer > 5 then
    if the mouseDown then
      if the mouseH > 90 and the mouseH < 625 and the mouseV > 0 and the mouseV < 351 then
        return 1
      else
        return 0
      end if
    end if
  end if
  return 0
end
on compBest
  lowestScore = 99999
  repeat with plyr = 1 to 4
    tmp = 0
    repeat with x = 1 to 18
      ind = (x - 1) * 4 + plyr
      tmp = tmp + readhackv(getAt(scoreCard, ind))
    end repeat
    if tmp > 0 then
      if tmp < lowestScore then
        lowestScore = tmp
      end if
    end if
  end repeat
  return lowestScore
end
on nextShot
  movingflag = 0
  pst = getAt(ballState, player)
  if pst = #aim or pst = #drawback or pst = #placeball or pst = #waitRelease then
    exit
  end if
  flg = 1
  repeat with x = 1 to numPlayers
    st = getAt(ballState, x)
    if st <> #cup then
      flg = 0
    end if
  end repeat
  if flg then
    ballState = [#nextHole, #nextHole, #nextHole, #nextHole]
    putterH = 4000
    hn = readhackv(holeNumber)
    holeCompleted = hn
    scoreCardFlag = 1
    helpFlag = 0
    hide(helpspr)
    hide(helpspr + 1)
    showcard()
    buildCard()
    case gamePlayMode of
      #Practice:
        initHole()
        return 1
      #front9:
        if hn < 9 then
          nextHole = hn + 1
        else
          frm = label("end")
          goFrame(frm)
          return 1
        end if
      #back9:
        if hn < 18 then
          nextHole = hn + 1
        else
          frm = label("end")
          goFrame(frm)
          return 1
        end if
      #full18:
        if hn < 18 then
          nextHole = hn + 1
        else
          best = readhackv(bestScore)
          this = compBest()
          if this < best then
            bestScore = inithackv(this)
          end if
          countGames()
          ballState = [#gameover, #gameover, #gameover, #gameover]
          frm = label("end")
          goFrame(frm)
          return 1
        end if

    end case
    return 1
  end if
  who = []
  repeat with plyr = 1 to numPlayers
    pt = getAt(holes, 1)
    x1 = pt.locH
    y1 = pt.locV
    x2 = getAt(ballh, plyr)
    y2 = getAt(ballv, plyr)
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    dist = float(int(dist) + plyr / 10.0)
    if dist < 1500 then
      if state = #moveball then
        add(who, dist)
      end if
    end if
  end repeat
  if count(who) > 0 then
    sort(who)
    frac = getAt(who, 1)
    frac = frac - int(frac)
    frac = frac * 10
    player = integer(frac)
  else
    repeat while 1
      player = player + 1
      if player > numPlayers then
        player = 1
      end if
      state = getAt(ballState, player)
      if state <> #cup then
        exit repeat
      end if
    end repeat
  end if
  if state = #shelf then
    setState(#placeball, player)
  else
    setState(#aim, player)
  end if
  return 0
end
on setState val, plyr
  setAt(ballState, plyr, val)
end
on putOnShelf plyr
  h = getAt(shelfPoints, plyr).locH + 12000
  v = getAt(shelfPoints, plyr).locV
  setAt(ballh, plyr, h)
  setAt(oldballH, plyr, h)
  setAt(ballv, plyr, v)
  setAt(ballY, plyr, 0)
  setAt(ballBounce, plyr, 0)
  setAt(ballGravity, plyr, 0)
  setAt(ballMagnitude, plyr, 0)
  if plyr = player then
    putterForce = 0
  end if
end
on nearestTee
  min = 999999
  ind = 0
  repeat with x = 1 to 3
    x1 = getAt(teePoints, x).locH
    y1 = getAt(teePoints, x).locV
    x2 = the mouseH
    y2 = the mouseV
    dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    if dist < min then
      ind = x
      min = dist
    end if
  end repeat
  if ind < 1 then
    exit
  end if
  if ind > 3 then
    exit
  end if
  h = getAt(teePoints, ind).locH
  v = getAt(teePoints, ind).locV
  setAt(ballh, player, h)
  setAt(ballv, player, v)
end
on flashPlayer
  if not scoreCardFlag then
    repeat with plyr = 1 to numPlayers
      st = getAt(ballState, plyr)
      val = frameTimer mod 18
      spr = playerNamespr + plyr - 1
      flg = 0
      if st = #waitBalloon and player = plyr then
        flg = 1
      end if
      if st = #rideBalloon and player = plyr then
        flg = 1
      end if
      if st = #aim or st = #placeball or flg then
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
    unflash()
  end if
end
on unflash
  show(playerNamespr)
  show(playerNamespr + 1)
  show(playerNamespr + 2)
  show(playerNamespr + 3)
end
on throwBall
  setAt(ballAngle, 1, circ(56 + (the mouseH - oldMouseH)))
  setAt(ballMagnitude, 1, 5)
  ballheld = 0
end
on addStroke plyr
  tmp1 = getAt(holeStrokes, plyr) + 1
  ind = (readhackv(holeNumber) - 1) * 4 + plyr
  tmp2 = getAt(scoreCard, ind) + 1
  setAt(holeStrokes, plyr, tmp1)
  setAt(scoreCard, ind, tmp2)
  showScore(plyr)
end
on showScore plyr
  tmp1 = readhackv(getAt(holeStrokes, plyr))
  ind = (readhackv(holeNumber) - 1) * 4 + plyr
  tmp2 = 0
  repeat with x = 1 to 18
    ind = (x - 1) * 4 + plyr
    tmp2 = tmp2 + readhackv(getAt(scoreCard, ind))
  end repeat
  compFront(plyr)
  if tmp1 < 10 then
    str = "0" & string(tmp1)
  else
    str = string(tmp1)
  end if
  str = str & " /"
  if tmp2 < 100 then
    str = str & " "
  end if
  if tmp2 < 10 then
    str = str & "0" & string(tmp2)
  else
    str = str & string(tmp2)
  end if
  mem = score1mem + plyr - 1
  member(mem).text = str
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
on aimPutter
  targetH = the mouseH
  targetV = the mouseV
end
on addressball
  putterAngle = targeting(targetH, targetV, player)
  h = getAt(ballh, player)
  v = getAt(ballv, player)
  pic = int(circ(putterAngle + 2) / 4)
  ang = circ(putterAngle + 180) * PI / 180.0
  dist = ballwidth / 2 + 4 + putterForce
  dH = dist * cos(ang) / 2
  dV = dist * sin(ang) / 2
  putterH = h + dH
  putterV = v - dV
end
on showPutter
  if not (scoreCardFlag or helpFlag) then
    pic = int(circ(putterAngle + 2) / 4)
    set the locH of sprite putterspr to putterH
    set the locV of sprite putterspr to putterV
    set the memberNum of sprite putterspr to putterBase + pic
    set the ink of sprite putterspr to 36
  end if
end
on setupText str, xpos, ind
  l = length(str)
  repeat with x = 1 to l
    j = l - x + 1
    chr = char j of str
    case chr of
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
        q = value(chr)
      ",":
        q = 11
      otherwise:
        q = 10

    end case
    waschar = getAt(textchar, ind)
    wasX = getAt(textpos, ind)
    if wasX <> xpos then
      redraw = 1
    end if
    if waschar <> q or redraw then
      setAt(textchar, ind, q)
      setAt(textpos, ind, xpos)
      setAt(textflg, ind, 1)
    end if
    xpos = xpos - getAt(textkern, q + 1)
    ind = ind - 1
  end repeat
end
on buildCard
  hn = readhackv(holeNumber)
  actual = hn
  hn = (hn - 1) mod 9 + 1
  if actual >= 10 then
    backadd = 9
  else
    backadd = 0
  end if
  repeat with x = 0 to 47
    member(textScoremem + x).text = EMPTY
  end repeat
  repeat with loops = 1 to 3
    repeat with row = 0 to 3
      if row >= numPlayers then
        exit repeat
      end if
      accum = 0
      repeat with col = 0 to 11
        if col = hn then
          col = 9
        end if
        cardind = row + 1 + (col + backadd) * 4
        tmpmode = gamePlayMode
        if tmpmode = #full18 then
          if actual < 10 then
            tmpmode = #front9
          else
            tmpmode = #back9
          end if
        end if
        case col of
          0, 1, 2, 3, 4, 5, 6, 7, 8:
            num = readhackv(getAt(scoreCard, cardind))
            accum = accum + num
            par = getAt(parList, col + 1 + backadd)
            underPar = EMPTY
          9:
            case tmpmode of
              #Practice, #front9:
                num = 0
                underPar = EMPTY
              #back9:
                num = compFront(row + 1)
                par = 30

            end case
          10:
            case tmpmode of
              #Practice:
                num = 0
                underPar = EMPTY
              #front9:
                num = compFront(row + 1)
                over = relativeScore(row + 1)
                underPar = num2overunder(over)
                par = num - over
              #back9:
                num = compBack(row + 1)
                over = relativeScore(row + 1)
                underPar = EMPTY
                par = num - over

            end case
          11:
            case tmpmode of
              #Practice, #front9:
                num = 0
                underPar = EMPTY
              #back9:
                if actual < 18 then
                  num = compFront(row + 1) + compBack(row + 1)
                  over = relativeScore(row + 1)
                  underPar = num2overunder(over)
                  num = 999
                  par = num - over
                else
                  num = compFront(row + 1) + compBack(row + 1)
                  par = 61
                  underPar = EMPTY
                end if

            end case

        end case
        if num = 0 then
          fc = 255
        else
          if num < par then
            fc = 6
          else
            fc = 255
          end if
        end if
        mem = row * 12 + col
        spr = cardspr + mem + 1
        str = string(num)
        if num = 0 or num = 999 then
          str = EMPTY
        end if
        str = str & underPar
        member(textScoremem + mem).text = str
        set the foreColor of sprite spr to fc
      end repeat
    end repeat
    updateStage()
  end repeat
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
on qualifyVol chan, vol
  vol = int(vol)
  if vol > 255 then
    vol = 255
  end if
  if chan = 1 then
    sound1shad = vol
  end if
  if chan = 2 then
    sound2shad = vol
  end if
  if not pause then
    set the volume of sound chan to vol
  end if
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
on dogravity plyr
  grav = getAt(ballGravity, plyr)
  bY = getAt(ballY, plyr)
  if grav <> 0 then
    if grav > -100 then
      grav = grav - 13
    end if
    oldbY = bY
    if bY = 0 then
      grav = 0
    else
      bY = bY + grav / 10.0
      if bY = 0 then
        bY = 0.1
      end if
      if bY < 0 and oldbY >= 0 then
        grav = (0 - grav) * 0.8
        vol = grav * 2
        if vol > 255 then
          vol = 255
        end if
        playSound(puttsnd, vol, 2)
        bY = 0.1
        if grav < 32 then
          grav = 0
          bY = 0
        end if
      end if
    end if
  end if
  setAt(ballGravity, plyr, grav)
  setAt(ballY, plyr, bY)
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
  rect2polarBall(dx, dy, plyr)
end
on rect2polarBall dx, dy, plyr
  rect2polar(dx, dy)
  setAt(ballAngle, plyr, anglePrime)
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
end
on getVecw index
  wallAngle = getAtWallv(index)
  elasticity = getAtWalle(index)
end
on getVecp index
  wallAngle = getAtPlatv(index)
  elasticity = getAtPlate(index)
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
on absorb coeff, plyr, Ref, incid
  mag = getAt(ballMagnitude, plyr)
  ang = incid * PI / 180.0
  mid = circ(Ref + 90)
  val = mag * (1 - coeff) * abs(sin(ang))
  vectorAdd(val, mid, plyr)
  mlt = abs(sin(ang))
  return mlt
end
on playSound val, vol, pri
  if pri >= prioritySound then
    prioritySound = pri
    sound(#stop, effectsChannel)
    if vol >= 0 then
      qualifyVol(effectsChannel, vol)
    end if
    puppetSound(effectsChannel, val)
    currentSound = val
  end if
end
on setH val, plyr
  setAt(ballh, plyr, val)
  dispH = integer(val)
end
on setv val, plyr
  setAt(ballv, plyr, val)
  dispV = integer(val)
end
on puppetAll
  repeat with x = 1 to 150
    set the puppet of sprite x to 1
  end repeat
end
on puppetOff
  repeat with x = 1 to 150
    set the puppet of sprite x to 0
  end repeat
end
on puppetOffScoreOn
  repeat with x = 1 to cardspr - 3
    set the puppet of sprite x to 0
  end repeat
  repeat with x = cardspr - 2 to cardspr + 50
    set the puppet of sprite x to 1
  end repeat
  repeat with x = cardspr + 51 to 140
    set the puppet of sprite x to 0
  end repeat
end
on myatan val
  if val >= 40 then
    return 64
  end if
  ind = integer(val * 30) + 1
  return getAt(atanTable, ind)
end
on clear
  member("Score 1").text = "00 / 00"
  member("Score 2").text = "00 / 00"
  member("Score 3").text = "00 / 00"
  member("Score 4").text = "00 / 00"
  setVersion()
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
      str = str & numToChar(194) & "**" & "*"
      put str
    end if
  end repeat
end
on makeCastListOld
  maxcast = 18
  str = "**" & "*"
  str = str & "on initcastmems" & "**" & "*"
  put str
  str = "**" & "*"
  str = str & "   set castmems to ["
  str = str & numToChar(194) & "**" & "*"
  put str
  mem = 0
  str = "**" & "*     "
  col = 0
  mem = mem + 1
  bracketed = 0
  repeat while 1
    if the mouseDown then
      exit repeat
    end if
    typ = member(mem, 2).type
    mem2 = mem + 1
    typ2 = member(mem2, 2).type
    if typ = #empty and typ2 = #empty then
      exit repeat
    end if
    if col > 0 then
      str = str & ","
    end if
    if typ = #empty then
      typ = #next
    end if
    str = str & "#" & string(typ)
    col = col + 1
    if col > 8 or typ = #next then
      str = str & "," & numToChar(194) & "**" & "*"
      put str
      str = "**" & "*     "
      col = 0
    end if
    mem = mem + 1
  end repeat
  if not bracketed then
    str = str & "]" & "**" & "*"
    put str
  end if
  str = "**" & "*"
  str = str & "end initcastmems" & "**" & "*"
  put str
end
on makeCastList
  maxcast = 18
  str = "**" & "*"
  str = str & "on initcastmems" & "**" & "*"
  put str
  str = "**" & "*"
  str = str & "   set castmems to ["
  str = str & numToChar(194) & "**" & "*"
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
    if cst = 2 then
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
    if mem > 528 and cst = 1 then
      mem = 1
      cst = 2
      typ = #next
      str = str & ",#next"
    end if
    col = col + 1
    if col > 8 or typ = #next then
      str = str & "," & numToChar(194) & "**" & "*"
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
on makeIntCastList
  str = "**" & "*"
  str = str & "on initintcastmems" & "**" & "*"
  put str
  str = "**" & "*"
  str = str & "   set intcastmems to ["
  str = str & numToChar(194) & "**" & "*"
  put str
  mem = 0
  str = "**" & "*     "
  col = 0
  mem = mem + 1
  bracketed = 0
  repeat while 1
    if the mouseDown then
      exit repeat
    end if
    typ = member(mem, 1).type
    if col > 0 then
      str = str & ","
    end if
    str = str & "#" & string(typ)
    col = col + 1
    if col > 8 or typ = #next then
      str = str & "," & numToChar(194) & "**" & "*"
      put str
      str = "**" & "*     "
      col = 0
    end if
    mem = mem + 1
    if mem > 510 then
      exit repeat
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
on setCastLoad
  repeat with x = 2 to 18
    castLib(x).preloadMode = 0
  end repeat
end
on debugSprite spr
  put "      locH", the locH of sprite spr
  put "      locV", the locV of sprite spr
  put "      locZ", sprite(spr).locZ
  put "   visible", sprite(spr).visible
  put " memberNum", the memberNum of sprite spr
  put "castLibNum", the castLibNum of sprite spr
  put "    puppet", the puppet of sprite spr
  put "       ink", the ink of sprite spr
  put "      type", the type of sprite spr
  put "     width", the width of sprite spr
  put "    height", the height of sprite spr
  put " foreColor", the foreColor of sprite spr
  put " backColor", the backColor of sprite spr
  put "    trails", the trails of sprite spr
  put "      rect", the rect of sprite spr
end
on pt
  h = the locH of sprite 26
  v = the locV of sprite 26
  str = "point(" & string(h) & "," & string(v) & ")"
  put str
end
on rand12
  lst = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  repeat with x = 1 to 20
    x1 = random(12)
    x2 = random(12)
    a = getAt(lst, x1)
    setAt(lst, x1, getAt(lst, x2))
    setAt(lst, x2, a)
  end repeat
  put lst
end