local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")

local forwardButton, backButton ,manga_aberta, caroco

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_end", "fade")

        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_7", "fade")

        return true
    end
end

local function onDragObject( self, event )
    if ( event.phase == "moved" ) then
        print( "Touch event moved on: " .. self.id )
        self.isVisible = false
        manga_aberta.isVisible = true
        caroco.isVisible = true
    end
    return true
end

local function listener( event )
    if event.isShake then
        print( "The device is being shaken!" )
        physics.start()
        physics.setGravity( 0, 35 )
        physics.addBody(caroco, "dynamic", {density=1.6, friction=0.5, bounce=0.2})
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

    local manga = display.newImage(sceneGroup, "src/assets/plantas/manga.png")
    manga.id = "manga"
    manga.anchorX = 0
    manga.anchorY = 0
    manga.x = 0
    manga.y = 0
    manga.touch = onDragObject
    manga:addEventListener("touch", manga)
    sceneGroup:insert(manga)

    manga_aberta = display.newImage(sceneGroup, "src/assets/plantas/manga_aberta.png")
    manga_aberta.anchorX = 0
    manga_aberta.anchorY = 0
    manga_aberta.x = 0
    manga_aberta.y = 0
    manga_aberta.isVisible = false
    sceneGroup:insert(manga_aberta)

    caroco = display.newImage(sceneGroup, "src/assets/plantas/manga_caroço.png")
    caroco.x = display.contentWidth * 1.05/2
    caroco.y = display.contentHeight * 8.22/14
    caroco.isVisible = false
    sceneGroup:insert(caroco)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page8.png")
    text.x = display.contentWidth * 1/2
    text.y = display.contentHeight * 2/14
    sceneGroup:insert(text)

    local text2 = display.newImage(sceneGroup, "src/assets/textos/text_page8_2.png")
    text2.x = display.contentWidth * 1/2
    text2.y = display.contentHeight * 12/14
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
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
        backButton.touch = onBackPage
        backButton:addEventListener("touch", backButton)
        Runtime:addEventListener( "accelerometer", listener )
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        forwardButton:removeEventListener("touch", forwardButton)
        Runtime:removeEventListener( "accelerometer", listener )

        physics.stop()
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene