local composer = require("composer")
local scene = composer.newScene()

local forwardButton

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_7", "fade")

        return true
    end
end
local function onDragObject( self, event )
    if ( event.phase == "moved" ) then
        print( "Touch event moved on: " .. self.id )
        self.x = event.x 
        self.y = event.y 
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page6.png")
    text.x = display.contentWidth * 1/2
    text.y = display.contentHeight * 2/14
    sceneGroup:insert(text)


    local flor1 = display.newImage(sceneGroup, "src/assets/plantas/flor_completa.png")
    flor1.x = display.contentWidth * 1/2 - 350
    flor1.y = display.contentHeight * 1/2 - 100
    flor1:rotate(90)
    flor1:scale(0.7, 0.7)
    sceneGroup:insert(flor1)



    local flor2 = display.newImage(sceneGroup, "src/assets/plantas/flor_completa.png")
    flor2.x = display.contentWidth * 4/6
    flor2.y = display.contentHeight * 15/16
    flor2:scale(0.7, 0.7)
    sceneGroup:insert(flor2)

    local abelha = display.newImage(sceneGroup, "src/assets/animais/abelha.png")
    abelha.id = "abelha"
    abelha.x = display.contentWidth * 4/6
    abelha.y = 100
    abelha:scale(0.2, 0.2)
    abelha.touch = onDragObject
    abelha:addEventListener("touch", abelha)
    sceneGroup:insert(abelha)

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