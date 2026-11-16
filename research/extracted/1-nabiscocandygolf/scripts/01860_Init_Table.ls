-- Script
global Projector
global standAlone
global holeNumber
global scoreCard
global parList
global frameCtr
global frameTimer
global frameInit
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
global bricksnd
global woodsnd
global pipe1snd
global pipe2snd
global puttsnd
global swooshsnd
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
global ballPriority
global pipeTicks
global select4
global packmem
global bubmem
global bubblepic
global bubbleH
global bubbleV
global bubbleDeltaH
global bubsnd
global path1
global path2
global scorespr
global lastscorespr
global numbase
global numdigits
global textflg
global textpos
global textchar
global textkern
global textseq
global inittbl
global MAC
global tmpList

on doInitTable
  inittbl = [1, 159, 312, 175, 8, 1, 2, 158, 312, 175, 8, 1, 3, 160, 312, 175, 8, 1, 4, 161, 312, 175, 8, 1, 5, 156, 312, 175, 0, 1, 6, 171, 312, 175, 36, 1, 11, 42, 4163, 245, 36, 1, 12, 42, 4163, 245, 36, 1, 13, 42, 4163, 245, 36, 1, 14, 42, 4163, 245, 36, 1, 15, 38, 4531, 277, 8, 1, 16, 39, 4556, 332, 8, 1, 17, 40, 4572, 323, 8, 1, 18, 41, 4590, 315, 8, 1, 19, 157, 312, 175, 36, 1, 20, 169, 312, 175, 36, 1, 21, 193, 312, 175, 9, 1, 22, 173, 312, 175, 36, 1, 23, 163, 312, 175, 8, 1, 24, 38, 4531, 277, 8, 1, 25, 39, 4556, 332, 8, 1, 26, 40, 4572, 323, 8, 1, 27, 41, 4590, 315, 8, 1, 29, 29, 4219, 129, 8, 1, 30, 22, 69, 175, 8, 1, 31, 30, 11, 123, 36, 1, 32, 31, 11, 161, 36, 1, 33, 32, 11, 199, 36, 1, 34, 33, 11, 238, 36, 1, 35, 34, 15, 143, 36, 1, 36, 35, 15, 181, 36, 1, 37, 36, 15, 219, 36, 1, 38, 37, 15, 258, 36, 1, 39, 24, 37, 282, 36, 1, 40, 25, 33, 298, 36, 1, 41, 26, 34, 315, 36, 1, 42, 23, 4377, 175, 8, 1, 46, 27, 4129, 117, 8, 1, 47, 28, 4128, 113, 36, 1, 48, 14, 4001, 326, 0, 1]
  len = 6
  repeat with x = 0 to (count(inittbl) - 1) / len
    ind = x * len + 1
    spr = getAt(inittbl, ind)
    mem = getAt(inittbl, ind + 1)
    xval = getAt(inittbl, ind + 2)
    yval = getAt(inittbl, ind + 3)
    inkv = getAt(inittbl, ind + 4)
    vis = getAt(inittbl, ind + 5)
    set the memberNum of sprite spr to mem
    set the locH of sprite spr to xval
    set the locV of sprite spr to yval
    set the ink of sprite spr to inkv
    sprite(spr).visible = vis
  end repeat
end
on initPath
  path1 = [point(639, 84), point(639, 84), point(638, 83), point(637, 82), point(635, 80), point(634, 78), point(630, 74), point(628, 72), point(625, 69), point(620, 64), point(615, 60), point(607, 53), point(600, 49), point(588, 43), point(580, 39), point(575, 36), point(567, 32), point(560, 28), point(553, 25), point(549, 24), point(543, 22), point(537, 21), point(530, 20), point(520, 20), point(513, 19), point(507, 19), point(499, 19), point(489, 19), point(481, 19), point(476, 19), point(465, 19), point(460, 19), point(454, 19), point(449, 19), point(441, 19), point(437, 19), point(432, 20), point(429, 21), point(426, 22), point(424, 24), point(422, 25), point(420, 26), point(416, 28), point(411, 30), point(408, 32), point(405, 33), point(400, 36), point(398, 38), point(395, 41), point(392, 44), point(388, 47), point(387, 48), point(386, 49), point(383, 51), point(381, 53), point(378, 56), point(377, 57), point(373, 60), point(372, 61), point(371, 63), point(370, 66), point(369, 67), point(369, 69), point(368, 71), point(367, 74), point(366, 76), point(365, 78), point(364, 82), point(363, 85), point(361, 91), point(361, 98), point(359, 103), point(359, 105), point(358, 106), point(358, 108), point(357, 109), point(356, 112), point(356, 115), point(356, 121), point(356, 122), point(356, 124)]
  path2 = [point(355, 125), point(355, 126), point(353, 128), point(353, 129), point(351, 131), point(351, 132), point(350, 134), point(349, 136), point(347, 141), point(345, 148), point(344, 152), point(343, 157), point(343, 161), point(344, 165), point(346, 172), point(350, 177), point(353, 182), point(358, 187), point(364, 194), point(368, 198), point(371, 201), point(374, 205), point(377, 209), point(381, 214), point(385, 216), point(393, 219), point(397, 222), point(400, 224), point(402, 227), point(402, 227), point(402, 227), point(401, 226), point(398, 223), point(394, 220), point(390, 218), point(385, 215), point(379, 215), point(376, 215), point(375, 215), point(371, 217), point(369, 218), point(367, 219), point(364, 222), point(362, 226), point(358, 233), point(356, 238), point(356, 241), point(356, 244), point(358, 249), point(359, 253), point(359, 256), point(361, 259), point(362, 263), point(364, 266), point(368, 269), point(369, 271), point(372, 274), point(374, 277), point(378, 281), point(380, 283), point(383, 286), point(387, 290), point(390, 293), point(394, 296), point(398, 300), point(404, 306), point(408, 311), point(413, 318), point(418, 323), point(424, 327), point(430, 334), point(438, 340), point(448, 348), point(455, 354), point(461, 361), point(465, 365), point(467, 368), point(469, 369), point(469, 370), point(469, 370), point(469, 370)]
end
on rebound plyr
  wa = wallAngle
  ba = getAt(ballAngle, plyr)
  incidence = acute(circ(ba - 180) - wa)
  if wa < 180 then
    if ba > wa and ba < wa + 180 then
      return 0
    end if
  else
    if ba < wa and ba > wa - 180 then
    else
      return 0
    end if
  end if
  if wa = ba or circ(wa + 180) = ba then
    ahit = 1
    return 0
  end if
  Ref = circ(wa + 180)
  refract = incidence
  mag = getAt(ballMagnitude, plyr)
  setAt(ballAngle, plyr, circ(Ref - refract))
  wood = 0.6
  brick = 0.9
  dead = 0.1
  case elasticity of
    1, 2, 3:
      mlt = absorb(wood, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)
    4:
      mlt = absorb(brick, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(bricksnd, vol, 2)
    5:
      mlt = absorb(dead, plyr, Ref, incidence)
      vol = mlt * mag * 20
      playSound(woodsnd, vol, 2)

  end case
  return 1
end
on makePath
  tmpList = []
  repeat while not the optionDown
  end repeat
  repeat while the optionDown
    pt = point(the mouseH, the mouseV)
    tmp = the ticks
    showspr(8, 179, the mouseH, the mouseV, 36)
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