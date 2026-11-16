-- Behavior
on CalAngfmPT pt1, pt2
  ang = computang(pt1[1], pt1[2], pt2[1], pt2[2])
  return ang
end
on computang h1, v1, h2, v2
  dV = float(v2 - v1)
  dH = float(h1 - h2)
  if dH <> 0 then
    ang = atan(abs(dV) / abs(dH)) * 180.0 / PI
  else
    ang = 90.0
  end if
  if dH >= 0 and dV < 0 then
    ang = 180 - ang
  end if
  if dH >= 0 and dV >= 0 then
    ang = 180 + ang
  end if
  if dH < 0 and dV > 0 then
    ang = 360 - ang
  end if
  return ang
end
on cal_slope x1, y1, x2, y2
  result = [0.0, 0.0, 0]
  dx = float(x2 - x1)
  if dx = 0 then
    return result
  end if
  m = float(y2 - y1) / float(x2 - x1)
  b = y2 - m * x2
  result = [m, b, 1]
  return result
end
on solve x1, x2, y1, y2, x3, x4, y3, y4
  result1 = dslope(x1, x2, y1, y2)
  result2 = dslope(x3, x4, y3, y4)
  if result1[3] = 1 and result1[3] = 1 then
    bx = result1[1] - result2[1]
    if bx <> 0 then
      xf = (result2[2] - result1[2]) / bx
      if xf < 296 or xf > 317 then
        return 0
      end if
      if xf < x3 and xf >= x4 then
        return 1
      end if
      if xf >= x3 and xf < x4 then
        return 1
      end if
      return 0
      yf = xf * result1[1] + result1[2]
    else
      return 0
    end if
  else
    return 0
  end if
end
on getquad ang
  if ang > 0 and ang <= 90 then
    quad = 1
  end if
  if ang > 90 and ang <= 180 then
    quad = 2
  end if
  if ang > 180 and ang <= 270 then
    quad = 3
  end if
  if ang > 270 and ang < 360 then
    quad = 4
  end if
  return quad
end