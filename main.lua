-- 
--  main.lua
--  redditgamejam-04
--  
--  Created by Jay Roberts on 2010-12-10.
--  Copyright 2010 GloryFish.org. All rights reserved.
-- 

require 'gamestate'
require 'scene_puzzle'


function love.load()
  love.graphics.setCaption('Reddit Game Jam 04')
  
  -- Preload resources
  graphics = {
    playerWalkA = love.graphics.newImage('resources/player-walk-a.png'),
    playerWalkB = love.graphics.newImage('resources/player-walk-b.png'),
    blockA = love.graphics.newImage('resources/block-a.png'),
    blockB = love.graphics.newImage('resources/block-b.png'),
  }
  
  -- Don't blur the sprites
  graphics.blockA:setFilter('nearest', 'nearest')
  graphics.blockB:setFilter('nearest', 'nearest')
  
  Gamestate.registerEvents()
  Gamestate.switch(puzzle)
end

function love.update(dt)
end