local composer = require("composer")
local scene = composer.newScene()

local forwardButton, dente_leao, dente_leao_pelado, rect, backButton

local function onNextPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_3", "fade")

        return true
    end
end

local function onBackPage(self, event)
    if event.phase == "ended" or event.phase == "cancelled" then
        composer.gotoScene("src.pages.page_1", "fade")

        return true
    end
end

local function listener( event )
    if event.isShake then
        print( "The device is being shaken!" )
        dente_leao_pelado.isVisible = true
        dente_leao.isVisible = false
    end
end

function moveWave()

    local startX = 200
    local startY = 0
    local endX = 700
    local endY = 1000
    local amplitude = 50
    local speed = 100
    local frequency = 0.5
    local obj = rect

    -- Calcula a distância total que o objeto precisa percorrer
    local distance = math.sqrt((endX - startX) ^ 2 + (endY - startY) ^ 2)
    
    -- Define as variáveis iniciais
    local phaseShift = math.pi / 2 -- Inicia a onda com um deslocamento de fase de 90 graus para a esquerda
    local moveRight = true
    local time = distance / speed
    
    -- Define a função de movimento para criar o efeito de onda
    local function waveMovement()
      local progress = obj.distance / distance
      local deltaX = (moveRight and 1 or -1) * speed * obj.dt
      local deltaY = amplitude * math.sin(2 * math.pi * frequency * progress + phaseShift)
      obj.x = startX + deltaX
      obj.y = startY + deltaY
      obj.distance = obj.distance + speed * obj.dt
      
      if obj.distance >= distance then
        -- Conclui o movimento quando o objeto chegar ao destino
        obj.x = endX
        obj.y = endY
        return
      end
      
      -- Define um timer para chamar a função de movimento novamente
      obj.timer = timer.performWithDelay(10, waveMovement)
    end
    
    -- Inicia o movimento
    obj.distance = 0
    obj.dt = 10 / 1000 -- Define o intervalo de tempo em segundos
    obj.timer = timer.performWithDelay(10, waveMovement)
  end
  

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImage(sceneGroup, "src/assets/background/Background_sky.png")
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0
    background.y = 0
    sceneGroup:insert(background)
 
    rect = display.newRect(100, 100, 50, 50)
    sceneGroup:insert(rect)
    

    local text = display.newImage(sceneGroup, "src/assets/textos/text_page2.png")
    text.x = display.contentWidth * 1/2
    text.y = display.contentHeight * 2/14
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
    dente_leao_pelado.isVisible = false
    sceneGroup:insert(dente_leao_pelado)

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

    elseif (phase == "did") then
        forwardButton.touch = onNextPage
        forwardButton:addEventListener("touch", forwardButton)
        backButton.touch = onBackPage
        backButton:addEventListener("touch", backButton)
        Runtime:addEventListener( "accelerometer", listener )
        Runtime:addEventListener("enterFrame", moveWave)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        forwardButton:removeEventListener("touch", forwardButton)
        Runtime:removeEventListener("accelerometer", listener)
    elseif (phase == "did") then

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene