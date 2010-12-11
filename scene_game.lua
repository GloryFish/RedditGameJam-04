-- 
--  scene_gane.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'player'
require 'vector'

mygame = Gamestate.new()


function mygame.enter(self, pre)
  local position = vector(300, 300)
  mygame.player = Player(position)
end


function mygame.update(self, dt)
  
end


function mygame.draw(self)
  love.graphics.print('Hello world', 20, 20)

  mygame.player:draw()
  
  
end


function mygame.leave()

end