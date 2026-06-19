local config = {
    intervalSeconds = 10,
    movePixels = 10,
}

local autoEnabled = false
local autoTimer = nil
local menuItem = nil

local function createMenuBarIndicator()
    if menuItem then
        return
    end

    menuItem = hs.menubar.new()

    local styledTitle = hs.styledtext.new(" Auto ", {
            font = { name = "Menlo", size = 14 },
            color = hs.drawing.color.white,
            backgroundColor = hs.drawing.color.blue
    })

    menuItem:setTitle(styledTitle)
end

local function removeMenuBarIndicator()
    if menuItem then
        menuItem:delete()
        menuItem = nil
    end
end

local function moveMouse()
    local pos = hs.mouse.absolutePosition()

    hs.mouse.absolutePosition({
        x = pos.x + config.movePixels,
        y = pos.y
    })

    hs.timer.usleep(50000)

    hs.mouse.absolutePosition(pos)
end

local function startAutoMouse()
    if autoTimer then
        autoTimer:stop()
    end

    autoTimer = hs.timer.doEvery(
        config.intervalSeconds,
        moveMouse
    )

    autoEnabled = true
    createMenuBarIndicator()
end

local function stopAutoMouse()
    if autoTimer then
        autoTimer:stop()
        autoTimer = nil
    end

    autoEnabled = false
    removeMenuBarIndicator()
end

local function toggleAutoMouse()
    if autoEnabled then
        stopAutoMouse()
    else
        startAutoMouse()
    end
end

hs.hotkey.bind(
    { "ctrl", "alt", "cmd" },
    "A",
    toggleAutoMouse
)
