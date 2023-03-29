local composer = require("composer")
local graphics = require("graphics")
local scene = composer.newScene()

local forwardButton, backButton, animation, buttonSound

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_8", "fade")

        return true
    end
end

local sheetOptions =
{
    width = 768,
    height = 1024,
    numFrames = 11
}

local sequences_GrowPlant = {
    -- consecutive frames sequence
    {
        name = "normal",
        start = 1,
        count = 11,
        time = 2000,
        loopCount = 1,
        loopDirection = "forward"
    }
}

function scene:create(event)
    local sceneGroup = self.view
    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")

    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    local grow_plant_sheet = graphics.newImageSheet( "src/assets/plantas/end_animation/spritesheet.png", sheetOptions )
    
    animation = display.newSprite( grow_plant_sheet, sequences_GrowPlant )
    animation.anchorX = 0
    animation.anchorY = 0
    animation.x = 0
    animation.y = 0
    sceneGroup:insert(animation)

    local subtitle = display.newImage(sceneGroup, "src/assets/textos/Livro_Eletrônico_Interativo.png")
    subtitle.x = display.contentWidth * 1/2
    subtitle.y = display.contentHeight * 2/14
    sceneGroup:insert(subtitle)

	local title = display.newImage(sceneGroup, "src/assets/textos/Reprodução_das_Plantas.png")
    title.x = display.contentWidth * 1/2
    title.y = display.contentHeight * 4/14
    sceneGroup:insert(title)

    local creditos = display.newImage(sceneGroup, "src/assets/textos/credito.png")
    creditos.x = display.contentWidth * 1/2
    creditos.y = display.contentHeight * 12/14
    sceneGroup:insert(creditos)


    backButton = display.newImageRect('src/assets/buttons/btn_left.png', display.contentWidth,
    display.contentWidth)
    backButton.x = display.contentWidth * 0.1
    backButton.y = display.contentHeight * 0.9
    backButton:scale(0.1, 0.1)
    sceneGroup:insert(backButton)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        animation:play()
        backButton.touch = onBackPage
        backButton:addEventListener("touch", backButton)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        backButton:removeEventListener("touch", backButton)
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene