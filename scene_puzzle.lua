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
require 'logger'
require 'vector'
require 'scene_game'

puzzle = Gamestate.new()


function puzzle.enter(self, pre)
  
  love.graphics.setBackgroundColor(20, 20, 35)
  
  local position = vector(300, 300)
  
  puzzle.frame = PuzzleFrame()
  puzzle.hole = Hole(vector(0, 11))
  
  puzzle.blocks = {}
  puzzle.blocks.active = {}
  puzzle.blocks.dead = {}
  puzzle.blocks.inactive = {}
  
  puzzle.duration = 0 -- A counter for how long it's been since the last block drop
  puzzle.interval = 1 -- The time, in seconds, between block drops
  
  puzzle.difficultyDuration = 0 -- The amount of time spent in the current difficulty level
  puzzle.difficultyInterval = 30 -- The amount of time between ramp-ups in difficulty
  
  puzzle.blockSpawnChance = 4 -- Set to one to spawn a block every time
  
  puzzle.logger = Logger(vector(5, 500))

end

-- A testing function, fills the grid with random blocks
function puzzle.randomboard(self)
  local kind = 'good'
  
  for i = 0, 16 do
    for j = 0, 10 do
      local block = Block(vector(i, j), puzzle.getRandomKind())
      
      if math.random(0, 1) == 1 then
        table.insert(puzzle.blocks.active, block)
      end
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
    if puzzle.hole:moveRight() then
      puzzle.shiftDeadBlocksRight()
    end
    
  elseif key == 'left' then
    if puzzle.hole:moveLeft() then
      puzzle.shiftDeadBlocksLeft()
    end
  
  elseif key == 'd' then
    puzzle.increaseDifficulty()
    
  elseif key == 'escape' then
    love.event.push('q')
  end
  
  
end

function puzzle.shiftDeadBlocksRight()
  for index, block in pairs(puzzle.blocks.dead) do
    block:shiftRight()
  end
end

function puzzle.shiftDeadBlocksLeft()
  for index, block in pairs(puzzle.blocks.dead) do
    block:shiftLeft()
  end
end


function puzzle.update(self, dt)
  puzzle.duration = puzzle.duration + dt
  puzzle.difficultyDuration = puzzle.difficultyDuration + dt
  
  puzzle.logger:update()
  
  if puzzle.difficultyDuration > puzzle.difficultyInterval then
    puzzle.increaseDifficulty()
    puzzle.difficultyDuration = 0
  end
  
  if puzzle.duration > puzzle.interval then

    local toDeactivate = {}
    local toKill = {}
    local droppingCount = 0
    
    -- Process blocks
    for index, block in pairs(puzzle.blocks.active) do
      block:update()


      -- Remove offscreen
      if block:isOffscreen() then
        table.insert(toDeactivate, index)

      elseif block.state == 'dropping' then
        -- check to see if this block has hit the floor or a dead block
        if puzzle.positionIsDead(block.position) then
          -- Move it back up one, colllide!
          block.position.y = block.position.y - 1
          
          -- is it a good block, or a bad one?
          if block.kind == 'good' then
            puzzle.addPoints(10)
          else 
            puzzle.subtractPoints(10)
          end
          block:setState('dead')
          table.insert(toKill, index)
        else
          -- Tally the number of dropping blocks
          droppingCount = droppingCount + 1
        end
      end

    end

    -- Remove blocks marked for removal
    -- for i, index in pairs(toDeactivate) do
    --   puzzle.deactivateBlock(index)
    -- end
    for i, index in pairs(toKill) do
      puzzle.killBlock(index)
    end
    
    -- Should we spawn a new block?
    if droppingCount < 1 then
      puzzle.addBlock()
    elseif droppingCount < 4 and math.random(0, puzzle.blockSpawnChance) == 0 then
      puzzle.addBlock()
    end
    
    puzzle.duration = 0
  end
  
  if #puzzle.blocks.dead > 69 then
    puzzle.morph()
  end
  
  puzzle.logger:addLine(string.format("Active: %i", #puzzle.blocks.active))
  puzzle.logger:addLine(string.format("Dead: %i", #puzzle.blocks.dead))
  puzzle.logger:addLine(string.format("Inactive: %i", #puzzle.blocks.inactive))
end

function puzzle.morph()
  Gamestate.switch(mygame)
end

function puzzle.increaseDifficulty()
  puzzle.interval = puzzle.interval - 0.1
  if puzzle.interval < 0.1 then
    puzzle.interval = 0.1
  end
  
  puzzle.blockSpawnChance = puzzle.blockSpawnChance - 1
  if puzzle.blockSpawnChance < 1 then
    puzzle.blockSpawnChance = 1
  end
end

function puzzle.deactivateBlock(index)
  block = table.remove(puzzle.blocks.active, index)
  table.insert(puzzle.blocks.inactive, block)
end

function puzzle.killBlock(index)
  block = table.remove(puzzle.blocks.active, index)
  table.insert(puzzle.blocks.dead, block)
end


function puzzle.addBlock()
  local x = math.random(0, 16)

  local block = {}

  if #puzzle.blocks.inactive == 0 then
    block = Block(vector(x, 0), puzzle.getRandomKind())
  else
    block = table.remove(puzzle.blocks.inactive)
    block:reset(vector(x, 0), puzzle.getRandomKind())
  end
  
  table.insert(puzzle.blocks.active, block)
end

-- Returns true if the supplied vector contains a dead block or the floor
function puzzle.positionIsDead(pos)
  if pos.y == 11 and not puzzle.hole:positionIsInHole(pos) then
    return true
  end 
  
  for index, block in pairs(puzzle.blocks.dead) do
    if pos.x == block.position.x and pos.y == block.position.y then
      return true
    end
  end
  
  return false
  
end

function puzzle.addPoints(points)
  score = score + points
end

function puzzle.subtractPoints(points)
  score = score - points
  if score < 0 then
    score = 0
  end
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

  for index, block in pairs(puzzle.blocks.dead) do
    block:draw()
  end
  
  puzzle.hole:draw()
  
  puzzle.logger:draw()
end


function puzzle.leave()

end
