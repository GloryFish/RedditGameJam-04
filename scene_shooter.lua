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


function shooter.enter(self, pre)
  shooter.logger = Logger(vector(5, 50))
  
  local position = vector(300, 300)
  shooter.player = Player(position)
  
  
end


function shooter.update(self, dt)
  shooter.logger:update()
  shooter.logger:addLine('Logger test')
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