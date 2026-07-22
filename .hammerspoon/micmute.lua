local width, height = 92, 34
local screen = hs.screen.mainScreen():fullFrame()
local menu = hs.menubar.new()
local banner = hs.canvas.new({
  x = screen.x + (screen.w - width) / 2,
  y = screen.y + screen.h - height,
  w = width,
  h = height
})

banner:appendElements(
  { type = "rectangle", action = "fill", roundedRectRadii = { xRadius = 8, yRadius = 8 } },
  { type = "text", textAlignment = "center", textFont = "Menlo", textSize = 20,
    frame = { x = 0, y = 5, w = width, h = 24 } }
):level("overlay"):behavior({ "canJoinAllSpaces", "stationary", "ignoresCycle" })

local function update()
  local mic = hs.audiodevice.defaultInputDevice()
  local muted = mic:inputMuted()
  banner[1].fillColor = muted and { white = 0.12, alpha = 0.45 }
    or { red = 1, alpha = 0.45 }
  banner[2].text = muted and "Mute" or "MIC"
  banner[2].textColor = muted and hs.drawing.color.gray or hs.drawing.color.white
  if mic:inUse() then banner:show() else banner:hide() end

  local style = {
    color = muted and hs.drawing.color.black or hs.drawing.color.white,
    font = { name = "Menlo", size = 14 }
  }
  if not muted then style.backgroundColor = hs.drawing.color.red end
  menu:setTitle(hs.styledtext.new(muted and "Mute" or " MIC ", style))
end

local function toggle()
  local mic = hs.audiodevice.defaultInputDevice()
  mic:setInputMuted(not mic:inputMuted())
  update()
end

update()
hs.hotkey.bind({ "ctrl", "cmd" }, "a", toggle)
menu:setClickCallback(toggle)
micMute = hs.timer.doEvery(1, update)
