-- A better push to talk / toggle mute
local shouldCaffeinate = false
local muteMenu = hs.menubar.new()

local function styled(text, size, color)
    return hs.styledtext.new(text, {
        color = color,
        font = { name = "Menlo", size = size }
    })
end

local function setMuteDisplay(mute)
  if mute then
    muteMenu:setTitle(styled("Mute", 14, hs.drawing.color.gray))
  else
    muteMenu:setTitle(styled("AIR", 14, hs.drawing.color.red))
  end
end

local function clearMuteAlert()
  if muteAlertId then
    hs.alert.closeSpecific(muteAlertId)
  end
end

local function setMute(mute)
  local audio = hs.audiodevice.defaultInputDevice()
  audio:setInputMuted(mute)
  setMuteDisplay(mute)
end

local function getMuteState()
  local audio = hs.audiodevice.defaultInputDevice()
  return audio:inputMuted()
end

local holdingToTalk = false
local function pushToTalk()
  holdingToTalk = true
  local audio = hs.audiodevice.defaultInputDevice()

  if muted then
    clearMuteAlert()
    muteAlertId = hs.alert.show(styled("PTT", 26, hs.drawing.color.white), true)
    setMute(false)
  end
end

local function toggleMute()
  setMute(not getMuteState())
end

local function toggleMuteOrPTT()
  local muted = getMuteState()
  local muting = not muted
  if holdingToTalk then
    holdingToTalk = false
    setMute(true)
    muting = true
  else
    setMute(muting)
  end
  clearMuteAlert()
  if muting then
    muteAlertId = hs.alert.show(styled("Mute", 26, hs.drawing.color.white))
  else
    muteAlertId = hs.alert.show(styled("AIR", 26, hs.drawing.color.red))
  end
end

hs.hotkey.bind({"cmd", "shift"}, "a", nil, toggleMuteOrPTT, pushToTalk)

if muteMenu then
  muteMenu:setClickCallback(toggleMute)
  local muted = getMuteState()
  setMuteDisplay(muted)
end
