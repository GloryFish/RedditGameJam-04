-- 
--  scene_puzzle.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'puzzle_frame'
require 'block'
require 'hole'
require 'vector'

puzzle = Gamestate.new()


function puzzle.enter(self, pre)
  
  love.graphics.setBackgroundColor(20, 20, 35)
  
  local position = vector(300, 300)
  
  puzzle.frame = PuzzleFrame()
  puzzle.hole = Hole(vector(0, 11))
  
  
  puzzle.blocks = {}
  puzzle.blocks.active = {}
  puzzle.blocks.inactive = {}
  
  puzzle.randomboard()

end

-- A testing function, fills the grid with random blocks
function puzzle.randomboard(self)
  local block = {}
  local kind = 'good'
  
  for i = 0, 16 do
    for j = 0, 10 do
      block = Block(vector(i, j), puzzle.getRandomKind())
      table.insert(puzzle.blocks.active, block)
    end
  end
  
  
  
end

function puzzle.getRandomKind()
  if math.random(0,1) == 0 then
    return 'good'
  else
    return 'bad'
  end
end


function puzzle.keypressed(self, key, unicode)
  if key == 'right' then
    puzzle.hole:moveRight()
  elseif key == 'left' then
    puzzle.hole:moveLeft()
  end
end


function puzzle.update(self, dt)
  
end


function puzzle.draw(self)
  love.graphics.setColor(200, 200, 200, 255)
  love.graphics.setFont(fonts.default)

  love.graphics.print('PuzzleDrop', 30, 10)
  local scoreLine = string.format('Score: %i', score)
  local scoreLineWidth = fonts.default:getWidth(scoreLine)
  
  love.graphics.print(scoreLine,
                      love.graphics.getWidth() - 30 - scoreLineWidth,
                      10)

  puzzle.frame:draw()

  for index, block in pairs(puzzle.blocks.active) do
    block:draw()
  end
  
  puzzle.hole:draw()
  
end


function puzzle.leave()

end
