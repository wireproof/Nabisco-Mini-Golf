-- Script
global scoreCardFlag
global cardspr
global loading

on mouseUp
  if the frame >= 10 then
    if loading = 0 then
      scoreCardFlag = 0
      hidecard()
      dontPassEvent()
    end if
  end if
end