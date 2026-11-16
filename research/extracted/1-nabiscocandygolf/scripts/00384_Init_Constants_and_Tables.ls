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
global g_castLoadingStatus
global tmpList

on prepareMovie
  standAlone = 1
  entryPoint(standAlone, "Copyright2000NabiscoInc", the number of member "Version", 110)
  debug = 0
  bestScore = inithackv(9999)
  dest = ".\"
  if the runMode contains "Plugin" then
    dest = externalParamValue("sw1")
  end if
  holeNumber = inithackv(1)
  loading = 0
  preloaded = 0
  if voidp(scoreCard) then
    scoreCard = duplicate(emptyList(18 * 4))
    front9Score = duplicate(emptyList(4))
  end if
  holeStrokes = duplicate(emptyList(4))
  parList = [3, 4, 3, 3, 3, 3, 4, 3, 3, 4, 3, 3, 3, 3, 4, 4, 3, 4]
  player = 1
  if voidp(codeVersion) then
    codeVersion = "C1.1"
  end if
  if voidp(musicChannel) then
    musicChannel = 1
  end if
  if voidp(effectsChannel) then
    effectsChannel = 2
  end if
  ballshad = 17
  balllow = 21
  ballhigh = 32
  obstacleshad = 12
  obstaclespr = 25
  putterspr = 42
  select4 = 106
  playerNamespr = 45
  score1spr = 49
  btnspr = 112
  cardspr = 56
  helpbubspr = 74
  helpspr = 108
  loadingspr = 116
  ballBase = the number of member "Ball1"
  shadmem = the number of member "shad"
  putterBase = the number of member "Putter"
  score1mem = the number of member "Score 1"
  textScoremem = the number of member "Text Scores"
  scorecardmem = the number of member "Scorecard (front)"
  helpbubmem = the number of member "Help Bubbles"
  loadtextmem = the number of member "Loading Text"
  cupsnd = the number of member "Cup.AIFF"
  bumpersnd = the number of member "Bumper1.AIFF"
  bricksnd = the number of member "hitBrick.AIFF"
  woodsnd = the number of member "hitWood.AIFF"
  pipe1snd = the number of member "pipe1.AIFF"
  pipe2snd = the number of member "pipe2.AIFF"
  puttsnd = the number of member "Putt.AIFF"
  swooshsnd = the number of member "Swoosh.AIFF"
  blackNums = the number of member "Black Numerals"
  redNums = the number of member "Red Numerals"
  bubsnd = the number of member "bub1.AIFF"
  buzzsnd = the number of member "Buzz.AIFF"
  catchsnd = the number of member "Click In.aif"
  clanksnd = the number of member "Metal Clank 1.AIFF"
  firesnd = the number of member "Fire Sound"
  treesnd = the number of member "Tree Hit"
  puppetAll()
  initcastmems()
  loadedList = []
  myNetIDList = []
  castNameList = []
  loadingNum = 0
  g_castLoadingStatus = [0, 0]
  repeat with x = 1 to 18
    add(loadedList, 0)
    add(myNetIDList, 0)
    add(castNameList, EMPTY)
  end repeat
  sinTable = []
  cosTable = []
  atanTable = []
  twopi = 2 * PI
  repeat with x = 0 to 255
    theta = x * twopi / 256
    append(sinTable, sin(theta))
    append(cosTable, cos(theta))
  end repeat
  repeat with x = 0 to 1200
    val = float(float(x) / float(30))
    theta = atan(val)
    ang = integer(theta * 256 / twopi)
  end repeat
  frameInit = 0
  frameTimer = 0
  timeoutCount = 0
  btn1flash = 0
  btn2flash = 0
  btn3flash = 0
  btn4flash = 0
  btncnt = 12
  textflg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  textpos = [16, 24, 28, 36, 44, 52, 56, 64, 72, 80, 211, 219, 223, 231, 239, 247, 251, 259, 267, 275]
  textchar = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
  textkern = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4]
  numdigits = 20
  qualifyVol(effectsChannel, 255)
  prioritySound = 0
  oldMouseH = the mouseH
  oldmouseV = the mouseV
  updateStage()
