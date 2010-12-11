-- 
--  player.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Player = class(function(player, pos)
    player.position = pos
    player.scale = vector(1.0, 1.0)
  
    player.color = {
      r = 255,
      g = 140,
      b = 0,
      a = 255,
    }
    
    player.image = graphics.playerWalkA
    
    player.offset = vector(player.image:getWidth() / 2, player.image:getHeight() / 2) 
    player.size = vector(player.image:getWidth(), player.image:getHeight())
    
    player.runningSpeed = 40

  end)

function Player:respawn()
  self.position = vector(math.random(200, 400), 200)
end

function Player:getRightScreenEdge()
  return self.position.x + self.size.x
end

function Player:getLeftScreenEdge()
  return self.position.x
end

function Player:getTopScreenEdge()
  return self.position.y - self.size.y
end

function Player:getBottomScreenEdge()
  return self.position.y + self.size.y
end
  
function Player:draw()
  local image = self.image
  
  love.graphics.draw(
    image,
    math.floor(self.position.x),
    math.floor(self.position.y),
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )
end