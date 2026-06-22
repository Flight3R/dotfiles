local apps = {
    s = "Safari",
    c = "Calendar",
    a = "Slack",
    w = "Webex",
    m = "Mail",
    n = "Notes",
    b = "Brave Browser",
    g = "Ghostty",
    p = "System Settings",
    f = "Finder",
    x = "Codex",
    v = "Visual Studio Code",
}

for key, app in pairs(apps) do
    hs.hotkey.bind({ "ctrl", "cmd" }, key, function()
        hs.application.launchOrFocus(app)
    end)
end
