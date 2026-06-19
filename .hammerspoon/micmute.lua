local menu = hs.menubar.new()
local displayedMuteState = nil
micMute = micMute or {}

if micMute.refreshTimer then
  micMute.refreshTimer:stop()
  micMute.refreshTimer = nil
end

local function styled(text, font, size, color, bgcolor)
    return hs.styledtext.new(text, {
        color = color,
        font = { name = font, size = size },
        backgroundColor = bgcolor
    })
end

local function setMuteDisplay(mute)
  if displayedMuteState == mute then
    return
  end

  displayedMuteState = mute

  if mute then
    menu:setTitle(styled("Mute", "Menlo", 14, hs.drawing.color.gray, nil))
  else
    menu:setTitle(styled(" MIC ", "Menlo", 14, hs.drawing.color.white, hs.drawing.color.red))
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

local function toggleMute()
  setMute(not getMuteState())
end

hs.hotkey.bind({"cmd", "shift"}, "a", toggleMute)

if menu then
  menu:setClickCallback(toggleMute)
  refreshMuteDisplay()
  micMute.refreshTimer = hs.timer.doEvery(1, refreshMuteDisplay)
end

