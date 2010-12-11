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
  
  -- Seed random
  local seed = os.time()
  math.randomseed(seed);
  math.random(); math.random(); math.random()  
  
  -- Preload resources
  graphics = {
    playerWalkA = love.graphics.newImage('resources/player-walk-a.png'),
    playerWalkB = love.graphics.newImage('resources/player-walk-b.png'),
    blockA = love.graphics.newImage('resources/block-a.png'),
    blockB = love.graphics.newImage('resources/block-b.png'),
    hole = love.graphics.newImage('resources/hole.png'),
    vertical = love.graphics.newImage('resources/vertical.png'),
    horizontal = love.graphics.newImage('resources/horizontal.png'),
    corner = love.graphics.newImage('resources/corner.png'),
  }
  
  -- Don't blur the sprites
  for index, image in pairs(graphics) do
    image:setFilter('nearest', 'nearest')
  end
  
  fonts = {
    default = love.graphics.newFont('resources/fonts/silk.ttf', 24)
  }

  -- constants
  boardOffset = {
    x = 140,
    y = 100
  }

  score = 0

  
  Gamestate.registerEvents()
  Gamestate.switch(puzzle)
end

function love.update(dt)
end