-- Script
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
global outputTimer
global oldSelected
global selectedCntr
global castmems
global loadedList
global loadingNum
global myNetIDList
global castNameList

on prepareFrame
  testLoaded()
  showLoaded()
  showhideHelp()
  dontPassEvent()
end
on enterFrame
  outputTimer = outputTimer + 1
  frameTimer = frameTimer + 1
  testLoaded()
  clearVersion()
  if btn1flash > 0 then
    btn1flash = btn1flash - 1
    if btn1flash mod 4 < 2 then
      hide(btnspr)
    else
      show(btnspr)
    end if
    if btn1flash <= 0 then
      if not scoreCardFlag then
        unflash()
        show(btnspr)
        helpFlag = 0
        hide(helpspr)
        hide(helpspr + 1)
        scoreCardFlag = 1
        showcard()
        buildCard()
      else
        scoreCardFlag = 0
        hidecard()
      end if
    end if
  else
    show(btnspr)
  end if
  if btn2flash > 0 then
    btn2flash = btn2flash - 1
    if btn2flash mod 4 < 2 then
      hide(btnspr + 1)
    else
      show(btnspr + 1)
    end if
    if btn2flash <= 0 then
      unflash()
      show(btnspr + 3)
      updateStage()
      goMenu()
      exit
    end if
  else
    show(btnspr + 1)
  end if
  if btn3flash > 0 then
    btn3flash = btn3flash - 1
    if btn3flash mod 4 < 2 then
      hide(btnspr + 2)
    else
      show(btnspr + 2)
    end if
    if btn3flash <= 0 then
      if not helpFlag then
        unflash()
        show(btnspr + 1)
        scoreCardFlag = 0
        hidecard()
        helpFlag = 1
        show(helpspr)
        show(helpspr + 1)
      else
        helpFlag = 0
        hide(helpspr)
        hide(helpspr + 1)
      end if
    end if
  else
    show(btnspr + 2)
  end if
  if btn4flash > 0 then
    btn4flash = btn4flash - 1
    if btn4flash mod 4 < 2 then
      hide(btnspr + 3)
    else
      show(btnspr + 3)
    end if
    if btn4flash <= 0 then
      unflash()
      show(btnspr + 2)
      updateStage()
      myExit()
    end if
  else
    show(btnspr + 3)
  end if
  if helpFlag then
    dontPassEvent()
    exit
  end if
  repeat with x = 0 to 20
    spr = x * 3 + 10
    pic = 0
    if sprite(spr).rollover or sprite(spr + 1).rollover then
      h = the locH of sprite spr + 1
      v = the locV of sprite spr + 1
      if x <> oldSelected then
        selectedCntr = 0
        oldSelected = x
      end if
      case x of
        0:
          if getAt(loadedList, 1) then
            pic = 0
            if the mouseDown then
              numPlayers = 0
              gamePlayMode = #front9
              hol = 1
              holeNumber = inithackv(hol)
              holeCompleted = 0
              goHole(hol)
              exit
            end if
          end if
        1:
          pic = 5
          if getAt(loadedList, 10) then
            pic = 1
            if the mouseDown then
              numPlayers = 0
              gamePlayMode = #back9
              hol = 10
              holeNumber = inithackv(hol)
              holeCompleted = 0
              goHole(hol)
              exit
            end if
          end if
        2:
          if getAt(loadedList, 1) then
            pic = 2
            if the mouseDown then
              numPlayers = 0
              gamePlayMode = #full18
              hol = 1
              holeNumber = inithackv(hol)
              holeCompleted = 0
              goHole(hol)
              exit
            end if
          end if
        3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20:
          hol = x - 2
          if getAt(loadedList, hol) then
            pic = 3
            if the mouseDown then
              numPlayers = 1
              gamePlayMode = #Practice
              holeNumber = inithackv(hol)
              holeCompleted = 0
              goHole(hol)
              exit
            end if
          else
            pic = 4
          end if

      end case
      mem = helpbubmem + pic
      wid = member(mem).width
      hgt = member(mem).height
      if selectedCntr > 20 then
        if not the puppet of sprite helpbubspr then
          set the puppet of sprite helpbubspr to 1
        end if
        set the locH of sprite helpbubspr to h - wid / 2
        set the locV of sprite helpbubspr to v - hgt / 2
        set the memberNum of sprite helpbubspr to mem
      else
        hide(helpbubspr)
      end if
      selectedCntr = selectedCntr + 1
    end if
  end repeat
  dontPassEvent()
end
on exitFrame
  if the frame = 1 then
    goFrame(2)
  end if
  go(the frame)
  dontPassEvent()
end
on goHole hol
  hide(helpbubspr)
  holeNumberDeb = -1
  str = "Hole" & string(hol)
  frm = label(str)
  frameTimer = 1
  if frm > 0 then
    goFrame(frm)
  else
    frm = label("end")
    goFrame(frm)
  end if
end
on showLoaded
  hole2spr = 24
  front9spr = 12
  back9spr = 15
  all18spr = 18
  repeat with x = 1 to count(loadedList)
    spr = hole2spr + (x - 2) * 3
    flg = getAt(loadedList, x)
    if flg then
      show(spr)
      next repeat
    end if
    hide(spr)
  end repeat
  if getAt(loadedList, 1) then
    show(front9spr)
  else
    hide(front9spr)
  end if
  if getAt(loadedList, 9) then
    show(back9spr)
  else
    hide(back9spr)
  end if
  if getAt(loadedList, 1) then
    show(all18spr)
  else
    hide(all18spr)
  end if
end