local composer = require("composer")
local scene = composer.newScene()
local sceneGroup, flowerGroup
local forwardButton, backButton

-- local dente_leao
local buttonSound, digSound

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local digSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 400,
    fadein = 0
}

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_2", "fade")
        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("title", "fade")
        return true
    end
end


local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then
        audio.play(digSound, digSoundOptions)
        local dente_leao = display.newImage("src/assets/plantas/Dente_de_leao_menor.png")
        dente_leao:scale(0.3, 0.3)
        dente_leao.x = event.x
        dente_leao.y = event.y
        flowerGroup:insert(dente_leao)
    end
    return true
end


function scene:create(event)
    sceneGroup = self.view

    flowerGroup = display.newGroup()
    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")
    digSound = audio.loadSound("src/assets/sounds/dig.mp3")
    local background = display.newImage(sceneGroup, "src/assets/background/Background_grass.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    background.touch = onObjectTouch
    background:addEventListener('touch', background)
    sceneGroup:insert(background)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page1.png")
    text.x = display.contentWidth * 1/2
    text.y = display.contentHeight * 2/14
    sceneGroup:insert(text)

    local text2 = display.newImage(sceneGroup, "src/assets/textos/text_page1_2.png")
    text2.x = display.contentWidth * 1/2
    text2.y = display.contentHeight * 5/14
    sceneGroup:insert(text2)

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
end

function scene:show(event)
    local phase = event.phase

    if (phase == "will") then
        flowerGroup = display.newGroup()
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
        display.remove(flowerGroup)
        forwardButton:removeEventListener("touch", forwardButton)
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene