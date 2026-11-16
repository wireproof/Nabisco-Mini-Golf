-- Behavior
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
global holeCompleted
global nextHole
global bestScore
global holeImplemented
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
global g_menuBaseSpr
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
global obstaclespr
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
global scoreBtnflash
global helpBtnflash
global quitBtnflash
global menuBtnflash
global sendBtnflash
global againBtnflash
global backBtnflash
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
global numbase
global playerNamesmem
global putNamemem
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
global g_showGameOver
global g_cardCloseBtnSpr
global g_helpCloseBtnSpr
global g_selectPlayersSpr
global g_selectPlayersMem
global g_selectPlayersCloseButtonTimer
global g_MouseDownOnMe
global g_playAgainBtnMem
global g_BackToMenuBtnMem
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
global obstacleTimer
global g_numPlayers
global g_playerstatus
global playerGender
global putterBaseBoy
global putterBaseGirl
global g_multi
global g_myPlayerNumber
global castmems
global loadedList
global loadingNum
global myNetIDList
global castNameList
global g_holesCast
global g_brandingBaseMem
global g_brandingSpr
global g_currentBrand
global g_brandingCount
global g_hioMem
global g_hioSpr
global g_hioCount
global g_hioShowing
global g_gameKey
global g_gameCode
global g_clientCode

