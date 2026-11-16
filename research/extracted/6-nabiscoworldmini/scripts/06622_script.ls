-- Script
global scoreCardFlag
global cardspr
global loading
global catchsnd
global effectsChannel

on mouseUp
  if the frame >= 5 then
    if loading = 0 then
      hidecard()
      playSound(catchsnd, 255, effectsChannel)
      dontPassEvent()
    end if
  end if
end