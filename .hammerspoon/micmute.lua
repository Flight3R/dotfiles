local width, height = 92, 34

local menu = hs.menubar.new()
local banner = hs.canvas.new({ x = 0, y = 0, w = width, h = height })

banner:appendElements(
    {
        type = "rectangle",
        action = "fill",
        roundedRectRadii = { xRadius = 8, yRadius = 8 }
    },
    {
        type = "text",
        textAlignment = "center",
        frame = { x = 0, y = 5, w = width, h = 24 }
    }
):level("overlay"):behavior({ "canJoinAllSpaces", "stationary", "ignoresCycle" })

local function centerBanner()
    local screen = hs.screen.mainScreen()

    local win = hs.window.frontmostWindow()
    if win then
        screen = win:screen()
    else
        local cursorScreen = hs.mouse.getCurrentScreen()
        if cursorScreen then
            screen = cursorScreen
        end
    end

    local frame = screen:fullFrame()

    banner:frame({
        x = frame.x + (frame.w - width) / 2,
        y = frame.y + frame.h - height,
        w = width,
        h = height
    })
end

local function bannerAppearance(muted)
    local bannerFont = { name = "Menlo", size = 20 }

    if muted then
        return {
            text = "Mute",
            backgroundColor = { white = 0.3, alpha = 0.7 },
            textColor = hs.drawing.color.gray,
            font = bannerFont
        }
    else
        return {
            text = "MIC",
            backgroundColor = { red = 0.8, alpha = 0.7 },
            textColor = hs.drawing.color.white,
            font = bannerFont
        }
    end
end

local function menubarAppearance(muted)
    local menubarFont = { name = "Menlo", size = 14 }

    if muted then
        return {
            text = "Mute",
            textColor = hs.drawing.color.gray,
            font = menubarFont
        }
    else
        return {
            text = " MIC ",
            backgroundColor = { red = 0.8, alpha = 0.8 },
            textColor = hs.drawing.color.white,
            font = menubarFont
        }
    end
end

local function updateBanner(mic, appearance)
    centerBanner()

    banner[1].fillColor = appearance.backgroundColor
    banner[2].text = appearance.text
    banner[2].textColor = appearance.textColor
    banner[2].textFont = appearance.font.name
    banner[2].textSize = appearance.font.size

    if mic:inUse() then
        banner:show()
    else
        banner:hide()
    end
end

local function updateMenubar(appearance)
    local style = {
        backgroundColor = appearance.backgroundColor,
        color = appearance.textColor,
        font = appearance.font
    }

    menu:setTitle(hs.styledtext.new(appearance.text, style))
end

local function update()
    local mic = hs.audiodevice.defaultInputDevice()
    local muted = mic:inputMuted()

    updateBanner(mic, bannerAppearance(muted))
    updateMenubar(menubarAppearance(muted))
end

local function toggle()
    local mic = hs.audiodevice.defaultInputDevice()
    mic:setInputMuted(not mic:inputMuted())
    update()
end

centerBanner()

hs.screen.watcher.new(function()
    centerBanner()
end):start()

update()

hs.hotkey.bind({ "ctrl", "cmd" }, "a", toggle)
menu:setClickCallback(toggle)

micMute = hs.timer.doEvery(1, update)
