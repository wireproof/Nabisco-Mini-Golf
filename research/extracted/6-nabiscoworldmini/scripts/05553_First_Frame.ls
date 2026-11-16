-- Script
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
global g_playareaMaxH
global g_playareaMinH
global g_playareaMaxV
global g_playareaMinV
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
global outputTimer
global oldSelected
global selectedCntr
global g_multi
global castmems
global loadedList
global loadingNum
global myNetIDList
global castNameList

on enterFrame
  outputTimer = outputTimer + 1
  testLoaded()
  showLoaded()
  DoBrandingAnimation()
  if not (helpFlag or scoreCardFlag) then
    repeat with x = 0 to 20
      spr = x * 3 + g_menuBaseSpr
      pic = 0
      if sprite(spr).rollover or sprite(spr + 1).rollover then
        h = the locH of sprite spr
        v = the locV of sprite spr
        if x <> oldSelected then
          selectedCntr = 0
          oldSelected = x
        end if
        case x of
          0:
            pic = 0
            if the mouseDown then
              if not g_multi then
                numPlayers = 0
              end if
              gamePlayMode = #front9
              hol = 1
              holeNumber = inithackv(hol)
              goHole(hol)
              exit
            end if
          1:
            pic = 5
            if getAt(loadedList, 10) then
              pic = 1
              if the mouseDown then
                if not g_multi then
                  numPlayers = 0
                end if
                gamePlayMode = #back9
                hol = 10
                holeNumber = inithackv(hol)
                goHole(hol)
                exit
              end if
            end if
          2:
            pic = 2
            if holeImplemented.getPos(0) < 1 then
              if the mouseDown then
                if not g_multi then
                  numPlayers = 0
                end if
                gamePlayMode = #full18
                hol = 1
                holeNumber = inithackv(hol)
                goHole(hol)
                exit
              end if
            end if
          3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20:
            hol = x - 2
            if holeImplemented[hol] then
              if getAt(loadedList, hol) then
                pic = 3
                if the mouseDown then
                  if not g_multi then
                    numPlayers = 0
                  end if
                  gamePlayMode = #Practice
                  holeNumber = inithackv(hol)
                  goHole(hol)
                  exit
                end if
              else
                pic = 4
              end if
            else
              pic = 6
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
  end if
  pass()
end
on exitFrame
  if the frame = 1 then
    goFrame("Menu")
  else
    go(the frame)
  end if
  dontPassEvent()
end
on showLoaded
  front9spr = g_menuBaseSpr + 2
  back9spr = g_menuBaseSpr + 5
  all18spr = g_menuBaseSpr + 8
  hole2spr = g_menuBaseSpr + 14
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