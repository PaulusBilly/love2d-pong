local push = require 'push'

WIN_WIDTH = 1280
WIN_HEIGHT = 720

VIR_WIDTH = 432
VIR_HEIGHT = 243

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  -- love.window.setMode(WIN_WIDTH, WIN_HEIGHT, {
  --   fullscreen = false,
  --   resizable = false,
  --   vsync = true
  -- })
  largeFont = love.graphics.newFont('m3x6.ttf', 48)
  smallFont = love.graphics.newFont('m3x6.ttf', 16)
  push:setupScreen(VIR_WIDTH, VIR_HEIGHT, WIN_WIDTH, WIN_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  xp1 = 10
  yp1 = VIR_HEIGHT / 2 - 15

  xp2 = VIR_WIDTH - 15
  yp2 = VIR_HEIGHT / 2 - 15
end

function drawEntities()
  --score
  playerScore = 0
  opponentScore = 0
  love.graphics.clear(58 / 255, 45 / 255, 82 / 255, 1)
  love.graphics.setFont(largeFont)
  love.graphics.print(tostring(playerScore), VIR_WIDTH / 2 - 40, VIR_HEIGHT / 2 - 90)
  love.graphics.print(tostring(opponentScore), VIR_WIDTH / 2 + 30, VIR_HEIGHT / 2 - 90)

  --left paddle
  love.graphics.rectangle('fill', xp1, yp1, 5, 30)

  --right paddle
  love.graphics.rectangle('fill', xp2, yp2, 5, 30)

  --ball
  love.graphics.rectangle('fill', VIR_WIDTH / 2 - 2, VIR_HEIGHT / 2 - 2, 4, 4)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  push:start()
  drawEntities()
  push:finish()
end

function love.update()
  if love.keyboard.isDown("w") then
    yp1 = yp1 - 1 * 1.75
  end

  if love.keyboard.isDown("s") then
    yp1 = yp1 + 1 * 1.75
  end

  if love.keyboard.isDown("up") then
    yp2 = yp2 - 1 * 1.75
  end

  if love.keyboard.isDown("down") then
    yp2 = yp2 + 1 * 1.75
  end
end
