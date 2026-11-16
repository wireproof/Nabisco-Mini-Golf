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
global g_parMarkerMem
global g_parMarkerSpr
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
global g_debug
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
global g_multi
global g_myPlayerNumber
global g_mprcv
global g_mpxmit
global g_numPlayers
global g_playerstatus
global playerGender
global putterBaseBoy
global putterBaseGirl
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
global g_gamename
global g_gameCode
global g_gameSecurityCode
global g_clientCode
global g_showHelp

on prepareMovie
  DebugLog(EMPTY)
  if voidp(g_multi) then
    g_multi = 0
  end if
  if not g_multi and voidp(g_playerstatus) then
    standAlone = 1
  else
    standAlone = 0
  end if
  savemulti = g_multi
  entryPoint(standAlone, "Copyright2002SkyworksTechnologiesInc", member("vercast").memberNum, 220, 0)
  g_multi = savemulti
  g_maxStrokes = 14
  if g_multi then
    mpStart(g_numPlayers, 1)
    g_myPlayerNumber = mpGetPlayerNumber()
    if g_myPlayerNumber = 0 then
      g_myPlayerNumber = 1
    end if
  end if
  if voidp(g_debug) then
    g_debug = 0
  end if
  if voidp(g_maxPlayers) then
    g_maxPlayers = 2
  end if
  if voidp(g_numPlayers) then
    g_numPlayers = g_maxPlayers
  end if
  if voidp(g_playerstatus) then
    g_playerstatus = [[EMPTY, 1], [EMPTY, 2], [EMPTY, 1], [EMPTY, 2]]
    playerType = [#local, #local, #local, #local]
  end if
  if voidp(gamePlayMode) then
    gamePlayMode = #Practice
  end if
  if voidp(g_hioShowing) then
    g_hioShowing = 1
  end if
  if voidp(g_numberOfHoles) then
    g_numberOfHoles = 18
  end if
  if voidp(g_maxStrokes) then
    g_maxStrokes = 14
  end if
  if voidp(g_gameCode) then
    g_gameKey = "nwmm18"
  end if
  if voidp(g_gameSecurityCode) then
    g_gameCode = "windmill"
  end if
  if voidp(g_clientCode) then
    g_clientCode = #nabisco
  end if
  if voidp(g_showHelp) then
    g_showHelp = 0
  end if
  if g_maxStrokes = 0 then
    g_maxStrokes = 9999
  end if
  set the floatPrecision to 4
  g_holesCast = castLib("holes").number
  InitializeHoles()
  bestScore = inithackv(9999)
  playbackFlag = 0
  playbackState = #playbackDone
  remoteControl = 0
  holeNumber = inithackv(1)
  loading = 0
  scoreCard = duplicate(emptyList(g_numberOfHoles * 4))
  front9Score = duplicate(emptyList(4))
  numPlayers = 0
  playerGender = [1, 1, 1, 1]
  m = member("Player Names").memberNum
  repeat with i = 1 to g_numPlayers
    name = g_playerstatus[i][1]
    if name <> EMPTY then
      member(m + i - 1).text = name
    end if
    playerGender[i] = g_playerstatus[i][2]
  end repeat
  player = 1
  currentScreen = 0
  regionMap = []
  if voidp(codeVersion) then
    codeVersion = "C1.1"
  end if
  if voidp(musicChannel) then
    musicChannel = 1
  end if
  if voidp(effectsChannel) then
    effectsChannel = 2
  end if
  obstacleshad = 10
  cupShadspr = 19
  ballshad = 21
  balllow = 25
  obstaclespr = 29
  ballhigh = 36
  putterspr = 42
  rubberbandspr = 44
  guiBtnBaseSpr = 49
  score1spr = 53
  playerNamespr = 78
  sendbtnspr = 83
  chatselspr = 84
  historyspr = 86
  g_menuBaseSpr = 86
  cardspr = 92
  g_cardCloseBtnSpr = 148
  helpspr = 150
  g_helpCloseBtnSpr = 153
  loadingspr = 157
  g_parMarkerSpr = 161
  g_brandingSpr = 163
  g_cardParNumSpr = 165
  g_cardHoleNumSpr = 177
  g_selectPlayersSpr = 193
  helpbubspr = 200
  numbase = the number of member "Interface Digits"
  ballBase = the number of member "ball1"
  shadmem = the number of member "shad"
  putterBase = the number of member "Putter0001"
  obstaclemem = the number of member "CRACK N ROLL1"
  textScoremem = the number of member "Text Scores"
  scorecardmem = the number of member "Scorecard (front)"
  scorecardname = the number of member "Card Name Entry"
  helpbubmem = the number of member "Help Bubbles"
  loadtextmem = the number of member "Loading Text"
  putNamemem = the number of member "putting player name"
  playerNamesmem = the number of member "Player Names"
  btnmem = the number of member "score btn"
  closeButton = the number of member "scorecard and help close 1"
  historymem = the number of member "history text"
  g_brandingBaseMem = the number of member "Branding"
  g_selectPlayersMem = the number of member "Select Number Of Players 1"
  g_cardParNumMem = the number of member "Par1"
  g_cardHoleNumMem = the number of member "Hole Num 1"
  g_playAgainBtnMem = the number of member "Play Again Button"
  g_BackToMenuBtnMem = the number of member "Back To Menu Button"
  g_parMarkerMem = the number of member "PAR2 Marker"
  initLocalSounds()
  initHoleInOne()
  g_currentBrand = 0
  g_brandingCount = 0
  puppetAll()
  initLists()
  initcastmems()
  loadedList = []
  myNetIDList = []
  castNameList = []
  loadingNum = 0
  repeat with x = 1 to g_numberOfHoles
    add(loadedList, 0)
    add(myNetIDList, 0)
    add(castNameList, EMPTY)
  end repeat
  setAt(loadedList, 1, 1)
  testLoaded()
  theStageWidth = the stageRight - the stageLeft
  theStageHeight = the stageBottom - the stageTop
  g_playareaMaxH = 624
  g_playareaMinH = 106
  g_playareaMaxV = 350
  g_playareaMinV = 0
  twopi = 2 * PI
  frameInit = 0
  frameTimer = 0
  timeoutCount = 0
  scoreBtnflash = 0
  helpBtnflash = 0
  quitBtnflash = 0
  menuBtnflash = 0
  sendBtnflash = 0
  againBtnflash = 0
  backBtnflash = 0
  closeButtonTimer = 0
  btncnt = 12
  lineCursorV = 4000
  historyText = EMPTY
  member(historymem).text = historyText
  textflg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  textpos = [16, 24, 28, 36, 44, 52, 56, 64, 72, 80, 211, 219, 223, 231, 239, 247, 251, 259, 267, 275]
  textchar = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
  textkern = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4]
  numdigits = 20
  setPlayer(1)
  oldMouseH = the mouseH
  oldmouseV = the mouseV
  gamePlayMode = #full18
  hol = 1
  holeNumber = inithackv(hol)
  holeCompleted = 0
  updateStage()
