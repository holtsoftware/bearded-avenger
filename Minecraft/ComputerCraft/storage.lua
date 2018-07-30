local chest1, chest2, pipe, ladder = 1, 2, 3, 4
local lend = false

function forward()
	while turtle.attack() do
	end
	turtle.forward()
end
 
function clearLine()
    for f=0,3 do
        if turtle.detect() then
            turtle.dig()
        end
        forward()
    end
end
 
function turnRight()
    turtle.turnRight()
    if turtle.detect() then
        turtle.dig()
    end
    forward()
end
 
function turnLeft()
    turtle.turnLeft()
    if turtle.detect() then
        turtle.dig()
    end
    forward()
end
 
function clear()
    clearLine()
    turnRight()
    turtle.turnRight()
    clearLine()
    turnLeft()
    turtle.turnLeft()
    clearLine()
    turnRight()
    turtle.turnRight()
    clearLine()
    turnLeft()
    turtle.turnLeft()
    clearLine()
end

function clearGotoStart()
	turtle.turnLeft();
	turtle.turnLeft();
	for v=0,3 do
		turtle.forward()
	end
	turtle.turnRight();
	for q=0,3 do
		turtle.forward()
	end
	turtle.turnRight();
end

function goDown()
	local success, data = turtle.inspectDown()

	if success and data.name == "minecraft:bedrock" then
		lend = true
		print("hit bedrock")
	elseif turtle.detectDown() then
		turtle.digDown()
		turtle.down()
	else
		turtle.down()
	end
end

function selectItem(name)
	for i=1,16 do
		turtle.select(i)
		local data = turtle.getItemDetail()
		if data and data.name == name then
			return
		end
	end
end

function selectChest()
	selectItem("minecraft:chest")
end

function selectLadder()
	selectItem("minecraft:ladder")
end

function selectPipe()
	selectItem("ExtraUtilities:pipes")
end

function selectGlowstone()
	selectItem("minecraft:glowstone")
end


function placeChestLayer()
	--- Line 1
	selectChest()
	forward()
	forward()
	turtle.placeUp()
	forward()
	forward()
	selectLadder()
	turtle.placeUp()
	turtle.turnRight()
	forward()
	turtle.turnRight()
	turtle.turnRight()
	turtle.place()
	turtle.turnLeft()
	--- Line 2
	forward()
	selectGlowstone()
	turtle.placeUp()
	forward()
	selectChest()
	turtle.placeUp()
	forward()
	forward()
	turtle.turnLeft()
	forward()
	turtle.turnLeft()
	--- Line 3
	selectChest()
	turtle.placeUp()
	forward()
	turtle.placeUp()
	forward()
	selectPipe()
	turtle.placeUp()
	forward()
	turtle.turnRight()
	turtle.turnRight()
	turtle.place()
	turtle.turnLeft()
	turtle.turnLeft()
	selectChest()
	turtle.placeUp()
	forward()
	turtle.placeUp()
	forward()
	turtle.turnRight()
	forward()
	turtle.turnRight()
	--- Line 4
	forward()
	forward()
	selectChest()
	turtle.placeUp()
	forward()
	selectGlowstone()
	turtle.placeUp()
	forward()
	turtle.turnLeft()
	forward()
	turtle.turnLeft()
	--- Line 5
	selectChest()
	forward()
	forward()
	turtle.placeUp()
	forward()
	forward()
end
 
while not lend do
	clear()
	clearGotoStart()
	goDown()
	if not lend then
		clear()
		clearGotoStart()
		placeChestLayer()
		clearGotoStart()
		goDown()
	end
end