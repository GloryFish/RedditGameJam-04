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
    block.state = 'dropping'
    
    block.image = graphics.blockA
    
    block.offset = vector(block.image:getWidth() / 2, block.image:getHeight() / 2) 

  end)

function Block:reset(pos, block_kind)
    self.kind = block_kind
    self.position = pos
    self.state = 'dropping'
end

function Block:update()
  if self.state == 'dropping' then
    self.position.y = self.position.y + 1
  end
end
  
function Block:draw()
  -- These are offsets to shift the entire board
  local x_offset = boardOffset.x
  local y_offset = boardOffset.y
  
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

  if self.state == 'dead' then
    color = {
      r = 100,
      g = 100,
      b = 100,
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

function Block:setState(state)
  self.state = state
end

function Block:isOffscreen()
  return self.position.y * (self.image:getHeight() * self.scale.y) + boardOffset.y > love.graphics:getHeight()
end