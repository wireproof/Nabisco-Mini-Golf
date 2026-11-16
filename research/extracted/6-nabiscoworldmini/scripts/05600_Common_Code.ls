-- Behavior
global version
global c_copyright
global c_verspr
global c_vercast
global c_start_ticks
global c_standAlone
global c_ElapsedTime
global c_SubmitFlag
global c_NumPlayers
global c_NumGames
global c_NumResets
global c_DownloadSpeed
global c_player_cheated
global c_highScore
global c_mpsession
global c_gamename
global c_hackrandom
global c_dest
global c_key
global c_specialURL
global c_dirtywords
global c_name
global c_email
global c_playerId
global c_specialData
global c_clientData
global c_winLoseTie
global cumScore
global md5buffer
global md5count0
global md5count1
global md5hexs
global md5state0
global md5state1
global md5state2
global md5state3
global md5xa

on entryPoint alone, copyright_str, version_cast, version_sprite, preload
  c_standAlone = alone
  if c_standAlone then
    clearGlobals()
    c_standAlone = 1
    if preload then
      c_start_ticks = the ticks
    else
      c_start_ticks = 0
    end if
  end if
  if the runMode contains "Plugin" then
    set the exitLock to 1
  end if
  c_SubmitFlag = 1
  c_NumGames = 1
  c_NumPlayers = 1
  c_NumResets = 0
  c_specialData = "none"
  c_name = EMPTY
  c_email = EMPTY
  c_playerId = 0
  c_winLoseTie = -1
  c_clientData = []
  c_verspr = version_sprite
  c_vercast = version_cast
  setVersion()
  if voidp(c_start_ticks) then
    setDownloadSpeed(0)
  else
    setDownloadSpeed(the ticks - c_start_ticks)
  end if
  if voidp(c_mpsession) then
    c_mpsession = EMPTY
  end if
  c_copyright = copyright_str
  if c_standAlone = 0 or the runMode contains "Author" or the runMode contains "Projector" then
    c_key = c_copyright
    c_dest = externalParamValue("sw1")
    if voidp(c_dest) then
      c_dest = "XXX"
    end if
  else
    c_key = externalParamValue("sw2")
    c_dest = externalParamValue("sw1")
  end if
  if voidp(c_key) or voidp(c_dest) then
    alert("** ERROR 21 **")
    quit()
  end if
  if c_key <> c_copyright then
    alert(c_key)
    alert(c_copyright)
    alert("** ERROR 22 **")
    quit()
  end if
  if voidp(c_ElapsedTime) then
    cElapsedTime = the ticks
  end if
  if c_standAlone or voidp(c_hackrandom) then
    inithackerprotect()
  end if
  SetUserInfo()
end
on setSubmitFlag flag
  c_SubmitFlag = flag
end
on setDownloadSpeed num
  c_DownloadSpeed = num
end
on setNumPlayers num
  c_NumPlayers = num
end
on countResets
  c_NumResets = c_NumResets + 1
end
on countGames
  c_NumGames = c_NumGames + 1
end
on playerCheated
  c_cheated = 1
end
on setSpecialSubmitURL url
  c_specialURL = url
end
on setSpecialData data
  c_specialData = data
end
on GetPlayerName
  return c_name
end
on GetPlayerId
  return c_playerId
end
on GetMpHost clientCode
  mphost = externalParamValue("SW5")
  if voidp(mphost) then
    mphost = EMPTY
  end if
  return mphost
end
on SetWinLossTie wlt
  if value(wlt) >= 0 and value(wlt) <= 5 then
    c_winLoseTie = value(wlt)
  else
    case wlt of
      #tie:
        c_winLoseTie = 0
      #win:
        c_winLoseTie = 1
      #winByDefault:
        c_winLoseTie = 2
      #lose:
        c_winLoseTie = 3
      #forefit:
        c_winLoseTie = 4

    end case
  end if
end
on exitPoint NAMECODE, namefull, playernumber, ascore, gametype, client, mpSession, MD5, md5key
  if the runMode contains "Author" then
    put reportScore(NAMECODE, namefull, playernumber, ascore, gametype, client, mpSession, MD5, md5key)
  else
    if client = #ea and voidp(externalParamValue("sw4")) <> 1 then
      gotoNetPage(externalParamValue("sw4"))
    else
      if the runMode contains "Plugin" then
        gotoNetPage(reportScore(NAMECODE, namefull, playernumber, ascore, gametype, client, mpSession, MD5, md5key))
      else
        quit()
      end if
    end if
  end if
