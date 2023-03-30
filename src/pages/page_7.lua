local composer = require("composer")
local physics = require("physics")
local scene = composer.newScene()

local forwardButton,polem, backButton, buttonSound, collision_sound, ovario

local limit_Up, limit_bottom, limit_left, limit_right, obs_detector

local buttonSoundOptions = {
    channel = 1,
    loops = 0,
    duration = 1000,
    fadein = 0
}

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_8", "fade")
        
        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        audio.play(buttonSound, buttonSoundOptions)
        composer.gotoScene("src.pages.page_6", "fade")

        return true
    end
end

local run = true

local function onTilt( event )
    if run then
        print("onTilt")
        local xGravity = event.xGravity
        local zGravity = event.yGravity
        
        local moveX = xGravity * 10  -- multiplicador para controlar a velocidade de movimento
        local moveY = -zGravity * 10 -- multiplicador para controlar a velocidade de movimento
        
        polem.x = polem.x + moveX
        polem.y = polem.y + moveY
    end
 
end

local function collision(self, event)
    print("collision")
    timer.performWithDelay(1, function()
        audio.play(collision_sound, buttonSoundOptions)
        run = false
        event.other.x = self.x
        event.other.y = self.y
    end)
    
end

function scene:create(event)
    physics.start()
    -- physics.setDrawMode("hybrid")
    local sceneGroup = self.view

    buttonSound = audio.loadSound("src/assets/sounds/button_click.wav")
    collision_sound = audio.loadSound("src/assets/sounds/level-passed.mp3")

    limit_left = display.newRect(-40,0, 40,display.contentHeight)
    limit_left.anchorX = 0
    limit_left.anchorY = 0
    limit_left:setFillColor(95/255, 143/255, 91/255)
    sceneGroup:insert(limit_left)
    
    limit_right = display.newRect(display.contentWidth,0, 40,display.contentHeight)
    limit_right.anchorX = 0
    limit_right.anchorY = 0
    limit_right:setFillColor(95/255, 143/255, 91/255)
    sceneGroup:insert(limit_right)
    
    limit_bottom = display.newRect(0,display.contentHeight, display.contentWidth, 40)
    limit_bottom.anchorX = 0
    limit_bottom.anchorY = 0
    limit_bottom:setFillColor(95/255, 143/255, 91/255)
    sceneGroup:insert(limit_bottom)
    
    limit_Up = display.newRect(0,-40, display.contentWidth, 40)
    limit_Up.anchorX = 0
    limit_Up.anchorY = 0
    limit_Up:setFillColor(95/255, 143/255, 91/255)
    sceneGroup:insert(limit_Up)
    
    local background = display.newImage(sceneGroup, "src/assets/plantas/ovario_bordas.png")
    background.x = display.contentWidth * 1/2
    background.y = display.contentHeight * 1/2 - 500
    background:scale(3,3)
    sceneGroup:insert(background)
    
    
    obs_detector = display.newRect(display.contentWidth * 1/2, display.contentHeight * 1/2 -50, 200, 50)
    obs_detector:setFillColor(95/255, 143/255, 91/255)
    sceneGroup:insert(obs_detector)

    local obstaculo = display.newImage(sceneGroup, "src/assets/plantas/ovario_obstaculo.png")
    obstaculo.x = display.contentWidth * 1/2
    obstaculo.y = display.contentHeight * 1/2
    sceneGroup:insert(obstaculo)

    ovario = display.newImage(sceneGroup, "src/assets/plantas/ovario.png")
    ovario.x = display.contentWidth * 1/2
    ovario.y = display.contentHeight * 1/2 + 50
    ovario:scale(0.7, 0.7)
    sceneGroup:insert(ovario)

    polem = display.newImage(sceneGroup, "src/assets/plantas/Polem.png")
    -- ovario:scale(0.7, 0.7)
    sceneGroup:insert(polem)

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page7.png")
    text.x = display.contentWidth * 1/2
    text.y = display.contentHeight * 2/14
    sceneGroup:insert(text)

    local text2 = display.newImage(sceneGroup, "src/assets/textos/text_page7_2.png")
    text2.x = display.contentWidth * 1/2
    text2.y = display.contentHeight * 12/14
    text2:scale(0.7, 0.7)
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

local force = 10

  
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    
    if (phase == "will") then
        polem.x = display.contentWidth * 1/2
        polem.y = 100
        physics.start()
        physics.setGravity( 0, 0 )
        run = true
        Runtime:addEventListener( "accelerometer", onTilt )

        physics.addBody( ovario, "static",{ density=0.5, friction=0.1, bounce=0.4} )
        physics.addBody( polem, "dynamic",{ density=0.5, friction=0.1, bounce=0.4} )
        physics.addBody( limit_left, "static", { density=1.6, friction=0.5, bounce=0.2 } )
        physics.addBody( limit_right, "static", { density=1.6, friction=0.5, bounce=0.2 } )
        physics.addBody( limit_bottom, "static", { density=1.6, friction=0.5, bounce=0.2 } )
        physics.addBody( limit_Up, "static", { density=1.6, friction=0.5, bounce=0.2 } )
        physics.addBody( obs_detector, "static",{ density=0.5, friction=0.1, bounce=0.4},

        { box={ halfWidth=30, halfHeight=60, x=-80, y=60 } },
        { box={ halfWidth=30, halfHeight=60, x=80, y=60 } })
        ovario.collision = collision
        ovario:addEventListener("collision", ovario)
        
    elseif (phase == "did") then
        display.setDefault('background', 95/255, 143/255, 91/255)
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
        display.setDefault('background', 0, 0, 0)
        forwardButton:removeEventListener("touch", forwardButton)
        backButton:removeEventListener("touch", backButton)
        Runtime:removeEventListener( "accelerometer", onTilt )
        physics.stop()
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene