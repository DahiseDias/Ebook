local composer = require("composer")
local scene = composer.newScene()

local forwardButton

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_3", "fade")

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

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page2.png")
    text.x = display.contentWidth * 1/2
    text.y = display.contentHeight * 2/14
    sceneGroup:insert(text)

    local dente_leao = display.newImage(sceneGroup, "src/assets/plantas/Dente_de_leao.png")
    dente_leao.anchorX = 0
    dente_leao.anchorY = 0
    dente_leao.x = 0
    dente_leao.y = 0
    sceneGroup:insert(dente_leao)

    local text2 = display.newImage(sceneGroup, "src/assets/textos/text_page2_2.png")
    text2.x = display.contentWidth * 2.3/3
    text2.y = display.contentHeight * 10/14
    sceneGroup:insert(text2)


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