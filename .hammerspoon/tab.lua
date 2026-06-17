-- App launcher using Tab as a prefix key.
--
-- A regular hs.hotkey.bind({"tab"}, "s", ...) will not work here,
-- because Tab is not a modifier key. Hammerspoon only treats keys like
-- cmd, alt, ctrl, shift, and fn as modifiers.
--
-- This uses a temporary modal instead:
--   Tab, then S -> Slack
--   Tab alone   -> sends a normal Tab after a short timeout
local tabApps = {
  s = "Safari",
  a = "Slack",
  w = "Webex",
  m = "Mail",
  n = "Notes",
  b = "Brave Browser",
  g = "Ghostty",
  p = "System Settings",
  f = "Finder",
  c = "Codex",
  v = "Visual Studio Code",
}

local tabModal = hs.hotkey.modal.new()

for key, app in pairs(tabApps) do
  tabModal:bind({}, key, function()
    tabModal:exit()
    hs.application.launchOrFocus(app)
  end)
end

local tabTimer = nil

hs.hotkey.bind({}, "tab", function()
  tabModal:enter()

  if tabTimer then
    tabTimer:stop()
  end

  tabTimer = hs.timer.doAfter(0.8, function()
    tabModal:exit()
    hs.eventtap.keyStroke({}, "tab", 0)
  end)
end)