end
on reportScore NAMECODE, namefull, playernumber, ascore, gametype, client, mpSession, md5flag, md5key
  c_highScore = ascore
  c_mpsession = mpSession
  if client = #ESPN then
    hightmp = readhackv(c_highScore)
    CODE = encryptESPN(namefull, hightmp, 0)
  else
    if client = #ford then
      hightmp = readhackv(c_highScore)
      CODE = encryptFORD(namefull, hightmp, 0)
    else
      if client = #generic or client = #geerc or client = #rcade then
        t = c_highScore
        if integerp(t) = 1 then
          hightmp = readhackv(c_highScore)
          temp = readhackv(c_highScore)
        else
          hightmp = []
          repeat with i = 1 to count(c_highScore)
            add(hightmp, readhackv(getAt(c_highScore, i)))
          end repeat
          temp = getAt(hightmp, i - 1)
        end if
        CODE = encrypt(namefull, temp, 0)
      else
        if client <> #sandbox then
          hightmp = readhackv(c_highScore)
          CODE = encrypt(namefull, hightmp, 0)
        else
          if client = #sandbox then
            hightmp = ascore
            CODE = 0
          end if
        end if
      end if
    end if
  end if
  gamnam = NAMECODE
  pnum = playernumber
  str3 = "no_client_specified"
  if client = #nabisco then
    str = "gamename=" & gamnam
    str = str & "&score" & string(pnum) & "=" & string(hightmp)
    str = str & "&code" & string(pnum) & "=" & CODE
    str = str & "&sf=" & string(c_SubmitFlag)
    str = str & "&np=" & string(c_NumPlayers)
    str = str & "&ng=" & string(c_NumGames)
    str = str & "&nr=" & string(c_NumResets)
    data = int((the ticks - c_ElapsedTime) / 60)
    str = str & "&tp=" & string(data)
    data = testPerformance()
    str = str & "&ms=" & string(data)
    str = str & "&mr=" & the memorysize
    str = str & "&bd=" & the colorDepth
    str = str & "&pi=" & string(version)
    str = str & "&ds=" & string(c_DownloadSpeed)
    str = str & "&sn=" & c_mpsession
    str = str & "&dt=" & GetCurrentDate()
    dtlst = the desktopRectList
    if count(dtlst) >= 1 then
      r1 = getAt(dtlst, 1)
    else
      r1 = rect(0, 0, 0, 0)
    end if
    str = str & "&ss=" & string(r1.width) & "by" & string(r1.height)
    str = str & "&sp=" & string(c_specialData)
    str = str & "&tt=" & string(SecondsSinceMidnight())
    str = str & "&vr=" & member(c_vercast).text
    if md5flag then
      str4 = MD5(str & "&" & string(md5key))
      str = str & "&" & str4
    end if
    dest = externalParamValue("sw4")
    if voidp(dest) or length(dest) < 1 then
      dest = "/asp/leader.asp"
    end if
    str3 = dest & "?param=" & scramble(str, randList(random(32)))
    if the runMode contains "Author" then
      put dest & "?param=" & str
    end if
  else
    if client = #NabiscoKM then
      str3 = ReportScoreNabiscoKidsModule(gamnam, hightmp, CODE, playernumber, md5flag, md5key)
    else
      if client = #foxSports then
        str3 = ReportScoreFoxSports(gamnam, hightmp, CODE, playernumber, md5flag, md5key)
      else
        if client = #ea then
          str3 = c_dest & "?gamename="
          str3 = str3 & gamnam
          str3 = str3 & "&name1=" & externalParamValue("sw3")
          str3 = str3 & "&highscor" & string(pnum) & "=" & string(hightmp)
          str4 = MD5(str3 & md5key)
          str3 = str3 & "&" & str4
        else
          if client = #ford then
            pnum = 1
            if hightmp > 0 then
              str1 = c_dest & gamnam & "score.pl?param="
              str4 = "gamename=" & gamnam
              str4 = str4 & "&datetime" & "=" & timeStamp()
              str4 = str4 & "&name" & string(pnum) & "=" & string(c_name)
              str4 = str4 & "&email" & string(pnum) & "=" & lowercase(string(c_email))
              str4 = str4 & "&score" & string(pnum) & "=" & string(hightmp)
              str4 = str4 & "&code" & string(pnum) & "=" & CODE
              enflag = externalParamValue("sw4")
              if enflag = 0 then
                str3 = str1 & str4
              else
                str3 = str1 & scramble(str4, randList(random(32)))
              end if
            else
              str3 = c_dest & gamnam & "score.pl"
            end if
          else
            if client = #sportcut then
              str3 = reportScoreSportCut(gamnam)
            else
              if client = #sandbox then
                dest = externalParamValue("sw1")
                str3 = dest & "?gamename=" & gamnam
                str4 = EMPTY
                repeat with i = 1 to count(hightmp)
                  str4 = str4 & "&v" & string(i) & "=" & string(getAt(hightmp, i))
                end repeat
                str4 = str4 & "&games=" & string(c_NumGames)
                str4 = str4 & "&userid=" & externalParamValue("sw4")
                str3 = str3 & str4 & "&ds=" & MD5(str4 & md5key)
              else
                if client = #ESPN then
                  id = externalParamValue("sw3")
                  if voidp(id) then
                    id = 0
                  end if
                  str3 = c_dest & "?gamename="
                  str3 = str3 & gamnam
                  str3 = str3 & "&score" & string(pnum) & "=" & string(hightmp)
                  str3 = str3 & "&code" & string(pnum) & "=" & CODE
                  str3 = str3 & "&id" & string(pnum) & "=" & string(id)
                else
                  if client = #microsoft then
                    dest = externalParamValue("sw1")
                    str3 = "?game=" & gamnam
                    str3 = str3 & "&score=" & string(hightmp)
                    str3 = str3 & "&time=" & the long time
                    str3 = str3 & "&date=" & the date
                    str3 = str3 & "&ds=" & MD5(str3 & md5key)
                    str3 = dest & str3
                  else
                    if client = #kraft then
                      dest = externalParamValue("sw1")
                      str3 = "?userid=" & externalParamValue("sw3")
                      str3 = str3 & "&score=" & string(hightmp)
                      str3 = dest & str3
                    else
                      if client = #tyco or client = #generic then
                        str3 = ReportScoreGeneric(gamnam, hightmp, md5flag, md5key)
                      else
                        if client = #Postopia then
                          str3 = ReportScorePostopia(hightmp)
                        else
                          if client = #Cornnuts then
                            str3 = ReportScoreCornnuts(gamnam, hightmp)
                          else
                            if client = #rcade then
                              str3 = ReportScoreRcade(gamnam, hightmp, md5flag, md5key)
                            else
                              if client = #geerc then
                                str3 = ReportScoreGEERC(gamnam, hightmp, c_clientData[3], c_specialData, md5flag, md5key)
                              end if
                            end if
                          end if
                        end if
                      end if
                    end if
                  end if
                end if
              end if
            end if
          end if
        end if
      end if
    end if
  end if
  return str3
end
on showVersion
  if the controlDown then
    if the keyCode = 9 or the keyCode = 44 then
      show(c_verspr)
    else
      hide(c_verspr)
    end if
  end if
end
on clearVersion
  if the controlDown then
    showVersion()
  else
    hide(c_verspr)
  end if
end
on setVersion
  if the runMode contains "Author" then
    oldver = member(c_vercast).text
    i = offset(".", oldver)
    if i = 0 then
      i = length(oldver)
    end if
    str = the date
    month = EMPTY
    day = EMPTY
    repeat with x = 1 to length(str)
      if char x of str = "/" then
        exit repeat
      end if
      month = month & char x of str
    end repeat
    y = x + 1
    repeat with x = y to length(str)
      if char x of str = "/" then
        exit repeat
      end if
      day = day & char x of str
    end repeat
    if length(month) < 2 then
      month = "0" & month
    end if
    if length(day) < 2 then
      day = "0" & day
    end if
    str1 = "V" & month & day
    if str1 <> chars(oldver, 1, i - 1) then
      subver = ".1"
    else
      if i > 0 then
        subver = "." & string(value(chars(oldver, i + 1, length(oldver))) + 1)
      end if
    end if
    member(c_vercast).text = str1 & subver
  end if
end
on testPerformance
  j = the ticks
  my_count = 0
  updateStage()
  repeat while the ticks - j <= 20
    a = float(cos(PI)) * (1000.0 / 2.5)
    my_count = my_count + 1
  end repeat
  my_count = int(my_count / 20)
  return my_count
