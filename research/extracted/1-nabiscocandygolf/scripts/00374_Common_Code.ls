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
global name
global email
global cumScore

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
  inithackerprotect()
  if the runMode contains "Plugin" then
    set the exitLock to 1
  end if
  c_SubmitFlag = 1
  c_NumGames = 1
  c_NumPlayers = 1
  c_NumResets = 0
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
    c_ElapsedTime = the ticks
  end if
  inithackerprotect()
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
on reportScore NAMECODE, namefull, playernumber, ascore, gametype, client, mpSession, MD5, md5key
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
  gamnam = NAMECODE
  pnum = playernumber
  st3 = "no_client_specified"
  if client = #nabisco or client = #foxSports then
    str = "gamename=" & gamnam
    str = str & "&score" & string(pnum) & "=" & string(hightmp)
    str = str & "&code" & string(pnum) & "=" & CODE
    str = str & "&sf" & "=" & string(c_SubmitFlag)
    str = str & "&np" & "=" & string(c_NumPlayers)
    str = str & "&ng" & "=" & string(c_NumGames)
    str = str & "&nr" & "=" & string(c_NumResets)
    data = int((the ticks - c_ElapsedTime) / 60)
    str = str & "&tp" & "=" & string(data)
    data = testPerformance()
    str = str & "&ms" & "=" & string(data)
    str = str & "&mr" & "=" & the memorysize
    str = str & "&bd" & "=" & the colorDepth
    str = str & "&pi" & "=" & string(version)
    str = str & "&ds" & "=" & string(c_DownloadSpeed)
    str = str & "&sn" & "=" & c_mpsession
    str = str & "&dt=" & the date
    dtlst = the desktopRectList
    if count(dtlst) >= 1 then
      r1 = getAt(dtlst, 1)
    else
      r1 = rect(0, 0, 0, 0)
    end if
    str = str & "&ss" & "=" & string(r1.width) & "by" & string(r1.height)
    data = "none"
    str = str & "&sp" & "=" & string(data)
    str = str & "&tt=" & string(the ticks mod 86400)
    if MD5 then
      str4 = MD5(str & "&" & string(md5key))
      str = str & "&" & str4
    end if
    if client = #foxSports then
      dest = externalParamValue("sw1")
    else
      dest = externalParamValue("sw4")
      if voidp(dest) or length(dest) < 1 then
        dest = "/asp/leader.asp"
      end if
    end if
    str3 = dest & "?param=" & scramble(str, randList(random(32)))
    if the runMode contains "Author" then
      put dest & "?param=" & str
    end if
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
          str1 = c_dest & "fdmcscore.pl?param="
          str4 = "gamename=" & gamnam
          str4 = str4 & "&datetime" & "=" & timeStamp()
          str4 = str4 & "&name" & string(pnum) & "=" & string(name)
          str4 = str4 & "&email" & string(pnum) & "=" & lowercase(string(email))
          str4 = str4 & "&score" & string(pnum) & "=" & string(hightmp)
          str4 = str4 & "&code" & string(pnum) & "=" & CODE
          enflag = externalParamValue("sw4")
          if enflag = 0 then
            str3 = str1 & str4
          else
            str3 = str1 & scramble(str4, randList(random(32)))
          end if
        else
          str3 = c_dest & "fdmcscore.pl"
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
    str1 = " V" & month & day
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
      cH = "%20"
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
on inithackerprotect
  c_hackrandom = 5000 + random(5000)
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
  txt = "Member:" && the member of sprite spriteNum
  if sprite(spriteNum).memberNum <> 0 then
    txt = txt && "(Type is " & member(sprite(spriteNum).memberNum).type & ")"
  end if
  put txt
  put "Editable:" && the editableText of sprite spriteNum
  put "Visible:" && sprite(spriteNum).visible
  put "puppet:" && the puppet of sprite spriteNum
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
on scramTest
  cumScore = 900
  screenName = "Billy Bob"
  timesPlayed = 1
  put reportScore()
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
on TestSubmit
  c_playerName = EMPTY
  c_NumGames = 1
  c_NumResets = 0
  c_NumPlayers = 1
  c_DownloadSpeed = 900
  c_ElapsedTime = the ticks - 1000
  c_SubmitFlag = 1
  score = inithackv(18)
  exitPoint("nwmg", "ragsdakota", 1, score, #lowscore, #nabisco, EMPTY, 0, EMPTY)
end