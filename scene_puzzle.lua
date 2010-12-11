-- 
--  scene_puzzle.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'block'
require 'vector'

puzzle = Gamestate.new()


function puzzle.enter(self, pre)
  local position = vector(300, 300)
  puzzle.block = Block(vector(1,1), 'good')
  puzzle.block1 = Block(vector(1,2), 'good')
  puzzle.block2 = Block(vector(1,3), 'good')
  puzzle.block3 = Block(vector(2,1), 'bad')
  puzzle.block4 = Block(vector(2,2), 'bad')
  puzzle.block5 = Block(vector(2,3), 'good')
  puzzle.block6 = Block(vector(3,1), 'good')
  puzzle.block7 = Block(vector(3,2), 'bad')
  puzzle.block8 = Block(vector(3,3), 'good')
end


function puzzle.update(self, dt)
  
end


function puzzle.draw(self)
  love.graphics.print('PuzzleDrop', 10, 10)


  puzzle.block:draw()
  puzzle.block1:draw()
  puzzle.block2:draw()
  puzzle.block3:draw()
  puzzle.block4:draw()
  puzzle.block5:draw()
  puzzle.block6:draw()
  puzzle.block7:draw()
  puzzle.block8:draw()
  
  
end


function puzzle.leave()

end
