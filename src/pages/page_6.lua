local composer = require("composer")
local physics = require("physics")

local scene = composer.newScene()

local forwardButton, backButton, sensor_getPolem, sceneGroup, abelha, sensor_setPolem, flor1, flor2, buttonSound,  softSound

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local softSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 700,
    fadein = 0
}


local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_7", "fade")

        return true
    end
end
local function onDragObject(self, event)
    if (event.phase == "moved") then
        -- print( "Touch event moved on: " .. self.id )
        self.x = event.x
        self.y = event.y
    end
    return true
end

local function GetPolem(self, event)
    if event.other.id == "GetPolem" and self.id == "abelha_default" then
        audio.play(softSound, softSoundOptions)
        local x = abelha.x
        local y = abelha.y
        abelha:removeSelf()
        abelha = display.newImage(sceneGroup, "src/assets/animais/abelha2.png")
        abelha.id = "abelha_polem"
        abelha.x = x
        abelha.y = y
        abelha:scale(0.2, 0.2)
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)

        flor1:removeSelf()
        flor1 = display.newImage(sceneGroup, "src/assets/plantas/flor_completa.png")
        flor1.x = display.contentWidth * 1 / 2 - 350
        flor1.y = display.contentHeight * 1 / 2 - 100
        flor1:rotate(90)
        flor1:scale(0.7, 0.7)
        sceneGroup:insert(flor1)

        timer.performWithDelay(1, function()
            abelha.collision = GetPolem
            abelha:addEventListener("collision", abelha)
            physics.addBody(abelha, { radius = 50 })
            sceneGroup:insert(abelha)
        end)
    elseif event.other.id == "SetPolem" and self.id == "abelha_polem" then
        print("SetPolem")
        audio.play(softSound, softSoundOptions)
        local x = abelha.x
        local y = abelha.y
        abelha:removeSelf()
        abelha = display.newImage(sceneGroup, "src/assets/animais/abelha.png")
        abelha.id = "abelha_default"
        abelha.x = x
        abelha.y = y
        abelha:scale(0.2, 0.2)
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)

        flor2:removeSelf()
        flor2 = display.newImage(sceneGroup, "src/assets/plantas/flor_completa_Polem.png")
        flor2.x = display.contentWidth * 4 / 6
        flor2.y = display.contentHeight * 15 / 16
        flor2:scale(0.7, 0.7)
        sceneGroup:insert(flor2)

        timer.performWithDelay(1, function()
            abelha.collision = GetPolem
            abelha:addEventListener("collision", abelha)
            physics.addBody(abelha, { radius = 50 })
            sceneGroup:insert(abelha)
        end)
    end
end


local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_5", "fade")

        return true
    end
end

function scene:create(event)
    sceneGroup = self.view
    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")
    softSound = audio.loadSound("src/assets/sounds/soft_impact.mp3")
    physics.start()
    physics.setGravity(0, 0)
    -- physics.setDrawMode("hybrid")
    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)


    sensor_getPolem = display.newRect(display.contentWidth * 1 / 2 - 250, display.contentHeight * 1 / 2 - 100, 50, 50)
    sensor_getPolem.id = "GetPolem"
    
    sceneGroup:insert(sensor_getPolem)

    flor1 = display.newImage(sceneGroup, "src/assets/plantas/flor_completa_Polem.png")
    flor1.x = display.contentWidth * 1 / 2 - 350
    flor1.y = display.contentHeight * 1 / 2 - 100
    flor1:rotate(90)
    flor1:scale(0.7, 0.7)
    sceneGroup:insert(flor1)


    sensor_setPolem = display.newRect(display.contentWidth * 4 / 6, display.contentHeight * 14 / 16, 50, 50)
    sensor_setPolem.id = "SetPolem"
    
    sceneGroup:insert(sensor_setPolem)

    flor2 = display.newImage(sceneGroup, "src/assets/plantas/flor_completa.png")
    flor2.x = display.contentWidth * 4 / 6
    flor2.y = display.contentHeight * 15 / 16
    flor2:scale(0.7, 0.7)
    sceneGroup:insert(flor2)

    abelha = display.newImage(sceneGroup, "src/assets/animais/abelha.png")
    abelha.id = "abelha_default"
    abelha:scale(0.2, 0.2)
    sceneGroup:insert(abelha)

    forwardButton = display.newImageRect('src/assets/buttons/btn_right.png', display.contentWidth,
        display.contentWidth)
    forwardButton.x = display.contentWidth * 0.9
    forwardButton.y = display.contentHeight * 0.9
    forwardButton:scale(0.1, 0.1)
    sceneGroup:insert(forwardButton)

    backButton = display.newImageRect('src/assets/buttons/btn_left.png', display.contentWidth,
        display.contentWidth)
    backButton.x = display.contentWidth * 0.1
    backButton.y = display.contentHeight * 0.9
    backButton:scale(0.1, 0.1)
    sceneGroup:insert(backButton)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page6.png")
    text.x = display.contentWidth * 1 / 2
    text.y = display.contentHeight * 2 / 14
    sceneGroup:insert(text)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        physics.start()
        physics.setGravity(0, 0)
        forwardButton.touch = onNextPage
        abelha.x = display.contentWidth * 4 / 6
        abelha.y = 100
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)
        abelha.collision = GetPolem
        abelha:addEventListener("collision", abelha)
        physics.addBody(abelha, { radius = 50 })
        physics.addBody(sensor_setPolem, "static", { isSensor = true, radius = 130 })
        physics.addBody(sensor_getPolem, "static", { isSensor = true, radius = 130 })
        forwardButton:addEventListener("touch", forwardButton)
        backButton.touch = onBackPage
        backButton:addEventListener("touch", backButton)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        forwardButton:removeEventListener("touch", forwardButton)
        physics.stop()
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
