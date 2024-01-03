-- Code for mining a 3x3 tunnel with a mining turtle
-- Collects only specific ores and drops the rest
-- Checks for fuel and refuels if necessary

-- Dig a row of 3 blocks
function digRow()
  turtle.turnRight()
  if turtle.detect() then
    turtle.dig()
  end
  turtle.turnLeft()
  turtle.turnLeft()
  if turtle.detect() then
    turtle.dig()
  end
  turtle.turnRight()
end

-- Dig 3x3x1 blocks from bottom to top
function digBottomUp()
  if turtle.detect() then
    turtle.dig()
  end  
  turtle.forward()

  digRow()
  if turtle.detectUp() then
    turtle.digUp()
  end
  turtle.up()

  digRow()
  if turtle.detectUp() then
    turtle.digUp()
  end
  turtle.up()

  digRow()
end

-- Dig 3x3x1 blocks from top to bottom
function digTopBottom()
  if turtle.detect() then
    turtle.dig()
  end
  turtle.forward()

  digRow()
  if turtle.detectDown() then
    turtle.digDown()
  end
  turtle.down()

  digRow()
  if turtle.detectDown() then
    turtle.digDown()
  end
  turtle.down()

  digRow()
end

-- Refuel if fuel level is below 6
function refuel()
  if turtle.getFuelLevel() < 6 then
    -- Check for fuel in inventory
    for i = 1,16 do
      if turtle.getItemCount(i) > 0 then 
        turtle.select(i)
        if turtle.refuel(1) then 
          break
        end
      end
    end
  end
  turtle.select(1)
end

function noStone()
  for i = 1,16 do
    if turtle.getItemDetail(i) ~= nil then
      -- Drop all unwanted items
      if 
        turtle.getItemDetail(i).name ~= "minecraft:diamond" and 
        turtle.getItemDetail(i).name ~= "minecraft:emerald" and 
        turtle.getItemDetail(i).name ~= "minecraft:coal" and 
        turtle.getItemDetail(i).name ~= "minecraft:gravel" and 
        turtle.getItemDetail(i).name ~= "minecraft:sand" and 
        turtle.getItemDetail(i).name ~= "minecraft:clay" and 
        turtle.getItemDetail(i).name ~= "minecraft:iron_ore" and 
        turtle.getItemDetail(i).name ~= "minecraft:gold_ore" and 
        turtle.getItemDetail(i).name ~= "bigreactors:oreyellorite"
      then
        turtle.select(i)
        turtle.drop()
      end
    end
  end
  turtle.select(1)
end

-- Main loop
while (true) do
  -- Refuel and drop unwanted items
  refuel()
  noStone()

  -- Dig 3x3x1 blocks from bottom to top
  digBottomUp()
  -- Since the turtle is now left at the top
  -- dig 3x3x1 blocks from top to bottom 
  -- to minimize the number of moves of the turtle 
  -- (rotation and digging do no cost fuel)
  digTopBottom()
end
