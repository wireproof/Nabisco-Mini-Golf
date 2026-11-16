-- Behavior
global player
global numPlayers
global playerType
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
global scoreCardFlag
global helpFlag
global obstacleTimer
global g_numPlayers
global g_playerstatus
global playerGender
global putterBaseBoy
global putterBaseGirl
global lineText
global historymem
global historyText
global g_again
global g_chatok
global g_multi
global g_multiInit
global g_vote
global g_mprcv
global g_mpxmit
global g_checkpoint
global g_checkPointStatus
global g_myPlayerNumber

on send_MP_turn
  if g_multi then
    buf = "[" & mpListCompress(turnControlMemory) & "," & mpListCompress(turnMemory1) & "," & mpListCompress(turnMemory2) & "," & mpListCompress(turnMemory3) & "," & mpListCompress(turnMemory4) & "]"
    mpSendData(buf)
  end if
end
on wait_MP_Update
  p = mpGetDataFrom(player)
  if not voidp(p) then
    pl = value(p[1])
    if not voidp(pl) then
      if count(pl) >= 5 then
        turnControlMemory = mpListExpand(pl[1])
        turnMemory1 = mpListExpand(pl[2])
        turnMemory2 = mpListExpand(pl[3])
        turnMemory3 = mpListExpand(pl[4])
        turnMemory4 = mpListExpand(pl[5])
        playbackState = #start
        playbackFlag = 1
        if scoreCardFlag then
          displayScore(0)
        else
          if helpFlag then
            displayHelp(0)
          end if
        end if
      end if
    else
      if count(p) = 3 then
        g_playerstatus[player][1] = p[1]
        g_playerstatus[player][2] = p[3]
        g_vote[player] = p[2]
        if p[2] = 0 and playerType[player] = #remote then
          PlayerDropped(player)
          mpKillHim(player)
          nextShot(1)
        end if
      end if
    end if
  else
    if not mpPlayerIsConnected(player) then
      PlayerDropped(player)
      nextShot(1)
    end if
  end if
end
on send_MP_message
  mpChatSend(lineText)
