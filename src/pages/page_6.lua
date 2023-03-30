local composer = require("composer")
local physics = require("physics")

local scene = composer.newScene()

local forwardButton, backButton, sensor_getPolem, sceneGroup, abelha, sensor_setPolem
local flor1_com_polem, flor2_com_polem, flor1_sem_polem, flor2_sem_polem
local buttonSound,  softSound

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

local Flor_goal = "flor1"

local function GetPolem_1(self, event)

    if event.other.id == "abelha_default" and self.id == "GetPolem" and Flor_goal == "flor1" then
        audio.play(softSound, softSoundOptions)
        local x = abelha.x
        local y = abelha.y
        abelha:removeSelf()
        abelha = display.newImage(sceneGroup, "src/assets/animais/abelha2.png")
        abelha.id = "abelha_polem"
        abelha.x = x
        abelha.y = y
        abelha:scale(0.2, 0.2)
        
        flor1_com_polem.isVisible = false
        flor1_sem_polem.isVisible = true
        
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)
        timer.performWithDelay(1000, function()
            Flor_goal = "flor2"
            abelha:addEventListener("collision", abelha)
            physics.addBody(abelha, { radius = 50 })
            sceneGroup:insert(abelha)
        end)

    elseif event.other.id == "abelha_polem" and self.id == "SetPolem" and Flor_goal == "flor1" then
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
        
        flor1_com_polem.isVisible = true
        flor1_sem_polem.isVisible = false
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)
        
        timer.performWithDelay(1000, function()
            abelha:addEventListener("collision", abelha)
            physics.addBody(abelha, { radius = 50 })
            sceneGroup:insert(abelha)
        end)
    end
end

local function GetPolem_2(self, event)
    if event.other.id == "abelha_default" and self.id == "GetPolem" and Flor_goal == "flor2" then
        audio.play(softSound, softSoundOptions)
        local x = abelha.x
        local y = abelha.y
        abelha:removeSelf()
        abelha = display.newImage(sceneGroup, "src/assets/animais/abelha2.png")
        abelha.id = "abelha_polem"
        abelha.x = x
        abelha.y = y
        abelha:scale(0.2, 0.2)
        
        flor2_com_polem.isVisible = false
        flor2_sem_polem.isVisible = true
        
        
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)
        timer.performWithDelay(1000, function()
            Flor_goal = "flor1"
            abelha:addEventListener("collision", abelha)
            physics.addBody(abelha, { radius = 50 })
            sceneGroup:insert(abelha)
        end)

    elseif event.other.id == "abelha_polem" and self.id == "SetPolem" and Flor_goal == "flor2" then
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
        
        flor2_com_polem.isVisible = true
        flor2_sem_polem.isVisible = false
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)
        
        timer.performWithDelay(1000, function()
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
    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    flor1_sem_polem = display.newImage(sceneGroup, "src/assets/plantas/flor_completa.png")
    flor1_sem_polem.id = "SetPolem"
    flor1_sem_polem.x = display.contentWidth * 1 / 2 - 350
    flor1_sem_polem.y = display.contentHeight * 1 / 2 - 100
    flor1_sem_polem:rotate(90)
    flor1_sem_polem:scale(0.7, 0.7)
    sceneGroup:insert(flor1_sem_polem)

    flor1_com_polem = display.newImage(sceneGroup, "src/assets/plantas/flor_completa_Polem.png")
    flor1_com_polem.id = "GetPolem"
    flor1_com_polem.x = display.contentWidth * 1 / 2 - 340
    flor1_com_polem.y = display.contentHeight * 1 / 2 - 100
    flor1_com_polem:rotate(90)
    flor1_com_polem:scale(0.7, 0.7)
    sceneGroup:insert(flor1_com_polem)

    flor2_sem_polem = display.newImage(sceneGroup, "src/assets/plantas/flor_completa.png")
    flor2_sem_polem.id = "SetPolem"
    flor2_sem_polem.x = display.contentWidth * 4 / 6
    flor2_sem_polem.y = display.contentHeight * 15 / 16
    flor2_sem_polem:scale(0.7, 0.7)
    sceneGroup:insert(flor2_sem_polem)

    flor2_com_polem = display.newImage(sceneGroup, "src/assets/plantas/flor_completa_Polem.png")
    flor2_com_polem.id = "GetPolem"
    flor2_com_polem.x = display.contentWidth * 4 / 6
    flor2_com_polem.y = display.contentHeight * 15 / 16
    flor2_com_polem:scale(0.7, 0.7)
    sceneGroup:insert(flor2_com_polem)

    forwardButton = display.newImageRect('src/assets/buttons/btn_right.png', display.contentWidth, display.contentWidth)
    forwardButton.x = display.contentWidth * 0.9
    forwardButton.y = display.contentHeight * 0.9
    forwardButton:scale(0.1, 0.1)
    sceneGroup:insert(forwardButton)

    backButton = display.newImageRect('src/assets/buttons/btn_left.png', display.contentWidth, display.contentWidth)
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
    local phase = event.phase

    if (phase == "will") then
        physics.start()
        physics.setGravity(0, 0)

        Flor_goal = "flor1"

        abelha = display.newImage(sceneGroup, "src/assets/animais/abelha.png")
        abelha.id = "abelha_default"
        abelha:scale(0.2, 0.2)
        sceneGroup:insert(abelha)

        flor1_com_polem.isVisible = true
        flor1_sem_polem.isVisible = false
        flor2_com_polem.isVisible = false
        flor2_sem_polem.isVisible = true
        
        abelha.x = display.contentWidth * 4 / 6
        abelha.y = 100
        abelha.touch = onDragObject
        abelha:addEventListener("touch", abelha)
        
        flor1_com_polem.collision = GetPolem_1
        flor1_com_polem:addEventListener("collision", flor1_com_polem)
        flor1_sem_polem.collision = GetPolem_1
        flor1_sem_polem:addEventListener("collision", flor1_sem_polem)
        flor2_sem_polem.collision = GetPolem_2
        flor2_sem_polem:addEventListener("collision", flor2_sem_polem)
        flor2_com_polem.collision = GetPolem_2
        flor2_com_polem:addEventListener("collision", flor2_com_polem)
        
        physics.addBody(abelha, { radius = 50 })
        physics.addBody(flor1_com_polem, "static", { isSensor = true, radius = 130 })
        physics.addBody(flor1_sem_polem, "static", { isSensor = true, radius = 130 })
        physics.addBody(flor2_com_polem, "static", { isSensor = true, radius = 130 })
        physics.addBody(flor2_sem_polem, "static", { isSensor = true, radius = 130 })
        
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
        backButton.touch = onBackPage
        backButton:addEventListener("touch", backButton)
    elseif (phase == "did") then
    end
end

function scene:hide(event)
    local phase = event.phase

    if (phase == "will") then
        abelha:removeSelf()
        forwardButton:removeEventListener("touch", forwardButton)
        backButton:removeEventListener("touch", backButton)
        physics.stop()
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
