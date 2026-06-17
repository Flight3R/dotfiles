-- Microphone mute controller for Hammerspoon.
--
-- Adds a menu bar indicator showing the current input mute state:
--   "Mute" -> microphone is muted
--   "AIR"  -> microphone is live
--
-- The menu bar item can be clicked to toggle mute silently.
-- The keyboard shortcut Cmd+Shift+A also toggles mute, but shows an alert
-- so the state change is obvious while typing or during calls.
--
-- Note: this controls the current default input device. If macOS switches
-- microphones, the next toggle/status refresh will use the new default input.
local menu = hs.menubar.new()
local displayedMuteState = nil
micMute = micMute or {}

if micMute.refreshTimer then
  micMute.refreshTimer:stop()
  micMute.refreshTimer = nil
end

local function styled(text, font, size, color)
    return hs.styledtext.new(text, {
        color = color,
        font = { name = font, size = size }
    })
end

local function setMuteDisplay(mute)
  if displayedMuteState == mute then
    return
  end

  displayedMuteState = mute

  if muteAlertId then
    hs.alert.closeSpecific(muteAlertId)
  end

  if mute then
    menu:setTitle(styled("Mute", "Menlo", 13, hs.drawing.color.gray))
    muteAlertId = hs.alert.show(styled("Microphone muted", nil, 22, hs.drawing.color.white))
  else
    menu:setTitle(styled("AIR ", "Menlo", 13, hs.drawing.color.red))
    muteAlertId = hs.alert.show(styled("Microphone on", nil, 22, hs.drawing.color.red))
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

local function refreshMuteDisplay()
  setMuteDisplay(getMuteState())
end

local function toggleMuteIcon()
  setMute(not getMuteState())
end

local function toggleMuteKey()
  local muted = getMuteState()
  local muting = not muted
  setMute(muting)
end

hs.hotkey.bind({"cmd", "shift"}, "a", nil, toggleMuteKey, nil)

if menu then
  menu:setClickCallback(toggleMuteIcon)
  refreshMuteDisplay()
  micMute.refreshTimer = hs.timer.doEvery(1, refreshMuteDisplay)
end
