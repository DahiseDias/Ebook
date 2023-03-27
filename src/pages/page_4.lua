local composer = require("composer")
local scene = composer.newScene()

local forwardButton
local sceneGroup
local text_masculino, text_feminino, text_Ovario
local seta_feminino, seta_masculino, seta_Ovario

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_5", "fade")

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

local function listener( event )
    if event.isShake then
        print( "The device is being shaken!" )
    end
     
    return true
end

local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then
        print( "Touch event began on: " .. self.id )
        if self.id == "androceu" then
            text_masculino.isVisible = not text_masculino.isVisible
            seta_masculino.isVisible = not seta_masculino.isVisible
        elseif self.id == "text_fem_detector" then
            text_feminino.isVisible = not text_feminino.isVisible
            seta_feminino.isVisible = not seta_feminino.isVisible
        elseif self.id == "text_ov_detector" then
            text_Ovario.isVisible = not text_Ovario.isVisible
            seta_Ovario.isVisible = not seta_Ovario.isVisible
        end
    end
    return true
end

function scene:create(event)
    sceneGroup = self.view

    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page4.png")
    text.x = display.contentWidth * 1 / 2
    text.y = display.contentHeight * 2 / 14
    sceneGroup:insert(text)


    local flor_pelada = display.newImage(sceneGroup, "src/assets/plantas/flor_pelada.png")
    flor_pelada.x = display.contentWidth * 1 / 2
    flor_pelada.y = display.contentHeight - 200
    sceneGroup:insert(flor_pelada)

    local androceu_left = display.newImage(sceneGroup, "src/assets/plantas/androceu_left.png")
    androceu_left.id = "androceu"
    androceu_left.x = display.contentWidth * 1 / 2 - 80
    androceu_left.y = display.contentHeight * 3.4 / 5
    androceu_left.touch = onObjectTouch
    androceu_left:addEventListener("touch", androceu_left)
    sceneGroup:insert(androceu_left)

    local androceu_right = display.newImage(sceneGroup, "src/assets/plantas/androceu_left.png")
    androceu_right.id = "androceu"
    androceu_right.x = display.contentWidth * 1 / 2 + 65
    androceu_right.y = display.contentHeight * 3.36 / 5
    androceu_right:scale(-1, 1)
    androceu_right.touch = onObjectTouch
    androceu_right:addEventListener("touch", androceu_right)
    sceneGroup:insert(androceu_right)

    local ovario_capa = display.newImage(sceneGroup, "src/assets/plantas/ovario_capa.png")
    ovario_capa.id = "ovario_capa"
    ovario_capa.x = display.contentWidth * 1 / 2 - 12.1
    ovario_capa.y = display.contentHeight * 3.4 / 5 - 3
    ovario_capa.touch = onDragObject
    ovario_capa:addEventListener("touch", ovario_capa)
    sceneGroup:insert(ovario_capa)

    local petala = display.newImage(sceneGroup, "src/assets/plantas/petala.png")
    petala.id = "petala"
    petala.x = display.contentWidth * 1/2
    petala.y = display.contentHeight * 3.63/5
    petala.touch = onDragObject
    petala:addEventListener("touch", petala)
    sceneGroup:insert(petala)

    text_feminino = display.newImage(sceneGroup, "src/assets/textos/feminina.png")
    text_feminino.x = display.contentWidth * 2/8
    text_feminino.y = display.contentHeight * 2/5 + 20
    text_feminino.isVisible = false
    sceneGroup:insert(text_feminino)

    seta_feminino = display.newImage(sceneGroup, "src/assets/textos/seta_feminino.png")
    seta_feminino.x = display.contentWidth * 3.5/8
    seta_feminino.y = display.contentHeight * 2/5 + 50
    seta_feminino.isVisible = false
    sceneGroup:insert(seta_feminino)

    text_masculino = display.newImage(sceneGroup, "src/assets/textos/masculina.png")
    text_masculino.x = display.contentWidth * 6.4/8
    text_masculino.y = display.contentHeight * 2/5 + 50
    text_masculino.isVisible = false
    sceneGroup:insert(text_masculino)

    seta_masculino = display.newImage(sceneGroup, "src/assets/textos/seta_masculino.png")
    seta_masculino.x = display.contentWidth * 5/8
    seta_masculino.y = display.contentHeight * 2.5/5 
    seta_masculino.isVisible = false
    sceneGroup:insert(seta_masculino)

    text_Ovario = display.newImage(sceneGroup, "src/assets/textos/Ovário.png")
    text_Ovario.x = display.contentWidth * 6.6/8
    text_Ovario.y = display.contentHeight * 3.63/5
    text_Ovario.isVisible = false
    sceneGroup:insert(text_Ovario)

    seta_Ovario = display.newImage(sceneGroup, "src/assets/textos/seta_ovario.png")
    seta_Ovario.x = display.contentWidth * 5/8
    seta_Ovario.y = display.contentHeight * 3.63/5
    seta_Ovario.isVisible = false
    sceneGroup:insert(seta_Ovario)

    forwardButton = display.newImageRect('src/assets/buttons/btn_right.png', display.contentWidth,
        display.contentWidth)
    forwardButton.x = display.contentWidth * 0.9
    forwardButton.y = display.contentHeight * 0.9
    forwardButton:scale(0.1, 0.1)
    sceneGroup:insert(forwardButton)

    local text_fem_detector = display.newCircle(0,0, 30)
    text_fem_detector.id = "text_fem_detector"
    text_fem_detector.x = display.contentWidth * 1 / 2 - 12.1
    text_fem_detector.y = display.contentHeight * 3/ 5 - 30
    text_fem_detector:setFillColor(1,1,0, 0.5 )
    text_fem_detector:setStrokeColor( 1, 1, 0)
    text_fem_detector.strokeWidth = 5
    text_fem_detector.touch = onObjectTouch
    text_fem_detector:addEventListener("touch", text_fem_detector)
    sceneGroup:insert(text_fem_detector)


    local text_ov_detector = display.newCircle(0,0, 30)
    text_ov_detector.id = "text_ov_detector"
    text_ov_detector.x = display.contentWidth * 1 / 2 - 12.1
    text_ov_detector.y = display.contentHeight * 4/ 5 - 30
    text_ov_detector:setFillColor(1,1,0, 0.5 )
    text_ov_detector:setStrokeColor( 1, 1, 0)
    text_ov_detector.strokeWidth = 5
    text_ov_detector.touch = onObjectTouch
    text_ov_detector:addEventListener("touch", text_ov_detector)
    sceneGroup:insert(text_ov_detector)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    
    if (phase == "will") then
        
    elseif (phase == "did") then
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
        Runtime:addEventListener( "accelerometer", listener )
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
