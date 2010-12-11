-- 
--  block.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'class'
require 'vector'

Block = class(function(block, pos, block_kind)
    block.position = pos
    block.scale = vector(2.0, 2.0)
  
    block.color = {
      r = 255,
      g = 255,
      b = 255,
      a = 255,
    }
    
    block.kind = block_kind
    
    block.image = graphics.blockA
    
    block.offset = vector(block.image:getWidth() / 2, block.image:getHeight() / 2) 

  end)
  
  
function Block:draw()
  -- These are offsets to shift the entire board
  local x_offset = 150
  local y_offset = 100
  
  local image = nil
  local color = nil

  if self.kind == 'good' then
    image = graphics.blockA
    color = {
      r = 0,
      g = 255,
      b = 0,
      a = 255,
    }
  else
    image = graphics.blockB
    color = {
      r = 255,
      g = 0,
      b = 0,
      a = 255,
    }
  end
  
  love.graphics.setColor(
    color.r,
    color.g,
    color.b,
    color.a
    )
  
  love.graphics.draw(
    image,
    math.floor(self.position.x * (image:getWidth() * self.scale.x)) + x_offset,
    math.floor(self.position.y * (image:getHeight() * self.scale.y)) + y_offset,
    self.orientation,
    self.scale.x,
    self.scale.y,
    self.offset.x,
    self.offset.y
  )
end