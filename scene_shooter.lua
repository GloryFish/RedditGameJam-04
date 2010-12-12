-- 
--  scene_shooter.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'player'
require 'vector'

shooter = Gamestate.new()
shooter.blocks = {}

function shooter.enter(self, pre)
  if #shooter.blocks == 0 then
    -- By default, create a flat line of blocks, for testing
    for x = 0, 16 do
      local block = Block(vector(x, 10), 'good')
      block:setState('dead')
      table.insert(shooter.blocks, block)
    end
    for x = 0, 16, 2 do
      local block = Block(vector(x, 9), 'good')
      block:setState('dead')
      table.insert(shooter.blocks, block)
    end
  end
  
  
  shooter.logger = Logger(vector(20, 50))
  
  shooter.player = Player(vector(200, 200))
  shooter.player:respawn()
  
  shooter.gravity = vector(0, 10)
  
end

function shooter.keypressed(self, key, unicode)
  if key == 'escape' then
    love.event.push('q')
  elseif key == ' ' then
    shooter.player:jump()
  elseif key == 'r' then
    shooter.player:respawn()
  end
end

function shooter.update(self, dt)
  shooter.logger:update()
  
  -- Calculate new player position by generating a movement vector, then adjusting that vector with collisions
  
  -- Apply movement
  if love.keyboard.isDown('right') then
    shooter.player:movingRight()
  elseif love.keyboard.isDown('left') then
    shooter.player:movingLeft()
  else
    shooter.player:notMovingLeftOrRight()
  end

  -- Apply gravity
  local newVelocity = shooter.player.velocity
  newVelocity = newVelocity + shooter.gravity
  
  -- Collide with blocks
  for index, block in pairs(shooter.blocks) do
    newVelocity = block:collideInScreenSpace(shooter.player, newVelocity)
  end
  
  shooter.player.velocity = newVelocity
  
  shooter.player:update(dt)
  
  if shooter.player.onFloor then
    shooter.logger:addLine("On Floor")
  else
    shooter.logger:addLine("NOT On Floor")
  end
    
end

function shooter.draw(self)
  love.graphics.setColor(200, 200, 200, 255)
  love.graphics.setFont(fonts.default)
  
  love.graphics.print('DropBlaster', 20, 20)

  local scoreLine = string.format('Score: %i', score)
  local scoreLineWidth = fonts.default:getWidth(scoreLine)
  
  love.graphics.print(scoreLine,
                      love.graphics.getWidth() - 30 - scoreLineWidth,
                      10)

  shooter.player:draw()
  
  for index, block in pairs(shooter.blocks) do
    block:draw()
  end
  
  shooter.logger:draw()
  
end


function shooter.leave()

end