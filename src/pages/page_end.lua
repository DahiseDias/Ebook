local composer = require("composer")
local scene = composer.newScene()

local forwardButton, backButton

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        -- composer.gotoScene("src.pages.page1", "fade")

        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_8", "fade")

        return true
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    local background_terra = display.newImage(sceneGroup, "src/assets/background/Background_terra.png")
    background_terra.anchorX = 0
    background_terra.anchorY = 0
    background_terra.x = 0
    background_terra.y = 0
    sceneGroup:insert(background_terra)

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
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        forwardButton.touch = onNextPage
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
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene