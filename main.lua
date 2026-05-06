local push = require 'push'

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- add seed to randoms so random always random
  -- os.time() always increments so each load will be different
  math.randomseed(os.time())

  LargeFont = love.graphics.newFont('m3x6.ttf', 48)
  SmallFont = love.graphics.newFont('m3x6.ttf', 16)

  --realRes
  WIN_WIDTH = 1280
  WIN_HEIGHT = 720

  --virtualRes
  VIR_WIDTH = 432
  VIR_HEIGHT = 243

  push:setupScreen(VIR_WIDTH, VIR_HEIGHT, WIN_WIDTH, WIN_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  --playerPaddle
  Xp1 = 10
  Yp1 = VIR_HEIGHT / 2 - 15

  --opponentPaddle
  Xp2 = VIR_WIDTH - 15
  Yp2 = VIR_HEIGHT / 2 - 15

  InitBall()

  PaddleSpeed = 175

  GameState = 'start'
end

function DrawEntities()
  --score
  PlayerScore = 0
  OpponentScore = 0
  love.graphics.clear(58 / 255, 45 / 255, 82 / 255, 1)
  love.graphics.setFont(LargeFont)
  if GameState == 'play' then
    love.graphics.print(tostring(PlayerScore), VIR_WIDTH / 2 - 40, VIR_HEIGHT / 2 - 90)
    love.graphics.print(tostring(OpponentScore), VIR_WIDTH / 2 + 30, VIR_HEIGHT / 2 - 90)
  else
    love.graphics.setFont(SmallFont)
    love.graphics.printf('Press "Enter" to Start Game', 0, 20, VIR_WIDTH, "center")
  end


  --left paddle
  love.graphics.rectangle('fill', Xp1, Yp1, 5, 30)

  --right paddle
  love.graphics.rectangle('fill', Xp2, Yp2, 5, 30)

  --ball
  love.graphics.rectangle('fill', BallX, BallY, 4, 4)
end

function InitBall()
  BallX = VIR_WIDTH / 2 - 2
  BallY = VIR_HEIGHT / 2 - 2

  -- this randomizes the side either left(-100) or right(100) of where the ball is going to
  BallDX = math.random(2) == 1 and 100 or -100

  -- this randomizes the direction of the ball
  BallDY = math.random(-50, 50) * 1.5
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if GameState == 'start' then
      GameState = 'play'
    else
      GameState = 'start'
      InitBall()
    end
  end
end

function love.draw()
  push:start()
  DrawEntities()
  push:finish()
end

function love.update(dt)
  if love.keyboard.isDown("w") then
    Yp1 = math.max(0, Yp1 - PaddleSpeed * dt)
  elseif love.keyboard.isDown("s") then
    Yp1 = math.min(VIR_HEIGHT - 30, Yp1 + PaddleSpeed * dt)
  end

  if love.keyboard.isDown("up") then
    Yp2 = math.max(0, Yp2 - PaddleSpeed * dt)
  end

  if love.keyboard.isDown("down") then
    Yp2 = math.min(VIR_HEIGHT - 30, Yp2 + PaddleSpeed * dt)
  end

  if GameState == 'play' then
    BallX = BallX + BallDX * dt
    BallY = BallY + BallDY * dt
  end
end