on goMenu
  sound(#stop, effectsChannel)
  scoreCardFlag = 0
  displayHelp(0)
  ballState = [#initHole, #initHole, #initHole, #initHole]
  scoreCard = duplicate(emptyList(g_numberOfHoles * 4))
  ResetScores()
  codeInit()
  frameTimer = 1
  g_brandingCount = 59
  SetGUIButtons(#menu)
  CorrectBrandingFade()
  goFrame("menu")
end
on showcard
  if the frame < 5 then
    exit
  end if
  scoreCardFlag = 1
  repeat with x = 0 to 56
    show(cardspr + x)
  end repeat
  repeat with x = 1 to g_maxPlayers
    if x > numPlayers then
      hide(cardspr + x + 3)
    end if
  end repeat
  repeat with x = 0 to 11
    show(g_cardHoleNumSpr + x)
  end repeat
  repeat with x = 0 to 11
    show(g_cardParNumSpr + x)
  end repeat
  if not (gamePlayMode = #Practice) then
    hide(cardspr + 2)
    hide(cardspr + 3)
  end if
end
on hidecard
  scoreCardFlag = 0
  repeat with x = 0 to 56
    hide(cardspr + x)
  end repeat
  repeat with x = 0 to 23
    hide(g_cardParNumSpr + x)
  end repeat
end
on buildCard
  currentHole = readhackv(holeNumber)
  if currentHole > g_numberOfHoles then
    currentHole = g_numberOfHoles
  end if
  if currentHole > 9 then
    backadd = 9
  else
    backadd = 0
  end if
  repeat with x = 0 to 47
    member(textScoremem + x).text = EMPTY
  end repeat
  tmpmode = gamePlayMode
  if tmpmode = #full18 or tmpmode = #Practice then
    if currentHole < 10 then
      tmpmode = #front9
    else
      tmpmode = #back9
    end if
  end if
  parFront = 0
  repeat with i = 1 to 9
    parFront = parFront + parList[i]
    if tmpmode = #front9 then
      member(g_cardHoleNumMem + i - 1).text = string(i + backadd)
      member(g_cardParNumMem + i - 1).text = string(parList[i + backadd])
    end if
  end repeat
  member(g_cardParNumMem + 9).text = string(parFront)
  parBack = 0
  repeat with i = 1 to 9
    parBack = parBack + parList[i + backadd]
    if tmpmode = #back9 then
      member(g_cardHoleNumMem + i - 1).text = string(i + backadd)
      member(g_cardParNumMem + i - 1).text = string(parList[i + backadd])
    end if
  end repeat
  member(g_cardParNumMem + 10).text = string(parBack)
  member(g_cardParNumMem + 11).text = string(parFront + parBack)
  repeat with col = 0 to 3
    if col >= numPlayers then
      exit repeat
    end if
    member(scorecardname + col).text = member(playerNamesmem + col).text
    repeat with row = 0 to 11
      if row + backadd = currentHole then
        row = 9
      end if
      plyr = col + 1
      cardind = plyr + (row + backadd) * 4
      typ = playerType[plyr]
      case row of
        0, 1, 2, 3, 4, 5, 6, 7, 8:
          num = readhackv(scoreCard[cardind])
          if num > 99 then
            num = 0
          end if
          par = parList[row + 1 + backadd]
        9:
          if not (typ = #local or typ = #remote) or gamePlayMode = #Practice then
            next repeat
          end if
          if tmpmode = #front9 then
            num = compFront(plyr)
            if currentHole >= 9 then
              par = parFront
            else
              par = 0
            end if
          else
            if tmpmode = #back9 then
              num = compFront(plyr)
              if currentHole >= 9 then
                par = parFront
              else
                par = 0
              end if
            else
              num = 0
              par = 0
            end if
          end if
        10:
          if not (typ = #local or typ = #remote) or gamePlayMode = #Practice then
            next repeat
          end if
          if tmpmode = #back9 then
            num = compBack(plyr)
            if currentHole = 18 then
              par = parBack
            else
              par = 0
            end if
          else
            num = 0
            par = 0
          end if
        11:
          if not (typ = #local or typ = #remote) or gamePlayMode = #Practice then
            next repeat
          end if
          if tmpmode = #back9 then
            num = compFront(plyr) + compBack(plyr)
            if currentHole = 18 then
              par = parFront + parBack
            else
              par = 0
            end if
          else
            num = 0
            par = 0
          end if

      end case
      if num = 0 then
        fc = 255
        str = EMPTY
      else
        str = string(num)
        if num < par then
          fc = 6
        else
          if num = par then
            fc = 170
          else
            fc = 255
          end if
        end if
      end if
      if not (typ = #local or typ = #remote) then
        fc = 8
      end if
      mem = row + col * 12
      member(textScoremem + mem).foreColor = fc
      member(textScoremem + mem).text = str
    end repeat
  end repeat
end
on DoButtonFlashes
  if g_selectPlayersCloseButtonTimer > 0 then
    g_selectPlayersCloseButtonTimer = g_selectPlayersCloseButtonTimer - 1
    if g_selectPlayersCloseButtonTimer mod 6 = 1 then
      num = g_MouseDownOnMe - (g_selectPlayersSpr + 2)
      normState = g_selectPlayersMem + 2 * (num - 1)
      if sprite(g_MouseDownOnMe).memberNum = normState then
        sprite(g_MouseDownOnMe).memberNum = normState + 1
      else
        sprite(g_MouseDownOnMe).memberNum = normState
      end if
    end if
    if g_selectPlayersCloseButtonTimer <= 0 then
      num = g_MouseDownOnMe - (g_selectPlayersSpr + 2)
      normState = g_selectPlayersMem + 2 * (num - 1)
      sprite(g_MouseDownOnMe).memberNum = normState
      g_MouseDownOnMe = 0
      g_selectPlayersCloseButtonTimer = 0
      PromptForPlayers(0)
    end if
  end if
  if closeButtonTimer > 0 then
    hi = 100 * int(closeButtonTimer / 100.0)
    if closeButtonTimer mod 100 > 0 then
      closeButtonTimer = closeButtonTimer - 1
      if closeButtonTimer mod 100 = 0 then
        closeButtonTimer = 0
        if hi then
          displayScore(0)
          sprite(g_cardCloseBtnSpr).memberNum = closeButton
        else
          displayHelp(0)
          sprite(g_helpCloseBtnSpr).memberNum = closeButton
        end if
      else
        if closeButtonTimer mod 4 < 2 then
          if hi then
            sprite(g_cardCloseBtnSpr).memberNum = closeButton + 1
          else
            sprite(g_helpCloseBtnSpr).memberNum = closeButton + 1
          end if
        else
          if hi then
            sprite(g_cardCloseBtnSpr).memberNum = closeButton
          else
            sprite(g_helpCloseBtnSpr).memberNum = closeButton
          end if
        end if
      end if
    end if
  end if
  if scoreBtnflash > 0 then
    scoreBtnflash = scoreBtnflash - 1
    if scoreBtnflash mod 4 < 2 then
      hide(guiBtnBaseSpr)
    else
      show(guiBtnBaseSpr)
    end if
    if scoreBtnflash <= 0 then
      if not scoreCardFlag then
        unflashPlayer()
        show(guiBtnBaseSpr)
        displayHelp(0)
        displayScore(1)
      else
        displayScore(0)
      end if
    end if
  else
    show(guiBtnBaseSpr)
  end if
  if helpBtnflash > 0 then
    helpBtnflash = helpBtnflash - 1
    if helpBtnflash mod 4 < 2 then
      hide(guiBtnBaseSpr + 1)
    else
      show(guiBtnBaseSpr + 1)
    end if
    if helpBtnflash <= 0 then
      if not helpFlag then
        unflashPlayer()
        show(guiBtnBaseSpr + 1)
        displayScore(0)
        displayHelp(1)
      else
        displayHelp(0)
      end if
    end if
  else
    show(guiBtnBaseSpr + 1)
  end if
  if quitBtnflash > 0 then
    quitBtnflash = quitBtnflash - 1
    if quitBtnflash mod 4 < 2 then
      hide(guiBtnBaseSpr + 2)
    else
      show(guiBtnBaseSpr + 2)
    end if
    if quitBtnflash <= 0 then
      unflashPlayer()
      show(guiBtnBaseSpr + 2)
      updateStage()
      myExit()
    end if
  else
    show(guiBtnBaseSpr + 2)
  end if
  if menuBtnflash > 0 then
    menuBtnflash = menuBtnflash - 1
    if menuBtnflash mod 4 < 2 then
      hide(guiBtnBaseSpr + 3)
    else
      show(guiBtnBaseSpr + 3)
    end if
    if menuBtnflash <= 0 then
      unflashPlayer()
      show(guiBtnBaseSpr + 3)
      countGames()
      goMenu()
      updateStage()
      exit
    end if
  else
    show(guiBtnBaseSpr + 3)
  end if
  if againBtnflash > 0 then
    againBtnflash = againBtnflash - 1
    btnspr = cardspr + 2
    if againBtnflash = 0 then
      sprite(btnspr).memberNum = g_playAgainBtnMem
      displayScore(0)
      ballState = [#initHole, #initHole, #initHole, #initHole]
      scoreCard = duplicate(emptyList(g_numberOfHoles * 4))
      frameTimer = 1
      hol = readhackv(holeNumber)
      goHole(hol)
    else
      if againBtnflash mod 4 < 2 then
        sprite(btnspr).memberNum = g_playAgainBtnMem + 1
      else
        sprite(btnspr).memberNum = g_playAgainBtnMem
      end if
    end if
  end if
  if backBtnflash > 0 then
    backBtnflash = backBtnflash - 1
    btnspr = cardspr + 3
    if backBtnflash = 0 then
      sprite(btnspr).memberNum = g_BackToMenuBtnMem
      countGames()
      goMenu()
      updateStage()
      exit
    else
      if backBtnflash mod 4 < 2 then
        sprite(btnspr).memberNum = g_BackToMenuBtnMem + 1
      else
        sprite(btnspr).memberNum = g_BackToMenuBtnMem
      end if
    end if
  end if
  if g_multi then
    set the memberNum of sprite sendbtnspr to btnmem + 12
    if the locH of sprite historyspr + 1 < 2000 then
      if lineText <> EMPTY then
        if sprite(sendbtnspr).rollover then
          set the memberNum of sprite sendbtnspr to btnmem + 13
        end if
      end if
    end if
    if sendBtnflash > 0 then
      sendBtnflash = sendBtnflash - 1
      if sendBtnflash mod 4 < 2 then
        hide(sendbtnspr)
      else
        show(sendbtnspr)
      end if
      if sendBtnflash <= 0 then
        unflashPlayer()
        show(sendbtnspr)
        hide(historyspr + 1)
        hide(historyspr + 2)
        send_MP_message()
        lineText = EMPTY
        hilite line 999 of field 24
        updateStage()
        exit
      end if
    else
    end if
    hide(historyspr + 3)
    txtV = the locV of sprite historyspr + 2
    if sprite(historyspr + 2).rollover then
      rgt = the right of sprite historyspr + 2
      if the mouseH < rgt - 50 then
        v = the mouseV - txtV
        lin = locVToLinePos(member(historymem + 1).memberNum, v)
        txt = member(historymem + 1).text
        offs = member(historymem + 1).scrollTop
        lineV = linePosToLocV(member(historymem + 1), lin) - offs
        show(historyspr + 3)
        set the locV of sprite historyspr + 3 to txtV + lineV
      end if
    end if
  end if
end
on SetGUIButtons stateFlag
  menuBtn = 0
  helpBtn = 0
  quitBtn = 0
  scoreBtn = 0
  case stateFlag of
    #menu:
      menuBtn = 0
      helpBtn = 1
      quitBtn = 1
      scoreBtn = 0
    #off:
      menuBtn = 0
      helpBtn = 0
      quitBtn = 0
      scoreBtn = 0
    #on:
      menuBtn = 1
      helpBtn = 1
      quitBtn = 1
      scoreBtn = 1

  end case
  if menuBtn then
    sprite(guiBtnBaseSpr + 3).memberNum = btnmem + 9
  else
    sprite(guiBtnBaseSpr + 3).memberNum = btnmem + 9 + 2
  end if
  if helpBtn then
    sprite(guiBtnBaseSpr + 1).memberNum = btnmem + 3
  else
    sprite(guiBtnBaseSpr + 1).memberNum = btnmem + 3 + 2
  end if
  if quitBtn then
    sprite(guiBtnBaseSpr + 2).memberNum = btnmem + 6
  else
    sprite(guiBtnBaseSpr + 2).memberNum = btnmem + 6 + 2
  end if
  if scoreBtn then
    sprite(guiBtnBaseSpr).memberNum = btnmem
  else
    sprite(guiBtnBaseSpr).memberNum = btnmem + 2
  end if
end
on PromptForPlayers showFlag
  if voidp(showFlag) then
    showFlag = 1
  end if
  if showFlag then
    show(g_selectPlayersSpr)
    show(g_selectPlayersSpr + 1)
    show(g_selectPlayersSpr + 2)
    show(g_selectPlayersSpr + 3)
    show(g_selectPlayersSpr + 4)
  else
    hide(g_selectPlayersSpr)
    hide(g_selectPlayersSpr + 1)
    hide(g_selectPlayersSpr + 2)
    hide(g_selectPlayersSpr + 3)
    hide(g_selectPlayersSpr + 4)
  end if
end
on DoBrandingAnimation
  g_brandingCount = g_brandingCount + 1
  nxtFrame = g_brandingCount / 2
  if nxtFrame > 30 then
    nxtBrand = g_currentBrand + 1
    if nxtBrand > 5 then
      nxtBrand = 0
    end if
    blendAmt = (nxtFrame - 30) * 10
    if blendAmt < 100 then
      sprite(g_brandingSpr).memberNum = g_brandingBaseMem + g_currentBrand
      sprite(g_brandingSpr).height = member(g_brandingBaseMem + g_currentBrand).height
      sprite(g_brandingSpr).width = member(g_brandingBaseMem + g_currentBrand).width
      sprite(g_brandingSpr).loc = point(312, 175)
      sprite(g_brandingSpr).blend = 100 - blendAmt
      sprite(g_brandingSpr + 1).memberNum = g_brandingBaseMem + nxtBrand
      sprite(g_brandingSpr + 1).height = member(g_brandingBaseMem + nxtBrand).height
      sprite(g_brandingSpr + 1).width = member(g_brandingBaseMem + nxtBrand).width
      sprite(g_brandingSpr + 1).loc = point(312, 175)
      sprite(g_brandingSpr + 1).blend = blendAmt
    else
      g_brandingCount = 0
      g_currentBrand = nxtBrand
      sprite(g_brandingSpr + 1).memberNum = 0
      sprite(g_brandingSpr + 1).blend = 0
      sprite(g_brandingSpr).blend = 100
      sprite(g_brandingSpr).memberNum = g_brandingBaseMem + g_currentBrand
      sprite(g_brandingSpr).height = member(g_brandingBaseMem + g_currentBrand).height
      sprite(g_brandingSpr).width = member(g_brandingBaseMem + g_currentBrand).width
      sprite(g_brandingSpr).loc = point(312, 175)
    end if
  else
    sprite(g_brandingSpr).memberNum = g_brandingBaseMem + g_currentBrand
    sprite(g_brandingSpr).height = member(g_brandingBaseMem + g_currentBrand).height
    sprite(g_brandingSpr).width = member(g_brandingBaseMem + g_currentBrand).width
    sprite(g_brandingSpr).loc = point(312, 175)
  end if
end
on CorrectBrandingFade
  sprite(g_brandingSpr + 1).memberNum = 0
  sprite(g_brandingSpr + 1).blend = 0
end
on AnimateHoleInOne
end
on StartHoleInOne plyr
end
on initHoleInOne
end