end
on PlayerDropped plyr
  if plyr > 0 and plyr <= numPlayers then
    mpChatReceive(plyr, "> PLAYER DROPPED <")
    playerType[plyr] = #dropped
    setState(plyr, #shelf)
    currentScreen = -4
    g_playerstatus[plyr] = [EMPTY, 1]
    g_vote[plyr] = 0
    m = member("Player Names").memberNum + plyr - 1
    member(m).text = EMPTY
  end if
end
on mpChatReceive plyr, chatText
  if g_multi then
    if plyr > 0 then
      mem = the number of member "Player Names"
      mem = mem + plyr - 1
      str = member(mem).text
      str = str & ": " & chatText
    end if
    historyText = historyText & str & RETURN
    if the number of lines in historyText > 5 then
      delete line 1 of historyText
    end if
    member(historymem).text = historyText
  end if
end
on mpChatSend chatText
  if g_multi and g_chatok then
    if chatText <> EMPTY then
      append(g_mpxmit, chatText)
      g_myPlayerNumber = mpGetPlayerNumber()
      mpChatReceive(g_myPlayerNumber, chatText)
    end if
  else
    mpChatReceive(0, "Chat is not available in this game.")
  end if
end
on mpThread
  if g_multi then
    mpCommunicate()
    g_myPlayerNumber = mpGetPlayerNumber()
    if g_myPlayerNumber > 0 then
      repeat with i = 1 to numPlayers
        if i <> g_myPlayerNumber then
          s = mpGetHisGameData(i)
          if s <> 0 then
            if stringp(s) then
              mpChatReceive(i, s)
              next repeat
            end if
            append(g_mprcv[i], s)
          end if
        end if
      end repeat
      if count(g_mpxmit) <> 0 then
        if mpAllReceived() then
          mpSendMyGameData(g_mpxmit[1])
          deleteAt(g_mpxmit, 1)
        end if
      end if
    else
      g_myPlayerNumber = 1
    end if
  end if
end
on mpPopReceiveQueue playerNum
  result = VOID
  if g_multi then
    if playerNum > 0 and playerNum <= numPlayers then
      result = g_mprcv[playerNum][1]
      deleteAt(g_mprcv[playerNum], 1)
    end if
  end if
  return result
end
on mpAppendToReceiveQueue playerNum, data
  if playerNum > 0 and playerNum <= count(g_mprcv) then
    if stringp(data) then
      mpChatReceive(playerNum, data)
    else
      append(g_mprcv[playerNum], data)
    end if
  end if
end
on mpReceiveQueueCount playerNum
  result = 0
  if g_multi then
    if playerNum = 0 then
      repeat with i = 1 to count(g_mprcv)
        result = result + count(g_mprcv[i])
      end repeat
    else
      if playerNum > 0 and playerNum <= numPlayers then
        result = count(g_mprcv[playerNum])
      end if
    end if
  end if
  return result
end
on mpSendData data
  if count(g_mpxmit) > 5 then
    put "Send queue is not sending!!!!!!!!!!"
  end if
  if not listp(data) then
    data = [data]
  end if
  g_mpxmit.add(data)
end
on mpStart numberOfPlayers, chatOK
  if voidp(g_multiInit) or not g_multiInit then
    if voidp(g_multi) then
      g_multi = 0
    end if
    if voidp(numberOfPlayers) then
      numberOfPlayers = 4
    end if
    if voidp(chatOK) then
      chatOK = 1
    end if
    mpCallbackOn()
    g_checkpoint = VOID
    g_again = VOID
    g_chatok = chatOK
    g_mprcv = []
    g_mpxmit = []
    repeat with i = 1 to numberOfPlayers
      g_mprcv[i] = []
    end repeat
    g_multiInit = 1
  else
    mpCallbackOn()
  end if
end
on mpStop
  if g_multi then
    if g_again then
      mpCallbackOff()
      mpGo("pmgfload")
    else
      mpQuitGameGroup()
    end if
  else
    if g_again then
      mpGo("pmgfload")
    end if
  end if
end
on mpNewGame
  if g_multi then
    g_again = 1
    mpQuitGameGroup()
    g_myPlayerNumber = 0
    g_multi = 0
    mpGo("pmgfload")
  end if
end
on mpPlayerNum
  if g_multi then
    g_myPlayerNumber = mpGetPlayerNumber()
    return g_myPlayerNumber
  else
    return 1
  end if
end
on mpWaitForCheckpoint checkNum
  result = 0
  if g_multi then
    g_myPlayerNumber = mpGetPlayerNumber()
    if g_checkpoint = VOID then
      mpSendData([3, checkNum])
      g_checkpoint = checkNum
      g_checkPointStatus = []
      repeat with i = 1 to numPlayers
        if i = g_myPlayerNumber then
          g_checkPointStatus[i] = 1
          next repeat
        end if
        g_checkPointStatus[i] = 0
      end repeat
    else
      repeat with p = 1 to numPlayers
        if p <> g_myPlayerNumber then
          if mpPlayerIsConnected(p) then
            put "Looking for checkpoint, got " & string(g_mprcv)
            repeat while count(g_mprcv[p]) > 0
              datalist = g_mprcv[p][1]
              deleteAt(g_mprcv[p], 1)
              if listp(datalist) then
                if datalist[1] = 3 then
                  g_checkPointStatus[p] = 1
                  exit repeat
                end if
                next repeat
              end if
              if datalist = 3 then
                g_checkPointStatus[p] = 1
                exit repeat
              end if
            end repeat
            next repeat
          end if
          g_checkPointStatus[p] = 1
        end if
      end repeat
      if getPos(g_checkPointStatus, 0) = 0 then
        result = 1
        g_checkpoint = VOID
        g_checkPointStatus = []
      end if
    end if
  else
    result = 1
  end if
  return result
end
on mpGetDataFrom p
  result = VOID
  if g_multi then
    g_myPlayerNumber = mpGetPlayerNumber()
    if p <> g_myPlayerNumber then
      if count(g_mprcv[p]) > 0 then
        result = g_mprcv[p][1]
        deleteAt(g_mprcv[p], 1)
      end if
    end if
  end if
  return result
end
on mpListCompress l1
  result = "["
  len = count(l1)
  repeat with i = 1 to len
    if symbolp(l1[i]) then
      result = result & compressSymbol(l1[i])
    else
      result = result & string(l1[i])
    end if
    if i < len then
      result = result & ","
    end if
  end repeat
  return result & "]"
end
on mpListExpand l1
  len = count(l1)
  repeat with i = 1 to len
    if symbolp(l1[i]) then
      l1[i] = expandSymbol(l1[i])
    end if
  end repeat
  return l1
end
on compressSymbol s
  case s of
    #aim:
      result = "#a"
    #moveball:
      result = "#b"
    #cup:
      result = "#c"
    #inObstacle:
      result = "#d"
    #loadDone:
      result = "#e"
    #initHole:
      result = "#f"
    #swing:
      result = "#g"
    #inHole:
      result = "#h"
    #drain:
      result = "#i"
    #behindRocket:
      result = "#j"
    #rocket:
      result = "#k"
    #placeball:
      result = "#l"
    #holeLoading:
      result = "#m"
    #bounce:
      result = "#n"
    #gameover:
      result = "#o"
    #inPipe:
      result = "#p"
    #quitting:
      result = "#q"
    #rattle:
      result = "#r"
    #shelf:
      result = "#s"
    #waiting:
      result = "#t"
    #drawback:
      result = "#u"
    #waitRelease:
      result = "#v"
    #wheel:
      result = "#w"
    #nextHole:
      result = "#x"
    #waitPlayback:
      result = "#y"
    #testload:
      result = "#z"
    otherwise:
      put "Unhandled symbol #" & s
      result = "##"

  end case
  return result
end
on expandSymbol s
  case s of
    #a:
      result = #aim
    #b:
      result = #moveball
    #c:
      result = #cup
    #d:
      result = #inObstacle
    #e:
      result = #loadDone
    #f:
      result = #initHole
    #g:
      result = #swing
    #h:
      result = #inHole
    #i:
      result = #drain
    #j:
      result = #behindRocket
    #k:
      result = #rocket
    #l:
      result = #placeball
    #m:
      result = #holeLoading
    #n:
      result = #bounce
    #o:
      result = #gameover
    #p:
      result = #inPipe
    #q:
      result = #quitting
    #r:
      result = #rattle
    #s:
      result = #shelf
    #t:
      result = #waiting
    #u:
      result = #drawback
    #v:
      result = #waitRelease
    #w:
      result = #wheel
    #x:
      result = #nextHole
    #y:
      result = #waitPlayback
    #z:
      result = #testload
    otherwise:
      put "Unhandled symbol #" & s
      result = #XXX

  end case
  return result
end