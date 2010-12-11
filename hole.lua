-- 
--  hole.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Hole = class(function(hole, pos)
    hole.position = pos
    hole.scale = vector(2.0, 2.0)
  
    hole.color = {
      r = 255,
      g = 140,
      b = 0,
      a = 255,
    }
    
    hole.image = graphics.hole
    
    hole.offset = vector(hole.image:getWidth() / 2, hole.image:getHeight() / 2) 

  end)
  
  
function Hole:draw()
  -- These are offsets to shift the entire board
  local x_offset = 150
  local y_offset = 100
  
  local image = self.image
  local color = self.color
  
  love.graphics.setColor(
    color.r,
    color.g,
    color.b,
    color.a
    )
  
  love.graphics.draw(
    image,
    math.floor(self.position.x * (16 * self.scale.x)) + x_offset,
    math.floor(self.position.y * (16 * self.scale.y)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )
end