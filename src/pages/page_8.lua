local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")

local forwardButton, backButton, manga_aberta, caroco, buttonSound, softSound, sliceSound, manga, text3, text2

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    fadein = 0
}

local softSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 600,
    fadein = 0
}


local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_end", "fade")

        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_7", "fade")

        return true
    end
end

local function onDragObject(self, event)
    if (event.phase == "moved") then
        audio.play(sliceSound, buttonSoundOptions)
        print("Touch event moved on: " .. self.id)
        self.isVisible = false
        text3.isVisible = true
        text2.isVisible = false
        manga_aberta.isVisible = true
        caroco.isVisible = true
    end
    return true
end

local function listener(event)
    if event.isShake then
        print("The device is being shaken!")
        audio.play(softSound, softSoundOptions)
        physics.start()
        physics.setGravity(0, 35)
        physics.addBody(caroco, "dynamic", { density = 1.6, friction = 0.5, bounce = 0.2 })
    end
end

function scene:create(event)
    local sceneGroup = self.view
    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")
    softSound = audio.loadSound("src/assets/sounds/soft_impact.mp3")
    sliceSound = audio.loadSound("src/assets/sounds/slice.mp3")


    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    manga = display.newImage(sceneGroup, "src/assets/plantas/manga.png")
    manga.id = "manga"
    manga.anchorX = 0
    manga.anchorY = 0
    sceneGroup:insert(manga)

    manga_aberta = display.newImage(sceneGroup, "src/assets/plantas/manga_aberta.png")
    manga_aberta.anchorX = 0
    manga_aberta.anchorY = 0
    sceneGroup:insert(manga_aberta)

    caroco = display.newImage(sceneGroup, "src/assets/plantas/manga_caroço.png")
    sceneGroup:insert(caroco)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page8.png")
    text.x = display.contentWidth * 1 / 2
    text.y = display.contentHeight * 2 / 14
    sceneGroup:insert(text)

    text2 = display.newImage(sceneGroup, "src/assets/textos/text_page8_2.png")
    text2.x = display.contentWidth * 1 / 2
    text2.y = display.contentHeight * 12 / 14
    sceneGroup:insert(text2)

    text3 = display.newImage(sceneGroup, "src/assets/textos/text_page8_3.png")
    text3.x = display.contentWidth * 1 / 2
    text3.y = display.contentHeight * 12 / 14
    
    sceneGroup:insert(text3)

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
        caroco.x = display.contentWidth * 1.05 / 2
        caroco.y = display.contentHeight * 8.22 / 14
        caroco.isVisible = false

        manga_aberta.x = 0
        manga_aberta.y = 0
        manga_aberta.isVisible = false

        manga.isVisible = true
        manga.x = 0
        manga.y = 0
        manga.touch = onDragObject
        manga:addEventListener("touch", manga)

        text3.isVisible = false
        text2.isVisible = true
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
        backButton.touch = onBackPage
        backButton:addEventListener("touch", backButton)
        Runtime:addEventListener("accelerometer", listener)
    elseif (phase == "did") then
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        forwardButton:removeEventListener("touch", forwardButton)
        Runtime:removeEventListener("accelerometer", listener)

        physics.stop()
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
