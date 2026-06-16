local menu = hs.menubar.new()

local function styled(text, size, color)
    return hs.styledtext.new(text, {
        color = color,
        font = { name = "Menlo", size = size }
    })
end

local function setMuteDisplay(mute)
  if mute then
    menu:setTitle(styled("Mute", 13, hs.drawing.color.gray))
  else
    menu:setTitle(styled("AIR ", 13, hs.drawing.color.red))
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

local function toggleMuteIcon()
  setMute(not getMuteState())
end

local function toggleMuteKey()
  local muted = getMuteState()
  local muting = not muted
  setMute(muting)
  if muteAlertId then
    hs.alert.closeSpecific(muteAlertId)
  end
  if muting then
    muteAlertId = hs.alert.show(styled("Microphone muted", 20, hs.drawing.color.white))
  else
    muteAlertId = hs.alert.show(styled("Microphone on", 20, hs.drawing.color.red))
  end
end

hs.hotkey.bind({"cmd", "shift"}, "a", nil, toggleMuteKey, nil)

if menu then
  menu:setClickCallback(toggleMuteIcon)
  local muted = getMuteState()
  setMuteDisplay(muted)
end
