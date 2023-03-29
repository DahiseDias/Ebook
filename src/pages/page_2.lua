local composer = require("composer")
local transition = require("transition")
local scene = composer.newScene()

local forwardButton, dente_leao, dente_leao_pelado, rect, rect2, rect3, rect4, backButton, buttonSound


local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local background_sound_Options = {
    channel = 1,
    loops = -1,
    --duration = 1000,
    fadein = 0
}

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_3", "fade")

        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_1", "fade")
        return true
    end
end

local function listener(event)
    if event.isShake then
        print("The device is being shaken!")
        audio.play(BackgroundSound, background_sound_Options)
        dente_leao_pelado.isVisible = true
        dente_leao.isVisible = false
        Runtime:addEventListener("enterFrame", moveWave)
    end
end

local direction = false

function moveWave()
    local rotate_angle = 0.5
    if rect.x > display.contentWidth then
        rect.x = -100
        rect.y = 140
    end
    if rect2.x > display.contentWidth then
        rect2.x = -50
        rect2.y = 200
    end
    if rect3.x > display.contentWidth then
        rect3.x = -80
        rect3.y = 330
    end
    if rect4.x > display.contentWidth then
        rect4.x = -50
        rect4.y = 520
    end
    if not direction then
        timer.performWithDelay(2000, function()
            rect:translate(2, 0.3)
            rect:rotate(rotate_angle)
            rect2:translate(2.7, 0.3)
            rect2:rotate(rotate_angle + 0.1)
            rect3:translate(2.9, 0.3)
            rect3:rotate(-rotate_angle)
            rect4:translate(2.4, 0.3 - 0.1)
            rect4:rotate(rotate_angle)
            direction = true
        end)
    else
        timer.performWithDelay(2000, function()
            rect:translate(2, -0.5 - 0.1)
            rect:rotate(rotate_angle)
            rect2:translate(2.7, -0.5)
            rect2:rotate(rotate_angle)
            rect3:translate(2.9, -0.5 + 0.1)
            rect3:rotate(-rotate_angle)
            rect4:translate(2.4, -0.5)
            rect4:rotate(rotate_angle)
            direction = false
        end)
    end
end

function scene:create(event)
    local sceneGroup = self.view

    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")
    BackgroundSound = audio.loadSound("src/assets/sounds/wind.mp3")

    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    rect = display.newImage(sceneGroup, 'src/assets/plantas/Dente_de_leao_semente.png')
    rect:scale(0.5, 0.5)
    sceneGroup:insert(rect)

    rect2 = display.newImage('src/assets/plantas/Dente_de_leao_semente.png')
    rect2:scale(0.5, 0.5)
    sceneGroup:insert(rect)

    rect3 = display.newImage('src/assets/plantas/Dente_de_leao_semente.png')
    rect3:scale(0.5, 0.5)
    sceneGroup:insert(rect)

    rect4 = display.newImage('src/assets/plantas/Dente_de_leao_semente.png')
    rect4:scale(0.5, 0.5)
    sceneGroup:insert(rect)


    local text = display.newImage(sceneGroup, "src/assets/textos/text_page2.png")
    text.x = display.contentWidth * 1 / 2
    text.y = display.contentHeight * 2 / 14
    sceneGroup:insert(text)

    dente_leao = display.newImage(sceneGroup, "src/assets/plantas/Dente_de_leao.png")
    dente_leao.anchorX = 0
    dente_leao.anchorY = 0
    dente_leao.x = 0
    dente_leao.y = 0
    sceneGroup:insert(dente_leao)

    dente_leao_pelado = display.newImage(sceneGroup, "src/assets/plantas/Dente_de_leao_pelado.png")
    dente_leao_pelado.anchorX = 0
    dente_leao_pelado.anchorY = 0
    dente_leao_pelado.x = 0
    dente_leao_pelado.y = 0
    sceneGroup:insert(dente_leao_pelado)

    local text2 = display.newImage(sceneGroup, "src/assets/textos/text_page2_2.png")
    text2.x = display.contentWidth * 2.3 / 3
    text2.y = display.contentHeight * 10 / 14
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

    -- moveWave(rect, 300, 400, 50, 100, 0.5)
    if (phase == "will") then
        rect.x = -100
        rect.y = 140
        rect2.x = -50
        rect2.y = 200
        rect3.x = -80
        rect3.y = 330
        rect4.x = -50
        rect4.y = 520

        dente_leao_pelado.isVisible = false
        dente_leao.isVisible = true
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
        Runtime:removeEventListener("enterFrame", moveWave)
        rect.x = -500
        rect2.x = -500
        rect3.x = -500
        rect4.x = -500

        forwardButton:removeEventListener("touch", forwardButton)
        Runtime:removeEventListener("accelerometer", listener)

        audio.stop()
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
