-- Script
global outputTimer

on prepareFrame
  outputTimer = outputTimer + 1
  dontPassEvent()
end
on enterFrame
  outputTimer = outputTimer + 1
  dontPassEvent()
end
on exitFrame
  go(the frame)
  dontPassEvent()
end