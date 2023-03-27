local composer = require("composer")
local physics = require("physics")
local scene = composer.newScene()

local forwardButton,polem

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_8", "fade")
        
        return true
    end
end


function scene:create(event)
    physics.start()
    physics.setGravity( 0, 0 )
    local sceneGroup = self.view

    local limit_left = display.newRect(-40,0, 40,display.contentHeight)
    limit_left.anchorX = 0
    limit_left.anchorY = 0
    physics.addBody( limit_left, "static", { density=1.6, friction=0.5, bounce=0.2 } )
    sceneGroup:insert(limit_left)

    local limit_right = display.newRect(display.contentWidth,0, 40,display.contentHeight)
    limit_right.anchorX = 0
    limit_right.anchorY = 0
    physics.addBody( limit_right, "static", { density=1.6, friction=0.5, bounce=0.2 } )
    sceneGroup:insert(limit_right)

    local limit_bottom = display.newRect(0,display.contentHeight, display.contentWidth, 40)
    limit_bottom.anchorX = 0
    limit_bottom.anchorY = 0
    physics.addBody( limit_bottom, "static", { density=1.6, friction=0.5, bounce=0.2 } )
    sceneGroup:insert(limit_bottom)

    local limit_Up = display.newRect(0,-40, display.contentWidth, 40)
    limit_Up.anchorX = 0
    limit_Up.anchorY = 0
    physics.addBody( limit_Up, "static", { density=1.6, friction=0.5, bounce=0.2 } )
    sceneGroup:insert(limit_Up)

    local background = display.newImage(sceneGroup, "src/assets/plantas/ovario_bordas.png")
    background.x = display.contentWidth * 1/2
    background.y = display.contentHeight * 1/2 - 500
    background:scale(3,3)
    sceneGroup:insert(background)

    display.setDefault('background', 95/255, 143/255, 91/255)

    local obstaculo = display.newImage(sceneGroup, "src/assets/plantas/ovario_obstaculo.png")
    obstaculo.x = display.contentWidth * 1/2
    obstaculo.y = display.contentHeight * 1/2
    sceneGroup:insert(obstaculo)

    local ovario = display.newImage(sceneGroup, "src/assets/plantas/ovario.png")
    ovario.x = display.contentWidth * 1/2
    ovario.y = display.contentHeight * 1/2 + 50
    ovario:scale(0.7, 0.7)
    sceneGroup:insert(ovario)

    polem = display.newImage(sceneGroup, "src/assets/plantas/Polem.png")
    polem.x = display.contentWidth * 1/2
    polem.y = 100
    -- ovario:scale(0.7, 0.7)
    sceneGroup:insert(polem)
    physics.addBody( polem, { density=0.1, friction=0.1, bounce=0.4} )

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

end

local function onAccelerate( event )
    print( event.name, event.xGravity, event.yGravity, event.zGravity )
end

local function onTilt( event )
    print("onTilt")
    polem.x = polem.x + event.xGravity
    polem.y = polem.y + event.yGravity
 
end
  
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    
    if (phase == "will") then
        
    elseif (phase == "did") then
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
        Runtime:addEventListener( "accelerometer", onTilt )
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