end
on codeInit
  ballMagnitude = [0, 0, 0, 0]
  ballAngle = [0, 0, 0, 0]
  ballY = [0, 0, 0, 0]
  oldballH = [0, 0, 0, 0]
  ballBounce = [0, 0, 0, 0]
  ballGravity = [0, 0, 0, 0]
  ballPriority = [0, 0, 0, 0]
  exitVecVal = [0, 0, 0, 0]
  exitPointVal = [point(0, 0), point(0, 0), point(0, 0), point(0, 0)]
  exitMagVal = [0, 0, 0, 0]
  pipeTicks = [0, 0, 0, 0]
  wallAngle = 0
  movingflag = 0
  scoreCardFlag = 0
  helpFlag = 0
  ballh = [0, 0, 0, 0]
  ballv = [0, 0, 0, 0]
  repeat with x = 1 to 4
    putOnShelf(x)
  end repeat
  loading = 0
  ballwidth = 11
  putterAngle = 0
  putterForce = 0
  pi = PI
  gravamt = 0.4
  ballState = [#placeball, #shelf, #shelf, #shelf]
  showScore(1)
  showScore(2)
  showScore(3)
  showScore(4)
end
on gameStart
end
on initHole
  repeat with x = 1 to 4
    putOnShelf(x)
  end repeat
  ballState = [#placeball, #shelf, #shelf, #shelf]
  holeStrokes = duplicate(emptyList(4))
  ballPriority = [0, 0, 0, 0]
  ballMagnitude = [0, 0, 0, 0]
  if voidp(scoreCard) or gamePlayMode = #Practice then
    scoreCard = duplicate(emptyList(18 * 4))
    front9Score = duplicate(emptyList(4))
  end if
  hide(loadingspr)
  hide(loadingspr + 1)
  player = 1
  showScore(1)
  showScore(2)
  showScore(3)
  showScore(4)
end
on clearScores
  score1Val = 0
  score2Val = 0
  textflg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
  textchar = [10, 10, 10, 10, 10, 10, 10, 10, 10, 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 12]
  updateScore()
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
  if g_castLoadingStatus[1] <> 0 then
    errorCode = netError(g_castLoadingStatus[1])
    if errorCode <> "OK" and errorCode <> EMPTY then
      alert("Error " & errorCode & " loading Holes cast")
    end if
    if netDone(g_castLoadingStatus[1]) then
      netAbort(g_castLoadingStatus[1])
      g_castLoadingStatus[1] = 0
    end if
  end if
  if g_castLoadingStatus[2] <> 0 then
    errorCode = netError(g_castLoadingStatus[2])
    if errorCode <> "OK" and errorCode <> EMPTY then
      alert("Error " & errorCode & " loading Curve Fit cast")
    end if
    if netDone(g_castLoadingStatus[2]) then
      netAbort(g_castLoadingStatus[2])
      g_castLoadingStatus[2] = 0
    end if
  end if
  val = frameTimer mod 10
  if val > 0 then
    exit
  end if
  maxhol = 18
  repeat while count(loadedList) < maxhol
    add(loadedList, 0)
  end repeat
  mem = 1
  hol = 1
  cst = 1
  ind = 1
  lod = 1
  repeat while ind <= count(castmems)
    typ = getAt(castmems, ind)
    if typ = #next then
      if cst = 1 then
        cst = 2
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
    if ind >= count(castmems) then
      setAt(loadedList, hol, lod)
    end if
  end repeat
end
on makePath val
  if voidp(val) then
    val = 1
  end if
  tmpList = []
  repeat while not the optionDown
    set the locH of sprite 32 to the mouseH
    set the locV of sprite 32 to the mouseV
    updateStage()
  end repeat
  repeat while the optionDown
    pt = point(the mouseH, the mouseV)
    tmp = the ticks
    set the locH of sprite 32 to the mouseH
    set the locV of sprite 32 to the mouseV
    updateStage()
    add(tmpList, pt)
    repeat while the ticks < tmp + 4
    end repeat
  end repeat
  cnt = 3
  repeat with z = 0 to integer(count(tmpList) / cnt) - 1
    if z = 0 then
      str = "*" & "**  "
    else
      str = str & "," & numToChar(194) & "*" & "**"
      put str
      str = "*" & "**  "
    end if
    com = ","
    repeat with w = 1 to cnt
      x = z * cnt + w
      if w = cnt then
        com = EMPTY
      end if
      str = str & string(getAt(tmpList, x)) & com
    end repeat
    cnter = cnter + 1
  end repeat
  str = str & numToChar(93) & "*" & "**"
  put str
end
on LoadExternalCasts
  g_castLoadingStatus[1] = preloadNetThing("holes.cct")
  g_castLoadingStatus[2] = preloadNetThing("curve fit.cct")
end