end
on encrypt gamename, scoreval, cheated
  repeat while scoreval > 99999
    scoreval = int(scoreval / 7)
  end repeat
  string1 = gamename
  if length(string1) < 1 then
    string1 = "X"
  end if
  repeat while length(string1) < 13
    string1 = string1 & string1
  end repeat
  string1 = uppercase(string1)
  CD1 = charToNum(char 2 of string1) - 64
  CD2 = charToNum(char 4 of string1) - 64
  CD3 = charToNum(char 5 of string1) - 64
  CD4 = charToNum(char 9 of string1) - 64
  CD5 = charToNum(char 13 of string1) - 64
  NAMECODE = CD1 * 1024 + CD2 * 32 + CD3 - CD4 - CD5
  if cheated then
    DAYCODE = 6 * 32
  else
    DAYCODE = 7 * 32
  end if
  CODE = (scoreval + DAYCODE) * NAMECODE
  codenums = []
  repeat while CODE > 0
    add(codenums, CODE - 32 * int(CODE / 32))
    CODE = int(CODE / 32)
  end repeat
  codeList = [1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  codeStr = EMPTY
  repeat with x = 1 to count(codenums)
    codeStr = codeStr & getAt(codeList, getAt(codenums, x) + 1)
  end repeat
  return codeStr
end
on uppercase whichString
  newString = EMPTY
  len = length(whichString)
  repeat with x = 1 to len
    thisChar = char x of whichString
    if charToNum(thisChar) >= 97 and charToNum(thisChar) <= 122 then
      thisChar = numToChar(charToNum(thisChar) - 32)
    end if
    newString = newString & thisChar
  end repeat
  return newString
end
on int val
  if val > 0 then
    if val < 1 then
      return 0
    end if
    tmp = val - 0.5
  else
    if val > -1 then
      return 0
    end if
    tmp = val + 0.5
  end if
  return integer(tmp)
end
on CGIspaces instr
  str = EMPTY
  repeat with x = 1 to length(instr)
    cH = char x of instr
    if cH = " " then
      cH = "%20"
    end if
    if cH = "." then
      cH = "%2E"
    end if
    if cH = ";" then
      cH = "%3B"
    end if
    if cH = "@" then
      cH = "%40"
    end if
    str = str & cH
  end repeat
  return str
end
on lowercase whichString
  newString = EMPTY
  len = length(whichString)
  repeat with x = 1 to len
    thisChar = char x of whichString
    if charToNum(thisChar) >= 65 and charToNum(thisChar) <= 90 then
      thisChar = numToChar(charToNum(thisChar) + 32)
    end if
    newString = newString & thisChar
  end repeat
  return newString
end
on timeStamp
  str = the date && the time
  return str
end
on inithackerprotect val
  if voidp(val) then
    c_hackrandom = 5000 + random(5000)
  else
    c_hackrandom = val
  end if
end
on inithackv val
  val = val + c_hackrandom
  return val
end
on readhackv val
  temp = val - c_hackrandom
  return temp
end
on show spr
  h = the locH of sprite spr
  if h > 2000 then
    if not the puppet of sprite spr then
      set the puppet of sprite spr to 1
    end if
    set the locH of sprite spr to h - 4000
  end if
end
on hide spr
  h = the locH of sprite spr
  if h < 2000 then
    if not the puppet of sprite spr then
      set the puppet of sprite spr to 1
    end if
    set the locH of sprite spr to h + 4000
  end if
end
on initSprites startCastMember, endCastMember, isVisible
  repeat with x = startCastMember to endCastMember
    set the stretch of sprite x to 0
    set the ink of sprite x to 36
    set the puppet of sprite x to 1
    if voidp(isVisible) then
      isVisible = 0
    end if
    sprite(x).visible = isVisible
  end repeat
end
on disableSprites startCastMember, endCastMember
  repeat with x = startCastMember to endCastMember
    sprite(x).visible = 0
  end repeat
end
on enableSprites startCastMember, endCastMember
  repeat with x = startCastMember to endCastMember
    sprite(x).visible = 1
  end repeat
end
on drawSprite spr, pic, h, v
  set the memberNum of sprite spr to pic
  set the locH of sprite spr to h
  set the locV of sprite spr to v
end
on offsetSprite spr, h, v
  set the locH of sprite spr to the locH of sprite spr + h
  set the locV of sprite spr to the locV of sprite spr + v
end
on copySprite source, target
  set the locH of sprite target to the locH of sprite source
  set the locV of sprite target to the locV of sprite source
  sprite(target).locZ = sprite(source).locZ
  sprite(target).rotation = sprite(source).rotation
end
on showSprite spr
  sprite(spr).visible = 1
end
on hideSprite spriteNumber
  sprite(spriteNumber).visible = 0
end
on spriteOffTheStage spriteChannel
  result = 0
  if the locH of sprite spriteChannel > the stageRight - the stageLeft or the locV of sprite spriteChannel > the stageBottom - the stageTop or the locH of sprite spriteChannel < 0 or the locV of sprite spriteChannel < 0 then
    result = 1
  end if
  return result
end
on sizeSprite spriteChannel, spriteWidth, spriteHeight
  spriteWidth = integer(spriteWidth)
  spriteHeight = integer(spriteHeight)
  x = the locH of sprite spriteChannel
  y = the locV of sprite spriteChannel
  p = the memberNum of sprite spriteChannel
  regpt = member(sprite(spriteChannel).memberNum).regPoint
  sx = float(spriteWidth) / float(member(p).width)
  sy = float(spriteHeight) / float(member(p).height)
  setAt(regpt, 1, getAt(regpt, 1) * sx)
  setAt(regpt, 2, getAt(regpt, 2) * sy)
  w = spriteWidth
  h = spriteHeight
  identityPoly = list(point(0.0, 0.0), point(w, 0.0), point(w, h), point(0.0, h))
  identityPoly = identityPoly - list(regpt, regpt, regpt, regpt)
  xy = point(x, y)
  identityPoly = identityPoly + list(xy, xy, xy, xy)
  sprite(spriteChannel).quad = identityPoly
  set the memberNum of sprite spriteChannel to p
end
on sizesprnorm spriteChannel
  x = the locH of sprite spriteChannel
  y = the locV of sprite spriteChannel
  p = the memberNum of sprite spriteChannel
  regpt = member(sprite(spriteChannel).memberNum).regPoint
  w = member(p).width
  h = member(p).height
  identityPoly = list(point(0.0, 0.0), point(w, 0.0), point(w, h), point(0.0, h))
  identityPoly = identityPoly - list(regpt, regpt, regpt, regpt)
  xy = point(x, y)
  identityPoly = identityPoly + list(xy, xy, xy, xy)
  sprite(spriteChannel).quad = identityPoly
  set the memberNum of sprite spriteChannel to p
end
on enableField spriteNum
  set the editableText of sprite spriteNum to 1
  set the selEnd to 0
  set the selStart to 0
end
on debugSprite spriteNum
  put "-=-=-=-=-= sprite " & string(spriteNum) & " =-=-=-=-=-"
  put "X pos:" && the locH of sprite spriteNum
  put "Y pos:" && the locV of sprite spriteNum
  put "Z pos:" && sprite(spriteNum).locZ
  put "Width:" && the width of sprite spriteNum
  put "Height:" && the height of sprite spriteNum
  put sprite(spriteNum).quad
  put "Ink:" && the ink of sprite spriteNum
  put "blend:" && the blend of sprite spriteNum
  put "foreColor:" && the foreColor of sprite spriteNum
  put "backColor:" && the backColor of sprite spriteNum
  put "Rot:" && string(sprite(spriteNum).rotation) && "flipH=" & string(sprite(spriteNum).flipH) & "flipV=" && string(sprite(spriteNum).flipV)
  txt = "Member:" && the member of sprite spriteNum
  if sprite(spriteNum).memberNum <> 0 then
    txt = txt && "(Type is " & member(sprite(spriteNum).memberNum).type & ")"
  end if
  put txt
  put "Editable:" && the editableText of sprite spriteNum
  put "Visible:" && sprite(spriteNum).visible
  put "puppet:" && the puppet of sprite spriteNum
  put "Behaviors:" && sprite(spriteNum).scriptInstanceList
end
on reportScoreSportCut gamnam
  dest = externalParamValue("sw1")
  userID = externalParamValue("sw3")
  enflag = externalParamValue("sw4")
  pnum = 1
  str1 = dest & "?param="
  str = "gamename=" & gamnam
  str = str & "&name" & string(pnum) & "=" & string(userID)
  str = str & "&score" & string(pnum) & "=" & string(readhackv(c_highScore))
  str = str & "&highScore" & string(pnum) & "=" & string(readhackv(c_highScore))
  if enflag = 0 then
    return str1 & str
  else
    return str1 & scramble(str, randList(random(32)))
  end if
end
on ReportScoreNabiscoKidsModule gamnam, hightmp, CODE, playerNum, md5flag, md5key
  where = externalParamValue("sw4")
  if voidp(where) then
    where = "/default.htm"
  end if
  if the runMode contains "Author" then
    put "quit to sw4" && where
  end if
  return where
end
on ReportScoreFoxSports gamnam, hightmp, CODE, playerNum, md5flag, md5key
  str = "gamename=" & gamnam
  str = str & "&score" & string(playerNum) & "=" & string(hightmp)
  str = str & "&code" & string(playerNum) & "=" & CODE
  if not voidp(c_playerId) and c_playerId <> 0 then
    str = str & "&pn=" & string(c_playerId)
  end if
  if not voidp(c_winLoseTie) and c_winLoseTie <> -1 then
    str = str & "&wl=" & string(c_winLoseTie)
  end if
  str = str & "&sf=" & string(c_SubmitFlag)
  str = str & "&np=" & string(c_NumPlayers)
  str = str & "&ng=" & string(c_NumGames)
  str = str & "&nr=" & string(c_NumResets)
  data = int((the ticks - c_ElapsedTime) / 60)
  str = str & "&tp=" & string(data)
  data = testPerformance()
  str = str & "&ms=" & string(data)
  str = str & "&mr=" & the memorysize
  str = str & "&bd=" & the colorDepth
  str = str & "&pi=" & CGIspaces(string(version))
  str = str & "&ds=" & string(c_DownloadSpeed)
  if not voidp(c_mpsession) and c_mpsession <> EMPTY then
    str = str & "&sn=" & c_mpsession
  end if
  str = str & "&dt=" & GetCurrentDate()
  str = str & "&tt=" & string(SecondsSinceMidnight())
  str = str & "&vr=" & member(c_vercast).text
  dtlst = the desktopRectList
  if count(dtlst) >= 1 then
    r1 = getAt(dtlst, 1)
  else
    r1 = rect(0, 0, 0, 0)
  end if
  str = str & "&ss=" & string(r1.width) & "by" & string(r1.height)
  if not voidp(c_specialData) and c_specialData <> EMPTY then
    str = str & "&sp=" & CGIspaces(c_specialData)
  end if
  dest = externalParamValue("sw4")
  if voidp(dest) or length(dest) < 1 then
    dest = "/asp/leader.asp"
  end if
  if the runMode contains "Author" then
    put dest & "?" & str
  end if
  if voidp(md5flag) then
    md5flag = 0
  end if
  if md5flag then
    md5str = MD5(str & md5key)
    str3 = dest & "?" & str & "&cr=" & md5str
  else
    str3 = dest & "?param=" & scramble(str, randList(random(32)))
  end if
  return str3
end
on ReportScorePostopia hightmp
  str = EMPTY
  activityId = externalParamValue("SW6")
  if not voidp(activityId) then
    str = str & "ActivityId=" & activityId
  end if
  playerId = externalParamValue("SW3")
  if not voidp(playerId) then
    if length(str) > 0 then
      str = str & "&"
    end if
    str = str & "UserId=" & playerId
  end if
  if length(str) > 0 then
    str = str & "&"
  end if
  str = str & "Score=" & string(hightmp)
  str = str & "&ScoreId=" & string(hightmp)
  str = str & "&ScoreCode=" & string(hightmp)
  str = str & "&SubmitDate=" & the date && the time
  str = str & "&TiltFlag=" & string(c_SubmitFlag)
  str = str & "&TotalPlayers=" & string(c_NumPlayers)
  str = str & "&GamesCompleted=" & string(c_NumGames)
  str = str & "&Restarts=" & string(c_NumResets)
  data = int((the ticks - c_ElapsedTime) / 60)
  str = str & "&PlayTime=" & string(data)
  data = testPerformance()
  str = str & "&CPUSpeed=" & string(data)
  str = str & "&CPURam=" & the memorysize
  str = str & "&CPUDesc=" & the platform
  str = str & "&VideoRes=" & the colorDepth
  str = str & "&PlugInVersion=" & string(version)
  dtlst = the desktopRectList
  if count(dtlst) >= 1 then
    r1 = getAt(dtlst, 1)
  else
    r1 = rect(0, 0, 0, 0)
  end if
  str = str & "&VideoSize=" & string(r1.width) & "by" & string(r1.height)
  str = str & "&DownloadTime=" & string(c_DownloadSpeed)
  if not voidp(c_mpsession) and c_mpsession <> EMPTY then
    str = str & "&MPlaySessionId=" & c_mpsession
  end if
  str = CGIspaces(str)
  dest = externalParamValue("SW4")
  if voidp(dest) or length(dest) < 1 then
    dest = "/asp/leader.asp"
  end if
  str3 = dest & "?" & str
  return str3
end
on ReportScoreGeneric gamnam, hightmp, md5flag, md5key
  str = "gamename=" & gamnam
  t = hightmp
  if integerp(t) = 1 then
    str = str & "&score" & "=" & string(hightmp)
  else
    repeat with i = 1 to count(hightmp)
      str = str & "&score" & string(i) & "=" & string(getAt(hightmp, i))
    end repeat
  end if
  str = str & "&pn=" & c_playerId
  str = str & "&ns=" & c_name
  str = str & "&sf=" & string(c_SubmitFlag)
  str = str & "&np=" & string(c_NumPlayers)
  str = str & "&ng=" & string(c_NumGames)
  str = str & "&nr=" & string(c_NumResets)
  data = int((the ticks - c_ElapsedTime) / 60)
  str = str & "&tp=" & string(data)
  data = testPerformance()
  str = str & "&ms" & "=" & string(data)
  str = str & "&mr=" & the memorysize
  str = str & "&bd=" & the colorDepth
  str = str & "&pi=" & CGIspaces(string(version))
  str = str & "&ds=" & string(c_DownloadSpeed)
  str = str & "&sn=" & c_mpsession
  str = str & "&dt=" & GetCurrentDate()
  dtlst = the desktopRectList
  if count(dtlst) >= 1 then
    r1 = getAt(dtlst, 1)
  else
    r1 = rect(0, 0, 0, 0)
  end if
  str = str & "&ss=" & string(r1.width) & "by" & string(r1.height)
  if c_specialData <> EMPTY then
    str = str & "&sp=" & string(c_specialData)
  end if
  str = str & "&tt=" & string(SecondsSinceMidnight())
  str = str & "&vr=" & member(c_vercast).text
  str = CGIspaces(str)
  dest = externalParamValue("sw4")
  if voidp(dest) or length(dest) < 1 then
    dest = "/asp/leader.asp"
  end if
  if voidp(md5flag) then
    md5flag = 0
  end if
  if md5flag then
    md5str = MD5(str & md5key)
    str = str & "&cr=" & md5str
  end if
  str3 = dest & "?" & str
  return str3
end
on ReportScoreRcade gamnam, hightmp, md5flag, md5key
  str = "gamename=" & gamnam
  t = hightmp
  if integerp(t) = 1 then
    str = str & "&score" & "=" & string(hightmp)
  else
    repeat with i = 1 to count(hightmp)
      str = str & "&score" & string(i) & "=" & string(getAt(hightmp, i))
    end repeat
  end if
  str = str & "&pn=" & c_playerId
  str = str & "&ns=" & c_name
  str = str & "&sf=" & string(c_SubmitFlag)
  str = str & "&np=" & string(c_NumPlayers)
  str = str & "&ng=" & string(c_NumGames)
  str = str & "&nr=" & string(c_NumResets)
  data = int((the ticks - c_ElapsedTime) / 60)
  str = str & "&tp=" & string(data)
  data = testPerformance()
  str = str & "&ms" & "=" & string(data)
  str = str & "&mr=" & the memorysize
  str = str & "&bd=" & the colorDepth
  str = str & "&pi=" & string(version)
  str = str & "&ds=" & string(c_DownloadSpeed)
  str = str & "&sn=" & c_mpsession
  str = str & "&dt=" & GetCurrentDate()
  dtlst = the desktopRectList
  if count(dtlst) >= 1 then
    r1 = getAt(dtlst, 1)
  else
    r1 = rect(0, 0, 0, 0)
  end if
  str = str & "&ss=" & string(r1.width) & "by" & string(r1.height)
  if c_specialData <> EMPTY then
    str = str & "&sp=" & string(c_specialData)
  end if
  str = str & "&tt=" & string(SecondsSinceMidnight())
  str = str & "&vr=" & member(c_vercast).text
  dest = externalParamValue("sw4")
  if voidp(dest) or length(dest) < 1 then
    dest = "/ScoreSubmit.jsp"
  end if
  if voidp(md5flag) then
    md5flag = 0
  end if
  if md5flag then
    str = CGIspaces(str)
    md5str = MD5(str & md5key)
    str3 = dest & "?" & str & "&cr=" & md5str
  else
    str3 = dest & "?param=" & scramble(str, randList(random(32)))
  end if
  return str3
end
on ReportScoreGEERC gamnam, hightmp, playerType, extraData, md5flag, md5key
  str = "gamename=" & gamnam
  if integerp(hightmp) then
    str = str & "&score" & "=" & string(hightmp)
  else
    repeat with i = 1 to count(hightmp)
      str = str & "&score" & string(i) & "=" & string(getAt(hightmp, i))
    end repeat
  end if
  str = str & "&sf=" & string(c_SubmitFlag)
  str = str & "&np=" & string(c_NumPlayers)
  str = str & "&ng=" & string(c_NumGames)
  str = str & "&nr=" & string(c_NumResets)
  data = int((the ticks - c_ElapsedTime) / 60)
  str = str & "&tp=" & string(data)
  data = testPerformance()
  str = str & "&ms" & "=" & string(data)
  str = str & "&mr=" & the memorysize
  str = str & "&bd=" & the colorDepth
  str = str & "&pi=" & string(version)
  str = str & "&ds=" & string(c_DownloadSpeed)
  str = str & "&sn=" & c_mpsession
  str = str & "&dt=" & GetCurrentDate()
  dtlst = the desktopRectList
  if count(dtlst) >= 1 then
    r1 = getAt(dtlst, 1)
  else
    r1 = rect(0, 0, 0, 0)
  end if
  str = str & "&ss=" & string(r1.width) & "by" & string(r1.height)
  if voidp(extraData) or extraData = EMPTY then
    extraData = EMPTY
  end if
  str = str & "&sp=" & string(extraData)
  str = str & "&tt=" & string(SecondsSinceMidnight())
  str = str & "&op=" & string(playerType)
  str = str & "&vr=" & member(c_vercast).text
  dest = externalParamValue("sw4")
  if voidp(dest) or length(dest) < 1 then
    dest = "/ScoreSubmit.jsp"
  end if
  if voidp(md5flag) then
    md5flag = 0
  end if
  if md5flag then
    str = CGIspaces(str)
    md5str = MD5(str & md5key)
    str3 = dest & "?" & str & "&cr=" & md5str
  else
    str3 = dest & "?param=" & scramble(str, randList(random(32)))
  end if
  return str3
end
on ReportScoreCornnuts gamnam, hightmp
  str = "gamename=" & gamnam
  str = str & "&score" & "=" & string(hightmp)
  str = str & "&code=" & MD5(string(hightmp) & "sk8bird")
  str = str & "&pn=" & c_playerId
  str = str & "&sf=" & string(c_SubmitFlag)
  str = str & "&np=" & string(c_NumPlayers)
  str = str & "&ng=" & string(c_NumGames)
  str = str & "&nr=" & string(c_NumResets)
  data = int((the ticks - c_ElapsedTime) / 60)
  str = str & "&tp=" & string(data)
  data = testPerformance()
  str = str & "&ms" & "=" & string(data)
  str = str & "&mr=" & the memorysize
  str = str & "&bd=" & the colorDepth
  str = str & "&pi=" & CGIspaces(string(version))
  str = str & "&ds=" & string(c_DownloadSpeed)
  str = str & "&sn=" & c_mpsession
  str = str & "&dt=" & GetCurrentDate()
  dtlst = the desktopRectList
  if count(dtlst) >= 1 then
    r1 = getAt(dtlst, 1)
  else
    r1 = rect(0, 0, 0, 0)
  end if
  str = str & "&ss=" & string(r1.width) & "by" & string(r1.height)
  if c_specialData <> EMPTY then
    str = str & "&sp=" & string(c_specialData)
  end if
  str = str & "&tt=" & string(SecondsSinceMidnight())
  dest = externalParamValue("sw4")
  if voidp(dest) or length(dest) < 1 then
    dest = "/asp/leader.asp"
  end if
  str3 = dest & "?" & str
  return str3
end
on scramble instr, lst
  bitstream = []
  repeat with x = 1 to length(instr)
    val = charToNum(char x of instr)
    cmp = 64
    repeat with cnt = 1 to 7
      if val >= cmp then
        add(bitstream, 1)
        val = val - cmp
      else
        add(bitstream, 0)
      end if
      cmp = cmp / 2
    end repeat
  end repeat
  repeat while count(bitstream) mod 5 <> 0
    add(bitstream, 0)
  end repeat
  codeList = duplicate(lst)
  outstr = EMPTY
  ind = 1
  repeat while ind < count(bitstream)
    val = 0
    repeat with x = 1 to 5
      val = val * 2
      if getAt(bitstream, ind) then
        val = val + 1
      end if
      ind = ind + 1
    end repeat
    outstr = outstr & getAt(codeList, val + 1)
  end repeat
  return outstr
end
on unscramble instr
  repeat with rnd = 1 to 32
    clst = randList(rnd)
    outstr = unscram(instr, clst)
    first8 = EMPTY
    repeat with n = 1 to 8
      first8 = first8 & char n of outstr
    end repeat
    if first8 = "gamename" then
      return outstr
    end if
  end repeat
end
on unscram instr, clst
  codeList = duplicate(clst)
  bitstream = []
  repeat with x = 1 to length(instr)
    cH = char x of instr
    val = getPos(codeList, cH) - 1
    if val >= 0 then
      cmp = 16
      repeat with cnt = 1 to 5
        if val >= cmp then
          add(bitstream, 1)
          val = val - cmp
        else
          add(bitstream, 0)
        end if
        cmp = cmp / 2
      end repeat
    end if
  end repeat
  repeat while count(bitstream) mod 7 <> 0
    add(bitstream, 0)
  end repeat
  outstr = EMPTY
  ind = 1
  repeat while ind < count(bitstream)
    val = 0
    repeat with x = 1 to 7
      val = val * 2
      if getAt(bitstream, ind) then
        val = val + 1
      end if
      ind = ind + 1
    end repeat
    outstr = outstr & numToChar(val)
  end repeat
  return outstr
end
on randList rnd
  case rnd of
    1:
      str = "ZMX4D8JW2EC37QPTSA56R9LYVUKB1HFN"
    2:
      str = "SZ8CYENR93B54M2JUPKLQVFHDT6AW71X"
    3:
      str = "HL2BANC1VWS6UQP3K7M4ZR8YTJ9XED5F"
    4:
      str = "42VA1M8QXKCPDSF9BY3ZL5JTWNR67HEU"
    5:
      str = "PA4W7EM9VU36LCNHXYSQF2BDRK518ZJT"
    6:
      str = "5ZPDLUTA3YC8HQMN6KRV7JEX241BF9SW"
    7:
      str = "LXUEKQ61HZWC97T3JF8PYAMSB4DV2NR5"
    8:
      str = "XTVDSUPFH96RZCMWJL7YE28N54BQ3A1K"
    9:
      str = "7KRSZ1X36UA89CB4PDQJNTWH2LEFY5VM"
    10:
      str = "EP2X7LJARDF1V3ZCKTW4Q59BMUY8SHN6"
    11:
      str = "K1DLXC84HN52JM3RA69ZF7PYTQBWSUVE"
    12:
      str = "MCJTYS682FDVUX9RP5EWZ37LANQK4BH1"
    13:
      str = "MJ64T17VZBKWYQH29PF38LNAUDSCXER5"
    14:
      str = "K4VDJT7PS5NEBRWFC1QU3ML268ZHXA9Y"
    15:
      str = "EZKLWUQDCAJSF9YNM8B73V512PT4XH6R"
    16:
      str = "7XBHN35SRPDU2MT4LWK19F8ZVCQEJ6YA"
    17:
      str = "XLHB576PAQ92UE8YKTN4DSRJ3CMZV1WF"
    18:
      str = "LRFT9A4EQKYH8X127MC6P3UBJS5DNZVW"
    19:
      str = "5731XB94RUM2DSHNVTFQKELZ8PA6CYJW"
    20:
      str = "NMUTXKSE6DBQ3FA87HY14V5CRL2JW9PZ"
    21:
      str = "3V6JY4PFRMLDBUKSEWHTQZ5128CXA97N"
    22:
      str = "FNC96QBJ3XWMV4DYRAZ2TKPU18L5S7HE"
    23:
      str = "RQWZP2F431U87JYBNHMKEDCSV69TLXA5"
    24:
      str = "ZT41VUKXJC97YWSNFL8E6MDR3PQ5HA2B"
    25:
      str = "5R6QFVZ1NLWE7P89CA4KMXYBDTU3HJ2S"
    26:
      str = "764JUPR1QSBAFTD5Z2Y8MNEW9VCLHXK3"
    27:
      str = "8Y4VNFPAL3QB7SR6EDXHK92ZU5TJW1MC"
    28:
      str = "6RZCEQFT31UWLVNYK8DBS75A4HJ2XMP9"
    29:
      str = "2DYFX8UH56SCMNLAWVQZKP9T31RB74JE"
    30:
      str = "VK3BE2JUFPDW6X1YZ7QT48SARLHN5C9M"
    31:
      str = "L3JX4C5FZ6BNSY28UAKMHPT9ERV1DQW7"
    32:
      str = "8PM3YV7T4H5AJBLUNCFWSE69QD1Z2KRX"

  end case
  tmplst = []
  repeat with x = 1 to length(str)
    chr = char x of str
    add(tmplst, chr)
  end repeat
  return tmplst
end
on encryptESPN gamename, scoreval, cheated
  repeat while scoreval > 99999
    scoreval = int(scoreval / 7)
  end repeat
  string1 = gamename
  if length(string1) < 1 then
    string1 = "X"
  end if
  repeat while length(string1) < 13
    string1 = string1 & string1
  end repeat
  string1 = uppercase(string1)
  CD1 = charToNum(char 2 of string1) - 64
  CD2 = charToNum(char 3 of string1) - 64
  CD3 = charToNum(char 8 of string1) - 64
  CD4 = charToNum(char 9 of string1) - 64
  CD5 = charToNum(char 11 of string1) - 64
  NAMECODE = CD1 * 1024 + CD2 * 32 + CD3 - CD4 - CD5
  if cheated then
    DAYCODE = 6 * 32
  else
    DAYCODE = 7 * 32
  end if
  CODE = (scoreval + DAYCODE) * NAMECODE
  codenums = []
  repeat while CODE > 0
    add(codenums, CODE - 32 * int(CODE / 32))
    CODE = int(CODE / 32)
  end repeat
  codeList = [1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  codeStr = EMPTY
  repeat with x = 1 to count(codenums)
    codeStr = codeStr & getAt(codeList, getAt(codenums, x) + 1)
  end repeat
  return codeStr
end
on encryptFORD gamename, scoreval, cheated
  repeat while scoreval > 99999
    scoreval = int(scoreval / 7)
  end repeat
  string1 = gamename
  if length(string1) < 1 then
    string1 = "X"
  end if
  repeat while length(string1) < 13
    string1 = string1 & string1
  end repeat
  string1 = uppercase(string1)
  CD1 = charToNum(char 1 of string1) - 64
  CD2 = charToNum(char 3 of string1) - 64
  CD3 = charToNum(char 4 of string1) - 64
  CD4 = charToNum(char 9 of string1) - 64
  CD5 = charToNum(char 10 of string1) - 64
  NAMECODE = CD1 * 1024 + CD2 * 32 + CD3 - CD4 - CD5
  if cheated then
    DAYCODE = 6 * 32
  else
    DAYCODE = 7 * 32
  end if
  CODE = (scoreval + DAYCODE) * NAMECODE
  codenums = []
  repeat while CODE > 0
    add(codenums, CODE - 32 * int(CODE / 32))
    CODE = int(CODE / 32)
  end repeat
  codeList = [1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  codeStr = EMPTY
  repeat with x = 1 to count(codenums)
    codeStr = codeStr & getAt(codeList, getAt(codenums, x) + 1)
  end repeat
  return codeStr
end
on MD5 input
  md5init()
  md5update(input, length(input))
  return md5final()
end
on md5and x, y
  r = 0
  repeat with i = 1 to 32
    r = r * 2
    if x < 0 and y < 0 then
      r = r + 1
    end if
    x = x * 2
    y = y * 2
  end repeat
  return r
end
on md5FF a, b, c, d, x, s, ac
  x = getAt(md5xa, x + 1)
  ac = md5x(ac)
  a = a + md5or(md5and(b, c), md5and(md5not(b), d)) + x + ac
  a = md5rotate_left(a, s)
  a = a + b
  return a
end
on md5GG a, b, c, d, x, s, ac
  x = getAt(md5xa, x + 1)
  ac = md5x(ac)
  a = a + md5or(md5and(b, d), md5and(c, md5not(d))) + x + ac
  a = md5rotate_left(a, s)
  a = a + b
  return a
end
on md5HH a, b, c, d, x, s, ac
  x = getAt(md5xa, x + 1)
  ac = md5x(ac)
  a = a + md5xor(md5xor(b, c), d) + x + ac
  a = md5rotate_left(a, s)
  a = a + b
  return a
end
on md5II a, b, c, d, x, s, ac
  x = getAt(md5xa, x + 1)
  ac = md5x(ac)
  a = a + md5xor(c, md5or(b, md5not(d))) + x + ac
  a = md5rotate_left(a, s)
  a = a + b
  return a
end
on md5encode4 n
  s = EMPTY
  h = 0
  d = 0
  repeat with i = 1 to 32
    h = h * 2
    if n < 0 then
      h = h + 1
    end if
    n = n * 2
    d = d + 1
    if d = 4 then
      s = s & char h + 1 of md5hexs
      d = 0
      h = 0
    end if
  end repeat
  return char 7 to 8 of s & char 5 to 6 of s & char 3 to 4 of s & char 1 to 2 of s
end
on md5encode8 n
  s = EMPTY
  h = 0
  d = 0
  repeat with i = 1 to 32
    h = h * 2
    if n < 0 then
      h = h + 1
    end if
    n = n * 2
    d = d + 1
    if d = 8 then
      s = numToChar(h) & s
      d = 0
      h = 0
    end if
  end repeat
  return s
end
on md5final
  bits = md5encode8(md5count0) & md5encode8(md5count1)
  index = md5count0 / 8 mod 64
  if index < 56 then
    padLen = 56 - index
  else
    padLen = 120 - index
  end if
  padding = numToChar(128)
  czero = numToChar(0)
  repeat with i = 2 to padLen
    padding = padding & czero
  end repeat
  md5update(padding, padLen)
  md5update(bits, 8)
  return md5encode4(md5state0) & md5encode4(md5state1) & md5encode4(md5state2) & md5encode4(md5state3)
end
on md5init
  md5hexs = "0123456789abcdef"
  md5buffer = EMPTY
  md5count0 = 0
  md5count1 = 0
  md5state0 = md5x("67452301")
  md5state1 = md5x("efcdab89")
  md5state2 = md5x("98badcfe")
  md5state3 = md5x("10325476")
end
on md5not x
  return -x - 1
end
on md5or x, y
  r = 0
  repeat with i = 1 to 32
    r = r * 2
    if x < 0 or y < 0 then
      r = r + 1
    end if
    x = x * 2
    y = y * 2
  end repeat
  return r
end
on md5shl x, n
  return x * integer(power(2, n))
end
on md5shr x, n
  if x < 0 then
    r = 0
    n = 32 - n
    repeat with i = 1 to n
      r = r * 2
      if x < 0 then
        r = r + 1
      end if
      x = x * 2
    end repeat
  else
    m = integer(power(2, n))
    r = x / m
  end if
  return r
end
on md5rotate_left x, n
  return md5shl(x, n) + md5shr(x, 32 - n)
end
on md5transform block, i
  a = md5state0
  b = md5state1
  c = md5state2
  d = md5state3
  nc = i + 64
  md5xa = []
  repeat while i <= nc
    n = charToNum(char i of block)
    n = n + charToNum(char i + 1 of block) * 256
    n = n + charToNum(char i + 2 of block) * 65536
    n = n + charToNum(char i + 3 of block) * 16777216
    append(md5xa, n)
    i = i + 4
  end repeat
  S11 = 7
  S12 = 12
  S13 = 17
  S14 = 22
  S21 = 5
  S22 = 9
  S23 = 14
  S24 = 20
  S31 = 4
  S32 = 11
  S33 = 16
  S34 = 23
  S41 = 6
  S42 = 10
  S43 = 15
  S44 = 21
  a = md5FF(a, b, c, d, 0, S11, "d76aa478")
  d = md5FF(d, a, b, c, 1, S12, "e8c7b756")
  c = md5FF(c, d, a, b, 2, S13, "242070db")
  b = md5FF(b, c, d, a, 3, S14, "c1bdceee")
  a = md5FF(a, b, c, d, 4, S11, "f57c0faf")
  d = md5FF(d, a, b, c, 5, S12, "4787c62a")
  c = md5FF(c, d, a, b, 6, S13, "a8304613")
  b = md5FF(b, c, d, a, 7, S14, "fd469501")
  a = md5FF(a, b, c, d, 8, S11, "698098d8")
  d = md5FF(d, a, b, c, 9, S12, "8b44f7af")
  c = md5FF(c, d, a, b, 10, S13, "ffff5bb1")
  b = md5FF(b, c, d, a, 11, S14, "895cd7be")
  a = md5FF(a, b, c, d, 12, S11, "6b901122")
  d = md5FF(d, a, b, c, 13, S12, "fd987193")
  c = md5FF(c, d, a, b, 14, S13, "a679438e")
  b = md5FF(b, c, d, a, 15, S14, "49b40821")
  a = md5GG(a, b, c, d, 1, S21, "f61e2562")
  d = md5GG(d, a, b, c, 6, S22, "c040b340")
  c = md5GG(c, d, a, b, 11, S23, "265e5a51")
  b = md5GG(b, c, d, a, 0, S24, "e9b6c7aa")
  a = md5GG(a, b, c, d, 5, S21, "d62f105d")
  d = md5GG(d, a, b, c, 10, S22, "2441453")
  c = md5GG(c, d, a, b, 15, S23, "d8a1e681")
  b = md5GG(b, c, d, a, 4, S24, "e7d3fbc8")
  a = md5GG(a, b, c, d, 9, S21, "21e1cde6")
  d = md5GG(d, a, b, c, 14, S22, "c33707d6")
  c = md5GG(c, d, a, b, 3, S23, "f4d50d87")
  b = md5GG(b, c, d, a, 8, S24, "455a14ed")
  a = md5GG(a, b, c, d, 13, S21, "a9e3e905")
  d = md5GG(d, a, b, c, 2, S22, "fcefa3f8")
  c = md5GG(c, d, a, b, 7, S23, "676f02d9")
  b = md5GG(b, c, d, a, 12, S24, "8d2a4c8a")
  a = md5HH(a, b, c, d, 5, S31, "fffa3942")
  d = md5HH(d, a, b, c, 8, S32, "8771f681")
  c = md5HH(c, d, a, b, 11, S33, "6d9d6122")
  b = md5HH(b, c, d, a, 14, S34, "fde5380c")
  a = md5HH(a, b, c, d, 1, S31, "a4beea44")
  d = md5HH(d, a, b, c, 4, S32, "4bdecfa9")
  c = md5HH(c, d, a, b, 7, S33, "f6bb4b60")
  b = md5HH(b, c, d, a, 10, S34, "bebfbc70")
  a = md5HH(a, b, c, d, 13, S31, "289b7ec6")
  d = md5HH(d, a, b, c, 0, S32, "eaa127fa")
  c = md5HH(c, d, a, b, 3, S33, "d4ef3085")
  b = md5HH(b, c, d, a, 6, S34, "4881d05")
  a = md5HH(a, b, c, d, 9, S31, "d9d4d039")
  d = md5HH(d, a, b, c, 12, S32, "e6db99e5")
  c = md5HH(c, d, a, b, 15, S33, "1fa27cf8")
  b = md5HH(b, c, d, a, 2, S34, "c4ac5665")
  a = md5II(a, b, c, d, 0, S41, "f4292244")
  d = md5II(d, a, b, c, 7, S42, "432aff97")
  c = md5II(c, d, a, b, 14, S43, "ab9423a7")
  b = md5II(b, c, d, a, 5, S44, "fc93a039")
  a = md5II(a, b, c, d, 12, S41, "655b59c3")
  d = md5II(d, a, b, c, 3, S42, "8f0ccc92")
  c = md5II(c, d, a, b, 10, S43, "ffeff47d")
  b = md5II(b, c, d, a, 1, S44, "85845dd1")
  a = md5II(a, b, c, d, 8, S41, "6fa87e4f")
  d = md5II(d, a, b, c, 15, S42, "fe2ce6e0")
  c = md5II(c, d, a, b, 6, S43, "a3014314")
  b = md5II(b, c, d, a, 13, S44, "4e0811a1")
  a = md5II(a, b, c, d, 4, S41, "f7537e82")
  d = md5II(d, a, b, c, 11, S42, "bd3af235")
  c = md5II(c, d, a, b, 2, S43, "2ad7d2bb")
  b = md5II(b, c, d, a, 9, S44, "eb86d391")
  md5state0 = md5state0 + a
  md5state1 = md5state1 + b
  md5state2 = md5state2 + c
  md5state3 = md5state3 + d
end
on md5update input, inputLen
  index = md5shr(md5count0, 3) mod 64
  md5count0 = md5count0 + inputLen * 8
  if md5count0 < inputLen * 8 then
    md5count1 = md5count1 + 1
  end if
  md5count1 = md5count1 + md5shr(inputLen, 29)
  partLen = 64 - index
  if inputLen >= partLen then
    put char 1 to partLen of input into char index + 1 to index + partLen + 1 of md5buffer
    md5transform(md5buffer, 1)
    i = partLen
    repeat while i + 63 < inputLen
      md5transform(input, i + 1)
      i = i + 64
    end repeat
    index = 0
  else
    i = 0
  end if
  put char i + 1 to inputLen of input into char index + 1 to index + inputLen - i of md5buffer
end
on md5x s
  n = length(s)
  x = 0
  repeat with i = 1 to n
    c = char i of s
    if c >= "0" and c <= "9" then
      c = value(c)
    else
      c = charToNum(c)
      if c >= 65 and c <= 70 then
        c = 10 + (c - 65)
      else
        c = 10 + (c - 97)
      end if
    end if
    x = x * 16 + c
  end repeat
  return x
end
on md5xor x, y
  r = 0
  repeat with i = 1 to 32
    r = r * 2
    if x < 0 and y >= 0 or x >= 0 and y < 0 then
      r = r + 1
    end if
    x = x * 2
    y = y * 2
  end repeat
  return r
end
on dirtFilter str
  if voidp(c_dirtywords) then
    c_dirtywords = ["fuck", "ass", "cock", "cunt", "pimp", "shit", "piss", "lick", "pussy", "suck", "fuk", "vagina", "cum", "bite", "eat", "blow", "penis", "suk", "azz", "bitch", "fart", "nigg", "cok", "lik", "poontang", "twat", "clit", "phuk"]
  end if
  change = 1
  repeat while change
    change = 0
    repeat with w in c_dirtywords
      i = offset(w, str)
      if i then
        delete char i to i + length(w) - 1 of str
        put "@@@ " into char i of str
        change = 1
      end if
    end repeat
  end repeat
  return str
end
on userInfo name, email, playerId, clientData1, clientData2, clientData3, clientData4, clientData5
  c_name = name
  c_email = email
  if voidp(playerId) then
    playerId = 0
  end if
  c_playerId = playerId
  c_clientData = []
  if not voidp(clientData1) then
    c_clientData.add(clientData1)
  end if
  if not voidp(clientData2) then
    c_clientData.add(clientData2)
  end if
  if not voidp(clientData3) then
    c_clientData.add(clientData3)
  end if
  if not voidp(clientData4) then
    c_clientData.add(clientData4)
  end if
  if not voidp(clientData5) then
    c_clientData.add(clientData5)
  end if
end
on SetUserInfo
  userInfo = externalParamValue("SW3")
  if not voidp(userInfo) and userInfo <> EMPTY then
    wordCount = the number of words in userInfo
    if wordCount = 1 then
      c_playerId = userInfo
    else
      if wordCount > 1 then
        c_playerId = word 1 of userInfo
        c_name = word 2 to wordCount of userInfo
      end if
    end if
  end if
end
on SecondsSinceMidnight
  result = 0
  currentTime = the time
  if word 2 of currentTime = "pm" then
    result = 12
  end if
  hours = value(currentTime)
  if hours = 12 then
    hours = 0
  end if
  result = result + hours
  result = 3600 * result
  pos = offset(":", currentTime)
  minutes = value(chars(currentTime, pos + 1, pos + 2))
  minutes = 60 * minutes
  result = result + minutes
  return result
end
on GetCurrentDate
  sysDate = the systemDate
  result = EMPTY
  if sysDate.month < 10 then
    result = result & "0"
  end if
  result = result & string(sysDate.month) & "/"
  if sysDate.day < 10 then
    result = result & "0"
  end if
  result = result & string(sysDate.day) & "/"
  result = result & string(sysDate.year)
  return result
end
on TestSubmit
  c_playerName = EMPTY
  c_NumGames = 1
  c_NumResets = 0
  c_NumPlayers = 1
  c_DownloadSpeed = 900
  c_ElapsedTime = the ticks - 1000
  c_SubmitFlag = 1
  c_mpsession = 899
  userInfo("Vipers", "fp@foxsports.com")
  setSpecialData(string([21, 65]))
  score = [inithackv(5), inithackv(4), inithackv(6)]
  exitPoint("geth", "ercgroup", 1, score, #highScore, #geerc, EMPTY, 0, EMPTY)
end