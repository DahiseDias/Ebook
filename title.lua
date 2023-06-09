local composer = require("composer")
local scene = composer.newScene()

local forwardButton, buttonSound

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_1", "fade")

        return true
    end
end

function scene:create(event)
    local sceneGroup = self.view

    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")
    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

	local dente_leao = display.newImage(sceneGroup, "src/assets/plantas/Dente_de_leao.png")
    dente_leao.anchorX = 0
    dente_leao.anchorY = 0
    dente_leao.x = 0
    dente_leao.y = 0
    sceneGroup:insert(dente_leao)

	local subtitle = display.newImage(sceneGroup, "src/assets/textos/Livro_Eletrônico_Interativo.png")
    subtitle.x = display.contentWidth * 1/2
    subtitle.y = display.contentHeight * 1/5
    sceneGroup:insert(subtitle)

	local title = display.newImage(sceneGroup, "src/assets/textos/Reprodução_das_Plantas.png")
    title.x = display.contentWidth * 1/2
    title.y = display.contentHeight * 2/5
    sceneGroup:insert(title)




    forwardButton = display.newImageRect('src/assets/buttons/btn_right.png', display.contentWidth,
    display.contentWidth)
    forwardButton.x = display.contentWidth * 0.9
    forwardButton.y = display.contentHeight * 0.9
    forwardButton:scale(0.1, 0.1)
    sceneGroup:insert(forwardButton)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        forwardButton:removeEventListener("touch", forwardButton)
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene