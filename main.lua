-- 
--  main.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'scene_game'


function love.load()
  love.graphics.setCaption('Reddit Game Jam 04')
  
  -- Preload resources
  graphics = {
    playerWalkA = love.graphics.newImage('resources/player-walk-a.png'),
    playerWalkB = love.graphics.newImage('resources/player-walk-b.png'),
  }
  
  Gamestate.registerEvents()
  Gamestate.switch(mygame)
end

function love.update(dt)
end