end
on stopMovie
  if g_multi then
    mpQuitGameGroup()
  end if
end
on codeInit
  ballMagnitude = [0, 0, 0, 0]
  ballAngle = [0, 0, 0, 0]
  oldballH = [0, 0, 0, 0]
  ballBounce = [0, 0, 0, 0]
  ballGravity = [0, 0, 0, 0]
  ballPriority = [balllow, balllow + 1, balllow + 2, balllow + 3]
  exitVecVal = [0, 0, 0, 0]
  exitPointVal = [point(0, 0), point(0, 0), point(0, 0), point(0, 0)]
  exitMagVal = [0, 0, 0, 0]
  pipeTicks = [0, 0, 0, 0]
  wallAngle = 0
  ballRegion = [0, 0, 0, 0]
  ballForce = [0, 0, 0, 0]
  ballStateTimer = [0, 0, 0, 0]
  movingflag = 0
  scoreCardFlag = 0
  helpFlag = 0
  ballh = [0, 0, 0, 0]
  ballv = [0, 0, 0, 0]
  ballY = [0, 0, 0, 0]
  ballScreen = [0, 0, 0, 0]
  repeat with x = 1 to 4
    putOnShelf(x)
  end repeat
  turnMemory1 = []
  turnMemory2 = []
  turnMemory3 = []
  turnMemory4 = []
  turnControlMemory = []
  turnTimer = 0
  lastTurnTimer = 0
  loading = 0
  obstacleTimer = 0
  ballwidth = 11
  putterAngle = 0
  putterForce = 0
  gravamt = 0.4
  groundLevel = [0, 0, 0, 0]
  mat_wood = 0.6001
  mat_rock = 0.9021
  mat_dish = 0.7851
  mat_cracker = 0.5851
  mat_cookie = 0.5851
  mat_bag = 0.3985
  mat_glass = 0.9059
  mat_metal = 0.7619
  mat_book = 0.4685
  mat_plastic = 0.6669
  SetInitialBallState()
  repeat with plyr = 1 to g_maxPlayers
    showScore(plyr)
  end repeat
  g_showGameOver = 1
  if g_showHelp then
    displayHelp(1)
    g_showHelp = 0
  end if
