local composer = require("composer")
local scene = composer.newScene()
local text_BF, text_Morcego, text_abelha

local forwardButton, backButton, buttonSound

local abelha, abelha_silhueta,morcego, morcego_silhueta, Beija_Flor, Beija_Flor_silhueta

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_6", "fade")

        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_4", "fade")

        return true
    end
end

local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then
        audio.play(buttonSound, buttonSoundOptions)
        print( "Touch event began on: " .. self.id )
        if self.id == "abelha" then
            text_abelha.isVisible = not text_abelha.isVisible
            abelha_silhueta.isVisible = true
        elseif self.id == "abelha_silhueta" then
            abelha_silhueta.isVisible = false
            text_abelha.isVisible = not text_abelha.isVisible
        elseif self.id == "Morcego" then
            text_Morcego.isVisible = not text_Morcego.isVisible
            morcego_silhueta.isVisible = true
        elseif self.id == "Morcego_silhueta" then
            text_Morcego.isVisible = not text_Morcego.isVisible
            morcego_silhueta.isVisible = false
        elseif self.id == "BF" then
            text_BF.isVisible = not text_BF.isVisible
            Beija_Flor_silhueta.isVisible = true
        elseif self.id == "BF_silhueta" then
            text_BF.isVisible = not text_BF.isVisible
            Beija_Flor_silhueta.isVisible = false
        end
    end
    return true
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

    local background_plantas = display.newImage(sceneGroup, "src/assets/background/Background_plantas.png")
    background_plantas.anchorX = 0
    background_plantas.anchorY = 0
    background_plantas.x = 0
    background_plantas.y = 0
    sceneGroup:insert(background_plantas)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page5_1.png")
    text.x = display.contentWidth * 2.8/4
    text.y = display.contentHeight * 2/14
    sceneGroup:insert(text)

    text_abelha = display.newImage(sceneGroup, "src/assets/textos/text_abelha.png")
    text_abelha.x = display.contentWidth * 2/4
    text_abelha.y = display.contentHeight * 11.3/14
    text_abelha.isVisible = false
    sceneGroup:insert(text_abelha)
    
    abelha = display.newImage(sceneGroup, "src/assets/animais/abelha_2.png")
    abelha.id = "abelha"
    abelha.x = display.contentWidth * 1/4
    abelha.y = display.contentHeight * 11.3/14
    abelha.touch = onObjectTouch
    abelha:addEventListener("touch", abelha)
    sceneGroup:insert(abelha)

    abelha_silhueta = display.newImage(sceneGroup, "src/assets/animais/abelha_2_silhueta.png")
    abelha_silhueta.id = "abelha_silhueta"
    abelha_silhueta.x = display.contentWidth * 1/4
    abelha_silhueta.y = display.contentHeight * 11.3/14
    abelha_silhueta.touch = onObjectTouch
    abelha_silhueta:addEventListener("touch", abelha_silhueta)
    sceneGroup:insert(abelha_silhueta)

    text_Morcego = display.newImage(sceneGroup, "src/assets/textos/text_Morcego.png")
    text_Morcego.x = display.contentWidth * 2/4
    text_Morcego.y = display.contentHeight * 2.5/14
    text_Morcego.isVisible = false
    sceneGroup:insert(text_Morcego)
    
    morcego = display.newImage(sceneGroup, "src/assets/animais/Morcego.png")
    morcego.id = "Morcego"
    morcego.x = display.contentWidth * 0.8/4
    morcego.y = display.contentHeight * 2.5/14
    morcego.touch = onObjectTouch
    morcego:addEventListener("touch", morcego)
    sceneGroup:insert(morcego)

    morcego_silhueta = display.newImage(sceneGroup, "src/assets/animais/Morcego_silhueta.png")
    morcego_silhueta.id = "Morcego_silhueta"
    morcego_silhueta.x = display.contentWidth * 0.8/4
    morcego_silhueta.y = display.contentHeight * 2.5/14
    morcego_silhueta.touch = onObjectTouch
    morcego_silhueta:addEventListener("touch", morcego_silhueta)
    sceneGroup:insert(morcego_silhueta)

    text_BF = display.newImage(sceneGroup, "src/assets/textos/text_BF.png")
    text_BF.x = display.contentWidth * 2/4
    text_BF.y = display.contentHeight * 6/10
    text_BF.isVisible = false
    sceneGroup:insert(text_BF)
    
    Beija_Flor = display.newImage(sceneGroup, "src/assets/animais/BF.png")
    Beija_Flor.id = "BF"
    Beija_Flor.x = display.contentWidth * 3.1/4
    Beija_Flor.y = display.contentHeight * 6/10
    Beija_Flor.touch = onObjectTouch
    Beija_Flor:addEventListener("touch", Beija_Flor)
    sceneGroup:insert(Beija_Flor)

    Beija_Flor_silhueta = display.newImage(sceneGroup, "src/assets/animais/BF_silhueta.png")
    Beija_Flor_silhueta.id = "BF_silhueta"
    Beija_Flor_silhueta.x = display.contentWidth * 3.1/4
    Beija_Flor_silhueta.y = display.contentHeight * 6/10
    Beija_Flor_silhueta.touch = onObjectTouch
    Beija_Flor_silhueta:addEventListener("touch", Beija_Flor_silhueta)
    sceneGroup:insert(Beija_Flor_silhueta)


    local Bf_flor = display.newImage(sceneGroup, "src/assets/animais/BF_Flor.png")
    Bf_flor.x = display.contentWidth - 65
    Bf_flor.y = display.contentHeight * 0.82/2
    sceneGroup:insert(Bf_flor)

    local text2 = display.newImage(sceneGroup, "src/assets/textos/text_page5_3.png")
    text2.x = display.contentWidth * 1.5/4
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
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        abelha_silhueta.isVisible = true
        morcego_silhueta.isVisible = true
        Beija_Flor_silhueta.isVisible = true
        text_BF.isVisible = false
        text_Morcego.isVisible = false
        text_abelha.isVisible = false

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