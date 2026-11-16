-- Script
on prepareFrame
  stopEvent()
end
on enterFrame
  stopEvent()
end
on exitFrame
  go(the frame)
  stopEvent()
end
on mouseDown
  stopEvent()
end
on mouseUp
  stopEvent()
end
on keyDown
  stopEvent()
end
on keyUp
  stopEvent()
end