end
on SetInitialBallState
  ballState = [#shelf, #shelf, #shelf, #shelf]
  ballMagnitude = [0, 0, 0, 0]
  ballAngle = [0, 0, 0, 0]
  ballRegion = [0, 0, 0, 0]
  ballForce = [0, 0, 0, 0]
  ballStateTimer = [0, 0, 0, 0]
  oldballH = [0, 0, 0, 0]
  ballBounce = [0, 0, 0, 0]
  ballGravity = [0, 0, 0, 0]
  ballPriority = [balllow, balllow + 1, balllow + 2, balllow + 3]
  ballh = [0, 0, 0, 0]
  ballv = [0, 0, 0, 0]
  ballY = [0, 0, 0, 0]
  ballScreen = [0, 0, 0, 0]
  movingflag = 0
  holeStrokes = emptyList(4).duplicate()
  repeat with i = 1 to 4
    if playerType[i] = #local or playerType[i] = #remote then
      ballState[i] = #placeball
      exit repeat
    end if
  end repeat
end
on initHole
  holeNum = readhackv(holeNumber)
  repeat with x = 1 to 4
    putOnShelf(x)
  end repeat
  SetInitialBallState()
  sprite(g_parMarkerSpr).memberNum = g_parMarkerMem + parList[holeNum] - 2
  sprite(g_parMarkerSpr + 1).memberNum = member("Hole Markers").memberNum + holeNum - 1
  ballPriority = [balllow, balllow + 1, balllow + 2, balllow + 3]
  ballMagnitude = [0, 0, 0, 0]
  if voidp(scoreCard) or gamePlayMode = #Practice then
    scoreCard = duplicate(emptyList(g_numberOfHoles * 4))
    front9Score = duplicate(emptyList(4))
    back9Score = duplicate(emptyList(4))
  else
    if holeNum = 1 and gamePlayMode = #front9 then
      front9Score = duplicate(emptyList(4))
    else
      if holeNum = 10 and gamePlayMode = #back9 then
        back9Score = duplicate(emptyList(4))
      end if
    end if
  end if
  cupZ = 0
  groundLevel = [0, 0, 0, 0]
  obstacleTimer = 0
  hide(loadingspr)
  hide(loadingspr + 1)
  hide(loadingspr + 2)
  enableChat()
  setPlayer(1)
  repeat with plyr = 1 to g_maxPlayers
    showScore(plyr)
  end repeat
end
on clearScores
  score1Val = 0
  score2Val = 0
  textflg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
  textchar = [10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12]
  updateStage()
end
on emptyList cnt
  tmplst = []
  zro = inithackv(0)
  repeat with x = 1 to cnt
    add(tmplst, zro)
  end repeat
  return tmplst
end
on testLoaded
  val = frameTimer mod 10
  if val > 0 then
    exit
  end if
  repeat while count(loadedList) < g_numberOfHoles
    add(loadedList, 0)
  end repeat
  mem = 1
  hol = 1
  cst = 1
  ind = 1
  lod = 1
  repeat while ind < count(castmems)
    typ = getAt(castmems, ind)
    if typ = #next then
      if cst = 1 then
        cst = g_holesCast
        mem = 0
      end if
      hol = hol + 1
      ind = ind + 1
      mem = mem + 1
      lod = 1
      next repeat
    end if
    memtyp = member(mem, cst).type
    rdy = member(mem, cst).mediaReady
    if typ = #empty then
      rdy = 1
    end if
    if typ <> memtyp or not rdy then
      lod = 0
    end if
    setAt(loadedList, hol, lod)
    mem = mem + 1
    ind = ind + 1
  end repeat
end
on InitializeHoles
  holeImplemented = []
  parList = []
  g_brandingSponsors = []
  h = 1
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 1
  h = 2
  holeImplemented[h] = 1
  parList[h] = 3
  g_brandingSponsors[h] = 2
  h = 3
  holeImplemented[h] = 1
  parList[h] = 3
  g_brandingSponsors[h] = 3
  h = 4
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 4
  h = 5
  holeImplemented[h] = 1
  parList[h] = 4
  g_brandingSponsors[h] = 5
  h = 6
  holeImplemented[h] = 1
  parList[h] = 3
  g_brandingSponsors[h] = 6
  h = 7
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 1
  h = 8
  holeImplemented[h] = 1
  parList[h] = 3
  g_brandingSponsors[h] = 2
  h = 9
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 3
  h = 10
  holeImplemented[h] = 1
  parList[h] = 3
  g_brandingSponsors[h] = 4
  h = 11
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 5
  h = 12
  holeImplemented[h] = 1
  parList[h] = 3
  g_brandingSponsors[h] = 6
  h = 13
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 1
  h = 14
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 2
  h = 15
  holeImplemented[h] = 1
  parList[h] = 4
  g_brandingSponsors[h] = 3
  h = 16
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 4
  h = 17
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 5
  h = 18
  holeImplemented[h] = 1
  parList[h] = 2
  g_brandingSponsors[h] = 6
end
on DebugLog msg
  if g_debug then
    sprite(219).visible = 1
    member("debug").text = msg
  else
    sprite(219).visible = 0
  end if
end