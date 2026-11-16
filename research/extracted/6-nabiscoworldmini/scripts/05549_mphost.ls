-- Behavior
global mpConnected
global mpData
global mpMux
global mpNplayersMax
global mpNstart
global mpPlayer
global mpPlayerData
global mpPort
global mpRandomSeed
global mpReceived
global mpSendCmd
global mpSendArg
global mpSession
global mpStateAck
global mpStateHost
global mpStateLocal
global mpTimer
global mpTimePoll
global mpTimeWait
global mpUrl
global mpWaiting

on mpAllReceived
  if mpPlayer = 0 then
    return 1
  end if
  result = 0
  if mpStateAck = "1" then
    if getAt(mpStateLocal, mpPlayer) = getAt(mpStateHost, mpPlayer) then
      result = 1
    end if
  end if
  if not result then
    mpTimeWait = mpTimePoll
  end if
  return result
end
on mpCallbackOn
  if mpMux <> VOID then
    SetNetMessageHandler(mpMux, #mpMuxCallback, script("mphost"))
  end if
end
on mpCallbackOff
  if mpMux <> VOID then
    SetNetMessageHandler(mpMux, 0, 0)
    mpConnected = 0
  end if
end
on mpCommunicate
  if mpWaiting then
    if not voidp(mpReceived) then
      n = offset(numToChar(10), mpReceived)
      if n <> 0 then
        if n = length(mpReceived) then
          m = mpReceived
          mpReceived = VOID
        else
          m = chars(mpReceived, 1, n)
          delete char 1 to n of mpReceived
        end if
        mpWaiting = 0
        w = word 1 of m
        if w = "status" then
          mpSendCmd = VOID
          n = the number of words in m
          if n = 1 then
            mpPlayer = 0
          else
            do("set mpStateHost = [" & word 2 of m & "]")
            mpStateAck = word 3 of m
            do("set mpData = [" & word 4 to n of m & "]")
          end if
        else
          if w = "join" then
            mpSendCmd = VOID
            mpSession = word 2 of m
            mpPlayer = value(word 3 of m)
            setAt(mpStateLocal, mpPlayer, 1)
            setAt(mpStateHost, mpPlayer, 1)
            mpNstart = value(word 4 of m)
            mpRandomSeed = value(mpSession)
          else
            if w = "x" then
              mpConnected = 0
              if stringp(mpSendCmd) then
                mpSend(mpSendCmd, mpSendArg)
              end if
            end if
          end if
        end if
        return 1
      end if
    end if
  else
    if mpPlayer then
      t = the ticks - mpTimer
      if t >= mpTimeWait or t < 0 then
        s = string(getAt(mpStateLocal, 1))
        repeat with i = 2 to mpNplayersMax
          s = s & "," & getAt(mpStateLocal, i)
        end repeat
        state = getAt(mpStateLocal, mpPlayer)
        if getAt(mpStateLocal, mpPlayer) <> getAt(mpStateHost, mpPlayer) then
          s = s && mpPlayerData
        else
          s = s & " void"
        end if
        mpSend("status", s)
        mpTimer = the ticks
        mpTimeWait = 60 * 60
      end if
    end if
  end if
  return 0
end
on mpConnect
  if mpMuxCheck(ConnectToNetServer(mpMux, "user", "password", mpUrl, mpPort, "mphost", 1)) then
    mpWaiting = 1
  end if
end
on mpGetHisGameData player
  if not mpPlayer then
    return VOID
  end if
  if player = mpPlayer then
    return value(mpPlayerData)
  end if
  state = getAt(mpStateHost, player)
  if getAt(mpStateLocal, player) <> state then
    setAt(mpStateLocal, player, state)
    mpTimeWait = 0
    return getAt(mpData, player)
  else
    mpTimeWait = mpTimePoll
    return VOID
  end if
end
on mpGetPlayerNumber
  return mpPlayer
end
on mpGetSessionNumber
  if voidp(mpSession) then
    mpSession = 0
  end if
  return mpSession
end
on mpGo movie
  if the runMode contains "Plugin" then
    gotoNetMovie(movie & ".dcr")
  else
    go(1, movie & ".dir")
  end if
end
on mpJoined
  n = 0
  if mpNplayersMax then
    repeat with i = 1 to mpNplayersMax
      if getAt(mpStateLocal, i) <> 0 then
        n = n + 1
      end if
    end repeat
  end if
  return n
end
on mpJoinGameGroup hostUrl, gamename, nplayers, password
  mpNplayersMax = nplayers
  mpPlayerData = VOID
  mpWaiting = 0
  mpTimer = the ticks
  mpTimePoll = 2 * 60
  mpTimeWait = mpTimePoll
  mpPort = 443
  mpUrl = hostUrl
  mpData = []
  mpStateLocal = []
  mpStateHost = []
  repeat with i = 1 to nplayers
    append(mpData, VOID)
    append(mpStateLocal, 0)
    append(mpStateHost, 0)
  end repeat
  if not mpPlayer then
    mpPlayer = 0
    mpSession = 0
  end if
  if not mpMux then
    mpMux = new(xtra("Multiuser"))
    if voidp(mpMux) then
      alert("Cannot find Multiuser Xtra")
    end if
    mpConnected = 0
  end if
  if not mpConnected then
    mpCallbackOn()
    mpConnect()
  end if
  mpSend("join", gamename && nplayers && password)
  mpPlayer = 0
  mpSession = 0
end
on mpKillHim player
  mpSend("quit", player)
end
on mpMuxCallback
  pl = GetNetMessage(mpMux)
  err = pl.errorCode
  if err = 0 then
    if pl.subject = "String" then
      if voidp(mpReceived) then
        mpReceived = pl.content
      else
        mpReceived = mpReceived & pl.content
      end if
      mpWaiting = 1
    else
      if pl.subject = "ConnectToNetServer" then
        mpConnected = 1
        mpWaiting = 0
        if not voidp(mpSendCmd) then
          mpSend(mpSendCmd, mpSendArg)
          mpSendCmd = VOID
        end if
      end if
    end if
  else
    if err = -2147216214 then
      mpConnected = 0
      mpConnect()
    else
      alert("MuxCallback:" && GetNetErrorString(mpMux, err) & RETURN & mpSendCmd & RETURN & pl)
    end if
  end if
end
on mpMuxCheck err
  if err then
    alert("MuxCheck:" && GetNetErrorString(mpMux, err))
    return 0
  else
    return 1
  end if
end
on mpNoNewPlayers
  mpSend("close")
end
on mpPlayerIsConnected player
  if mpPlayer then
    mpTimeWait = mpTimePoll
    return getAt(mpStateHost, player) <> 0
  else
    return 0
  end if
end
on mpQuitGameGroup
  if mpPlayer then
    mpSend("quit", mpPlayer)
    mpPlayer = 0
    mpCallbackOff()
  end if
end
on mpRandom n
  oldseed = the randomSeed
  the randomSeed = mpRandomSeed
  n = random(n)
  mpRandomSeed = the randomSeed
  the randomSeed = oldseed
end
on mpSend cmd, arg
  mpSendCmd = cmd
  mpSendArg = arg
  if mpConnected then
    err = SendNetMessage(mpMux, "System", "subject", cmd && mpSession && mpPlayer && arg & RETURN)
    if err = -2147216214 then
      mpConnected = 0
    else
      if mpMuxCheck(err) then
        mpWaiting = 1
      end if
    end if
  end if
  if not mpConnected then
    if not mpWaiting then
      mpConnect()
    end if
  end if
end
on mpSendMyGameData data
  if not mpPlayer then
    exit
  end if
  if stringp(data) then
    data = QUOTE & data & QUOTE
  else
    data = string(data)
  end if
  mpPlayerData = data
  state = getAt(mpStateLocal, mpPlayer) + 1
  if state = 0 then
    state = state + 1
  end if
  setAt(mpStateLocal, mpPlayer, state)
  mpStateAck = "0"
  mpTimeWait = 0
end
on mpSendMyGameDataIfDifferent data
  if stringp(data) then
    if QUOTE & data & QUOTE <> mpPlayerData then
      mpSendMyGameData(data)
    end if
  else
    if string(data) <> mpPlayerData then
      mpSendMyGameData(data)
    end if
  end if
end
on mpSetPollTime secs
  mpTimePoll = secs * 60
end
on mpPlayerDropped p
  setAt(mpStateLocal, p, 0)
end