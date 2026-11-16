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
global carbrakesnd
global carcrashsnd
global carpeeloutsnd
global carrevsnd
global bagsnd
global breadsnd
global cheesesnd
global crackersnd
global glasssnd
global grapesnd
global hydrantsnd
global legosnd
global metalcarsnd
global mousesnd
global mugsnd
global mushroomsnd
global paperclipsnd
global pensnd
global pencilsnd
global plasticspringsnd
global platesnd
global snorkelsnd
global silverwaresnd
global wallsnd
global woodenspoonsnd
global propellersnd
global rollupsnd
global rolluphitsnd
global worminsnd
global wormoutsnd
global cdspinsnd
global mouseslidesnd
global candysnd
global cupcakesnd
global candlesnd
global draweropensnd
global drawerclosesnd
global dumpsnd
global tractorarmsnd
global tractorbeepsnd
global truckforwardsnd
global truckreversesnd
global ballthruwiresnd
global tractorforwardsnd
global tractorreversesnd
global rolluplongsnd
global hingeopensnd
global hingeclosesnd
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
global g_multi
global g_myPlayerNumber
global g_mprcv
global g_mpxmit
global nextSndChan

on initLocalSounds
  cupsnd = the number of member "new cup"
  bricksnd = the number of member "hitBrick"
  woodsnd = the number of member "hitWood"
  metalsnd = the number of member "Metal Clank 1"
  pipe1snd = the number of member "new pipe1"
  pipe2snd = the number of member "new pipe2"
  puttsnd = the number of member "Putt"
  catchsnd = the number of member "Press"
  buzzsnd = the number of member "Buzz"
  clickinsnd = the number of member "Click In"
  carbrakesnd = the number of member "car brake"
  carcrashsnd = the number of member "car crash"
  carpeeloutsnd = the number of member "car peel out"
  carrevsnd = the number of member "car rev"
  bagsnd = the number of member "hit bag"
  breadsnd = the number of member "hit bread"
  cheesesnd = the number of member "hit cheese"
  crackersnd = the number of member "hit cracker"
  glasssnd = the number of member "hit glass"
  grapesnd = the number of member "hit grape"
  hydrantsnd = the number of member "hit hydrant"
  legosnd = the number of member "hit lego"
  metalcarsnd = the number of member "hit metal car"
  mousesnd = the number of member "hit mouse"
  mugsnd = the number of member "hit mug"
  mushroomsnd = the number of member "hit mushroom"
  paperclipsnd = the number of member "hit paperclip"
  pensnd = the number of member "hit pen"
  pencilsnd = the number of member "hit pencil"
  plasticspringsnd = the number of member "hit plastic spring"
  platesnd = the number of member "hit plate"
  snorkelsnd = the number of member "hit snorkel"
  silverwaresnd = the number of member "hit silverware"
  wallsnd = the number of member "hit wall"
  woodenspoonsnd = the number of member "hit wooden spoon"
  propellersnd = the number of member "propeller"
  rollupsnd = the number of member "rollup"
  rolluphitsnd = the number of member "hit rollup"
  worminsnd = the number of member "worm in"
  wormoutsnd = the number of member "worm out"
  cdspinsnd = the number of member "cd spin"
  mouseslidesnd = the number of member "mouse slide"
  candysnd = the number of member "hit candy"
  cdspinsnd = the number of member "cd spin"
  mouseslidesnd = the number of member "mouse slide"
  candysnd = the number of member "hit candy"
  cupcakesnd = the number of member "hit cupcake wrapper"
  candlesnd = the number of member "hit candlecrayon"
  draweropensnd = the number of member "drawer open"
  drawerclosesnd = the number of member "drawer close"
  dumpsnd = the number of member "dump"
  tractorarmsnd = the number of member "tractor arm"
  tractorbeepsnd = the number of member "tractor beep"
  truckforwardsnd = the number of member "truck forward"
  truckreversesnd = the number of member "truck reverse"
  ballthruwiresnd = the number of member "ball thru wire"
  tractorforwardsnd = the number of member "tractor forward"
  tractorreversesnd = the number of member "tractor reverse"
  rolluplongsnd = the number of member "rollup long"
  hingeopensnd = the number of member "hinge open"
  hingeclosesnd = the number of member "hinge close"
  effectsChannel = 2
  qualifyVol(effectsChannel, 255)
  prioritySound = 0
end
on playSound val, vol, pri, offs
  if voidp(vol) then
    vol = 255
  else
    if vol > 255 then
      vol = 255
    end if
  end if
  if voidp(offs) then
    offs = 0
  end if
  if offs < 0 then
    offs = 0
  else
    if offs > 9 then
      offs = 9
    end if
  end if
  if offs > 0 then
    vol = 255 - 25 * offs
  end if
  prioritySound = pri
  if voidp(nextSndChan) then
    nextSndChan = 0
  end if
  nextSndChan = nextSndChan + 1
  if nextSndChan > 8 then
    nextSndChan = 1
  end if
  testChan = nextSndChan
  repeat with chanCnt = 1 to 8
    if soundBusy(testChan) then
      testChan = testChan + 1
      if testChan > 8 then
        testChan = 1
      end if
    end if
  end repeat
  nextSndChan = testChan
  if vol >= 0 then
    qualifyVol(nextSndChan, vol)
  end if
  puppetSound(nextSndChan, val)
  currentSound = val
  if not playbackFlag then
    recordMovement(player, 1, currentSound)
  end if
end
on stopSound val, offs
  if playbackState <> #playback then
    if voidp(offs) then
      offs = 0
    end if
    offs = int(offs)
    if offs < 0 then
      offs = 0
    end if
    if offs > 9 then
      offs = 9
    end if
    offs = offs * 3
    val = val + offs + 1000
    currentSound = val
    if not playbackFlag then
      recordMovement(player, 1, currentSound)
    end if
  end if
end
on qualifyVol chan, vol
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